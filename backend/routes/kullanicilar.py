"""
UNIRING - Kullanıcı Routes
Profil görüntüleme, güncelleme işlemleri
"""

from flask import Blueprint, request, jsonify
from models import db, Kullanicilar, Universiteler, Araclar, Cuzdanlar
from datetime import datetime

bp = Blueprint('kullanicilar', __name__, url_prefix='/api/kullanicilar')


# ============================================
# 1. KULLANICI PROFİLİ GÖRÜNTÜLE
# ============================================
@bp.route('/<int:kullanici_id>', methods=['GET'])
def get_kullanici(kullanici_id):
    """Kullanıcı profil bilgilerini getir"""
    try:
        kullanici = Kullanicilar.query.get_or_404(kullanici_id)
        
        # Kullanıcı bilgileri
        kullanici_dict = kullanici.to_dict()
        
        # Üniversite bilgisi ekle
        universite = Universiteler.query.get(kullanici.universiteID)
        kullanici_dict['universite'] = universite.to_dict() if universite else None
        
        # Cüzdan bilgisi ekle
        cuzdan = Cuzdanlar.query.filter_by(kullaniciID=kullanici_id).first()
        kullanici_dict['cuzdan'] = cuzdan.to_dict() if cuzdan else None
        
        # Araçlar ekle
        araclar = Araclar.query.filter_by(sahipID=kullanici_id).all()
        kullanici_dict['araclar'] = [arac.to_dict() for arac in araclar]
        
        return jsonify(kullanici_dict), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500


# ============================================
# 2. KULLANICI PROFİLİNİ GÜNCELLE
# ============================================
@bp.route('/<int:kullanici_id>', methods=['PUT'])
def update_kullanici(kullanici_id):
    """Kullanıcı profil bilgilerini güncelle"""
    try:
        kullanici = Kullanicilar.query.get_or_404(kullanici_id)
        data = request.get_json()
        
        # Güncellenebilir alanlar
        if 'telefonNo' in data:
            kullanici.telefonNo = data['telefonNo']
        
        if 'biyografi' in data:
            kullanici.biyografi = data['biyografi']
        
        if 'profilFotoURL' in data:
            kullanici.profilFotoURL = data['profilFotoURL']
        
        if 'cinsiyetTercihi' in data:
            kullanici.cinsiyetTercihi = data['cinsiyetTercihi']
        
        if 'sigaraIciyorMu' in data:
            kullanici.sigaraIciyorMu = data['sigaraIciyorMu']
        
        if 'muzikTercihi' in data:
            kullanici.muzikTercihi = data['muzikTercihi']
        
        db.session.commit()
        
        return jsonify({
            'message': 'Profil başarıyla güncellendi',
            'kullanici': kullanici.to_dict()
        }), 200
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500


# ============================================
# 3. TÜM KULLANICILARI LİSTELE (Admin)
# ============================================
@bp.route('/', methods=['GET'])
def get_kullanicilar():
    """Tüm kullanıcıları listele (filtreleme ile)"""
    try:
        # Query parametreleri
        universite_id = request.args.get('universite_id', type=int)
        hesap_durumu = request.args.get('durum', 'Aktif')
        
        query = Kullanicilar.query.filter_by(hesapDurumu=hesap_durumu)
        
        if universite_id:
            query = query.filter_by(universiteID=universite_id)
        
        kullanicilar = query.all()
        
        return jsonify({
            'kullanicilar': [k.to_dict() for k in kullanicilar],
            'count': len(kullanicilar)
        }), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500


# ============================================
# 4. KULLANICI ARAÇ EKLE
# ============================================
@bp.route('/<int:kullanici_id>/araclar', methods=['POST'])
def add_arac(kullanici_id):
    """Kullanıcıya yeni araç ekle"""
    try:
        kullanici = Kullanicilar.query.get_or_404(kullanici_id)
        data = request.get_json()
        
        # Plaka kontrolü
        if Araclar.query.filter_by(plaka=data.get('plaka')).first():
            return jsonify({'error': 'Bu plaka zaten kayıtlı'}), 400
        
        yeni_arac = Araclar(
            sahipID=kullanici_id,
            plaka=data.get('plaka'),
            marka=data.get('marka'),
            model=data.get('model'),
            renk=data.get('renk'),
            yil=data.get('yil'),
            yolcuKapasitesi=data.get('yolcuKapasitesi'),
            ruhsatFotoURL=data.get('ruhsatFotoURL')
        )
        
        db.session.add(yeni_arac)
        db.session.commit()
        
        return jsonify({
            'message': 'Araç başarıyla eklendi',
            'arac': yeni_arac.to_dict()
        }), 201
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500


# ============================================
# 5. KULLANICI ARAÇLARINI LİSTELE
# ============================================
@bp.route('/<int:kullanici_id>/araclar', methods=['GET'])
def get_kullanici_araclari(kullanici_id):
    """Kullanıcının tüm araçlarını listele"""
    try:
        araclar = Araclar.query.filter_by(sahipID=kullanici_id).all()
        
        return jsonify({
            'araclar': [arac.to_dict() for arac in araclar],
            'count': len(araclar)
        }), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500


# ============================================
# 6. KULLANICI İSTATİSTİKLERİ
# ============================================
@bp.route('/<int:kullanici_id>/istatistikler', methods=['GET'])
def get_kullanici_istatistikleri(kullanici_id):
    """Kullanıcının sefer, rezervasyon istatistiklerini getir"""
    try:
        from models import Seferler, Rezervasyonlar, Yorumlar
        
        kullanici = Kullanicilar.query.get_or_404(kullanici_id)
        
        # Sefer istatistikleri (organizatör olarak)
        seferler = Seferler.query.filter_by(olusturanKullaniciID=kullanici_id).all()
        tamamlanan_seferler = [s for s in seferler if s.seferDurumu == 'Tamamlandı']
        
        # Rezervasyon istatistikleri (yolcu olarak)
        rezervasyonlar = Rezervasyonlar.query.filter_by(yolcuID=kullanici_id).all()
        tamamlanan_rezervasyonlar = [r for r in rezervasyonlar if r.durum == 'Tamamlandı']
        
        # Değerlendirme istatistikleri
        yorumlar = Yorumlar.query.filter_by(degerlendirilenKullaniciID=kullanici_id).all()
        ortalama_puan = sum([y.puan for y in yorumlar]) / len(yorumlar) if yorumlar else 0
        
        return jsonify({
            'kullaniciID': kullanici_id,
            'organizatorOlarakSeferSayisi': len(seferler),
            'tamamlananSeferSayisi': len(tamamlanan_seferler),
            'yolcuOlarakRezervasyonSayisi': len(rezervasyonlar),
            'tamamlananRezervasyonSayisi': len(tamamlanan_rezervasyonlar),
            'alinanYorumSayisi': len(yorumlar),
            'ortalamaPuan': round(ortalama_puan, 2),
            'guvenlikSkoru': float(kullanici.guvenlikSkoru)
        }), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500