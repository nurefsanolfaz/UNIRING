from flask import Blueprint, request, jsonify
from models import db, Seferler, SeferGuzergahNoktalari, Kullanicilar, Araclar
from datetime import datetime

bp = Blueprint('seferler', __name__, url_prefix='/api/seferler')


def serialize_sefer(sefer):
    """Sefer + güzergah bilgilerini tek objede döndür"""
    guzergah = (
        SeferGuzergahNoktalari.query
        .filter_by(seferID=sefer.seferID)
        .order_by(SeferGuzergahNoktalari.siraNo.asc())
        .all()
    )

    sefer_dict = sefer.to_dict()
    sefer_dict['guzergah'] = [nokta.to_dict() for nokta in guzergah]
    sefer_dict['baslangicNoktasi'] = guzergah[0].konumAdi if guzergah else None
    sefer_dict['varisNoktasi'] = guzergah[-1].konumAdi if guzergah else None
    return sefer_dict

@bp.route('', methods=['GET'])
@bp.route('/', methods=['GET'])
def get_seferler():
    """Tüm aktif seferleri listele (filtreleme ile)"""
    try:
        # Query parametreleri
        sefer_tarihi = request.args.get('tarih')
        katilim_kapsami = request.args.get('kapsam')
        durum = request.args.get('durum')
        
        # Base query
        query = Seferler.query

        if durum:
            query = query.filter(Seferler.seferDurumu == durum)
        
        if sefer_tarihi:
            query = query.filter(Seferler.seferTarihi == sefer_tarihi)
        
        if katilim_kapsami:
            query = query.filter(Seferler.katilimKapsami == katilim_kapsami)
        
        seferler = query.order_by(Seferler.kalkisZamani.asc()).all()

        return jsonify({
            'seferler': [serialize_sefer(sefer) for sefer in seferler],
            'count': len(seferler)
        }), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@bp.route('', methods=['POST'])
@bp.route('/', methods=['POST'])
def create_sefer():
    """Yeni sefer oluştur"""
    try:
        data = request.get_json()
        
        # Yeni sefer oluştur
        kalkis_str = data.get('kalkisZamani')
        if not kalkis_str:
            return jsonify({'error': 'kalkisZamani alanı zorunludur'}), 400

        normalized_kalkis = kalkis_str.replace('Z', '+00:00')
        try:
            kalkis_zamani = datetime.fromisoformat(normalized_kalkis)
        except ValueError:
            try:
                kalkis_zamani = datetime.strptime(kalkis_str, '%Y-%m-%d %H:%M')
            except ValueError:
                return jsonify({'error': 'kalkisZamani formatı geçersiz'}), 400

        sefer_tarihi_str = data.get('seferTarihi')
        if sefer_tarihi_str:
            try:
                sefer_tarihi = datetime.fromisoformat(sefer_tarihi_str.replace('Z', '+00:00')).date()
            except ValueError:
                try:
                    sefer_tarihi = datetime.strptime(sefer_tarihi_str, '%Y-%m-%d').date()
                except ValueError:
                    return jsonify({'error': 'seferTarihi formatı geçersiz'}), 400
        else:
            sefer_tarihi = kalkis_zamani.date()

        yeni_sefer = Seferler(
            olusturanKullaniciID=data.get('olusturanKullaniciID'),
            aracID=data.get('aracID'),
            seferTipi=data.get('seferTipi', 'Araç Paylaşımı'),
            katilimKapsami=data.get('katilimKapsami', 'Tüm Üniversiteler'),
            seferTarihi=sefer_tarihi,
            kalkisZamani=kalkis_zamani,
            maxKapasite=data.get('maxKapasite', 1),
            temelFiyat=data.get('temelFiyat', 0),
            bagajAlaniVar=data.get('bagajAlaniVar', True),
            klimaVar=data.get('klimaVar', True),
            aciklama=data.get('aciklama', ''),
        )
        
        db.session.add(yeni_sefer)
        db.session.flush()  # ID'yi al
        
        # Güzergah noktalarını ekle
        guzergah = data.get('guzergahNoktalari', [])
        for idx, nokta in enumerate(guzergah, start=1):
            yeni_nokta = SeferGuzergahNoktalari(
                seferID=yeni_sefer.seferID,
                konumAdi=nokta.get('konumAdi'),
                latitude=nokta.get('latitude'),
                longitude=nokta.get('longitude'),
                siraNo=idx,
                mesafeOncekiNoktaya=nokta.get('mesafe', 0)
            )
            db.session.add(yeni_nokta)
        
        db.session.commit()
        
        return jsonify({
            'message': 'Sefer başarıyla oluşturuldu',
            'sefer': yeni_sefer.to_dict()
        }), 201
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500

@bp.route('/benim', methods=['GET'])
def get_my_seferler():
    """Kullanıcının kendi oluşturduğu seferleri listele"""
    try:
        # Token'dan veya header'dan kullanıcı ID'sini al
        kullanici_id = request.headers.get('X-User-ID', type=int)
        
        if not kullanici_id:
            return jsonify({'error': 'Kullanıcı kimliği bulunamadı'}), 401
        
        # Bu kullanıcının oluşturduğu seferler
        seferler = Seferler.query.filter_by(olusturanKullaniciID=kullanici_id).order_by(
            Seferler.kalkisZamani.desc()
        ).all()

        return jsonify({
            'seferler': [serialize_sefer(sefer) for sefer in seferler],
            'count': len(seferler)
        }), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@bp.route('/<int:sefer_id>', methods=['GET'])
def get_sefer(sefer_id):
    """Sefer detaylarını getir"""
    try:
        sefer = Seferler.query.get_or_404(sefer_id)
        guzergah = SeferGuzergahNoktalari.query.filter_by(seferID=sefer_id).order_by(SeferGuzergahNoktalari.siraNo).all()
        
        sefer_dict = sefer.to_dict()
        sefer_dict['guzergahNoktalari'] = [nokta.to_dict() for nokta in guzergah]
        
        return jsonify(sefer_dict), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500