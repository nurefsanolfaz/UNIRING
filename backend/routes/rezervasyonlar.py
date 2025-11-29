"""
UNIRING - Rezervasyon Routes
Rezervasyon oluşturma, onaylama, iptal etme işlemleri
"""

from flask import Blueprint, request, jsonify
from models import db, Rezervasyonlar, Seferler, Kullanicilar, SeferGuzergahNoktalari, Odemeler
from datetime import datetime

bp = Blueprint('rezervasyonlar', __name__, url_prefix='/api/rezervasyonlar')


# ============================================
# 1. TÜM REZERVASYONLARI LİSTELE
# ============================================
@bp.route('/', methods=['GET'])
def get_rezervasyonlar():
    """
    Tüm rezervasyonları listele (filtreleme ile)
    Query params: yolcu_id, sefer_id, durum
    """
    try:
        # Query parametreleri
        yolcu_id = request.args.get('yolcu_id', type=int)
        sefer_id = request.args.get('sefer_id', type=int)
        durum = request.args.get('durum')
        
        # Base query
        query = Rezervasyonlar.query
        
        # Filtreleme
        if yolcu_id:
            query = query.filter_by(yolcuID=yolcu_id)
        
        if sefer_id:
            query = query.filter_by(seferID=sefer_id)
        
        if durum:
            query = query.filter_by(durum=durum)
        
        # Sıralama: En yeni önce
        rezervasyonlar = query.order_by(Rezervasyonlar.olusturulmaTarihi.desc()).all()
        
        return jsonify({
            'rezervasyonlar': [rez.to_dict() for rez in rezervasyonlar],
            'count': len(rezervasyonlar)
        }), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500


# ============================================
# 2. YENİ REZERVASYON OLUŞTUR
# ============================================
@bp.route('/', methods=['POST'])
def create_rezervasyon():
    """
    Yeni rezervasyon oluştur
    Body: {
        seferID, yolcuID, binisNoktaID, inisNoktaID,
        yolcuSayisi, hesaplananUcret
    }
    """
    try:
        data = request.get_json()
        
        # Sefer kontrolü
        sefer = Seferler.query.get(data.get('seferID'))
        if not sefer:
            return jsonify({'error': 'Sefer bulunamadı'}), 404
        
        # Kapasite kontrolü
        yolcu_sayisi = data.get('yolcuSayisi', 1)
        if sefer.mevcutDoluluk + yolcu_sayisi > sefer.maxKapasite:
            return jsonify({'error': 'Sefer kapasitesi dolu'}), 400
        
        # Kullanıcı kontrolü
        yolcu = Kullanicilar.query.get(data.get('yolcuID'))
        if not yolcu:
            return jsonify({'error': 'Kullanıcı bulunamadı'}), 404
        
        # Kendi seferine rezervasyon yapamaz
        if sefer.olusturanKullaniciID == yolcu.kullaniciID:
            return jsonify({'error': 'Kendi seferinize rezervasyon yapamazsınız'}), 400
        
        # Biniş ve iniş noktaları kontrolü
        binis_nokta = SeferGuzergahNoktalari.query.get(data.get('binisNoktaID'))
        inis_nokta = SeferGuzergahNoktalari.query.get(data.get('inisNoktaID'))
        
        if not binis_nokta or not inis_nokta:
            return jsonify({'error': 'Güzergah noktaları bulunamadı'}), 404
        
        if binis_nokta.seferID != sefer.seferID or inis_nokta.seferID != sefer.seferID:
            return jsonify({'error': 'Güzergah noktaları bu sefere ait değil'}), 400
        
        if binis_nokta.siraNo >= inis_nokta.siraNo:
            return jsonify({'error': 'Biniş noktası iniş noktasından önce olmalı'}), 400
        
        # Ücret hesaplama
        hesaplanan_ucret = float(data.get('hesaplananUcret', sefer.temelFiyat))
        indirim = float(data.get('indirimMiktari', 0))
        odenecek_tutar = hesaplanan_ucret - indirim
        
        # Yeni rezervasyon oluştur
        yeni_rezervasyon = Rezervasyonlar(
            seferID=sefer.seferID,
            yolcuID=yolcu.kullaniciID,
            binisNoktaID=binis_nokta.noktaID,
            inisNoktaID=inis_nokta.noktaID,
            yolcuSayisi=yolcu_sayisi,
            hesaplananUcret=hesaplanan_ucret,
            indirimMiktari=indirim,
            odenecekTutar=odenecek_tutar,
            durum='Beklemede'
        )
        
        db.session.add(yeni_rezervasyon)
        
        # Sefer doluluk güncelle (henüz onaylanmadı, ama yer ayır)
        sefer.mevcutDoluluk += yolcu_sayisi
        
        db.session.commit()
        
        return jsonify({
            'message': 'Rezervasyon başarıyla oluşturuldu',
            'rezervasyon': yeni_rezervasyon.to_dict()
        }), 201
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500


# ============================================
# 3. REZERVASYON DETAYI
# ============================================
@bp.route('/<int:rezervasyon_id>', methods=['GET'])
def get_rezervasyon(rezervasyon_id):
    """Tek bir rezervasyonun detaylarını getir"""
    try:
        rezervasyon = Rezervasyonlar.query.get_or_404(rezervasyon_id)
        
        # İlişkili verileri ekle
        rez_dict = rezervasyon.to_dict()
        
        # Sefer bilgisi
        sefer = Seferler.query.get(rezervasyon.seferID)
        rez_dict['sefer'] = sefer.to_dict() if sefer else None
        
        # Yolcu bilgisi
        yolcu = Kullanicilar.query.get(rezervasyon.yolcuID)
        rez_dict['yolcu'] = yolcu.to_dict() if yolcu else None
        
        # Biniş ve iniş noktaları
        binis = SeferGuzergahNoktalari.query.get(rezervasyon.binisNoktaID)
        inis = SeferGuzergahNoktalari.query.get(rezervasyon.inisNoktaID)
        rez_dict['binisNoktasi'] = binis.to_dict() if binis else None
        rez_dict['inisNoktasi'] = inis.to_dict() if inis else None
        
        return jsonify(rez_dict), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500


# ============================================
# 4. REZERVASYON ONAYLA (Organizatör)
# ============================================
@bp.route('/<int:rezervasyon_id>/onayla', methods=['PUT'])
def onayla_rezervasyon(rezervasyon_id):
    """
    Rezervasyonu onayla (Sadece organizatör)
    Body: { organizatorID }
    """
    try:
        data = request.get_json()
        organizator_id = data.get('organizatorID')
        
        rezervasyon = Rezervasyonlar.query.get_or_404(rezervasyon_id)
        sefer = Seferler.query.get(rezervasyon.seferID)
        
        # Organizatör kontrolü
        if sefer.olusturanKullaniciID != organizator_id:
            return jsonify({'error': 'Bu işlem için yetkiniz yok'}), 403
        
        # Durum kontrolü
        if rezervasyon.durum != 'Beklemede':
            return jsonify({'error': 'Bu rezervasyon zaten işleme alınmış'}), 400
        
        # Rezervasyonu onayla
        rezervasyon.durum = 'Onaylandı'
        rezervasyon.onaylanmaTarihi = datetime.utcnow()
        
        # Ödeme kaydı oluştur
        yeni_odeme = Odemeler(
            rezervasyonID=rezervasyon.rezervasyonID,
            seferID=sefer.seferID,
            borcluID=rezervasyon.yolcuID,
            alacakliID=sefer.olusturanKullaniciID,
            tutar=rezervasyon.odenecekTutar,
            platformKomisyonu=rezervasyon.odenecekTutar * 0.05,  # %5 komisyon
            netTutar=rezervasyon.odenecekTutar * 0.95,
            odemeTipi='Cüzdan',
            odemeDurumu='Ödenmedi'
        )
        db.session.add(yeni_odeme)
        
        db.session.commit()
        
        return jsonify({
            'message': 'Rezervasyon onaylandı',
            'rezervasyon': rezervasyon.to_dict()
        }), 200
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500


# ============================================
# 5. REZERVASYON REDDET (Organizatör)
# ============================================
@bp.route('/<int:rezervasyon_id>/reddet', methods=['PUT'])
def reddet_rezervasyon(rezervasyon_id):
    """
    Rezervasyonu reddet
    Body: { organizatorID, iptalNedeni }
    """
    try:
        data = request.get_json()
        organizator_id = data.get('organizatorID')
        iptal_nedeni = data.get('iptalNedeni', 'Belirtilmedi')
        
        rezervasyon = Rezervasyonlar.query.get_or_404(rezervasyon_id)
        sefer = Seferler.query.get(rezervasyon.seferID)
        
        # Organizatör kontrolü
        if sefer.olusturanKullaniciID != organizator_id:
            return jsonify({'error': 'Bu işlem için yetkiniz yok'}), 403
        
        # Durum kontrolü
        if rezervasyon.durum != 'Beklemede':
            return jsonify({'error': 'Bu rezervasyon zaten işleme alınmış'}), 400
        
        # Rezervasyonu reddet
        rezervasyon.durum = 'Reddedildi'
        rezervasyon.iptalNedeni = iptal_nedeni
        
        # Sefer doluluk güncelle (yeri geri ver)
        sefer.mevcutDoluluk -= rezervasyon.yolcuSayisi
        
        db.session.commit()
        
        return jsonify({
            'message': 'Rezervasyon reddedildi',
            'rezervasyon': rezervasyon.to_dict()
        }), 200
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500


# ============================================
# 6. REZERVASYON İPTAL (Yolcu)
# ============================================
@bp.route('/<int:rezervasyon_id>/iptal', methods=['PUT'])
def iptal_rezervasyon(rezervasyon_id):
    """
    Rezervasyonu iptal et (Yolcu tarafından)
    Body: { yolcuID, iptalNedeni }
    """
    try:
        data = request.get_json()
        yolcu_id = data.get('yolcuID')
        iptal_nedeni = data.get('iptalNedeni', 'Kullanıcı isteği')
        
        rezervasyon = Rezervasyonlar.query.get_or_404(rezervasyon_id)
        sefer = Seferler.query.get(rezervasyon.seferID)
        
        # Yolcu kontrolü
        if rezervasyon.yolcuID != yolcu_id:
            return jsonify({'error': 'Bu işlem için yetkiniz yok'}), 403
        
        # Durum kontrolü
        if rezervasyon.durum in ['İptal Edildi', 'Reddedildi', 'Tamamlandı']:
            return jsonify({'error': 'Bu rezervasyon iptal edilemez'}), 400
        
        # Rezervasyonu iptal et
        rezervasyon.durum = 'İptal Edildi'
        rezervasyon.iptalNedeni = iptal_nedeni
        
        # Sefer doluluk güncelle
        sefer.mevcutDoluluk -= rezervasyon.yolcuSayisi
        
        # Eğer ödeme yapılmışsa iade işlemi
        odeme = Odemeler.query.filter_by(rezervasyonID=rezervasyon_id).first()
        if odeme and odeme.odemeDurumu == 'Ödendi':
            odeme.odemeDurumu = 'İade Edildi'
        
        db.session.commit()
        
        return jsonify({
            'message': 'Rezervasyon iptal edildi',
            'rezervasyon': rezervasyon.to_dict()
        }), 200
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500


# ============================================
# 7. KULLANICININ TÜM REZERVASYONLARI
# ============================================
@bp.route('/kullanici/<int:kullanici_id>', methods=['GET'])
def get_kullanici_rezervasyonlari(kullanici_id):
    """Bir kullanıcının tüm rezervasyonlarını getir"""
    try:
        rezervasyonlar = Rezervasyonlar.query.filter_by(yolcuID=kullanici_id).order_by(
            Rezervasyonlar.olusturulmaTarihi.desc()
        ).all()
        
        # Sefer bilgilerini de ekle
        result = []
        for rez in rezervasyonlar:
            rez_dict = rez.to_dict()
            sefer = Seferler.query.get(rez.seferID)
            rez_dict['sefer'] = sefer.to_dict() if sefer else None
            result.append(rez_dict)
        
        return jsonify({
            'rezervasyonlar': result,
            'count': len(result)
        }), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500


# ============================================
# 8. BİR SEFERİN TÜM REZERVASYONLARI
# ============================================
@bp.route('/sefer/<int:sefer_id>', methods=['GET'])
def get_sefer_rezervasyonlari(sefer_id):
    """Bir seferin tüm rezervasyonlarını getir (Organizatör için)"""
    try:
        # Sefer kontrolü
        sefer = Seferler.query.get_or_404(sefer_id)
        
        rezervasyonlar = Rezervasyonlar.query.filter_by(seferID=sefer_id).order_by(
            Rezervasyonlar.olusturulmaTarihi.desc()
        ).all()
        
        # Yolcu bilgilerini de ekle
        result = []
        for rez in rezervasyonlar:
            rez_dict = rez.to_dict()
            yolcu = Kullanicilar.query.get(rez.yolcuID)
            rez_dict['yolcu'] = yolcu.to_dict() if yolcu else None
            result.append(rez_dict)
        
        return jsonify({
            'seferID': sefer_id,
            'rezervasyonlar': result,
            'count': len(result),
            'mevcutDoluluk': sefer.mevcutDoluluk,
            'maxKapasite': sefer.maxKapasite
        }), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500