from flask import Blueprint, request, jsonify
from models import db, Seferler, SeferGuzergahNoktalari, Kullanicilar, Araclar
from datetime import datetime

bp = Blueprint('seferler', __name__, url_prefix='/api/seferler')

@bp.route('/', methods=['GET'])
def get_seferler():
    """Tüm aktif seferleri listele (filtreleme ile)"""
    try:
        # Query parametreleri
        sefer_tarihi = request.args.get('tarih')
        katilim_kapsami = request.args.get('kapsam')
        durum = request.args.get('durum', 'Aktif')
        
        # Base query
        query = Seferler.query.filter_by(seferDurumu=durum)
        
        if sefer_tarihi:
            query = query.filter(Seferler.seferTarihi == sefer_tarihi)
        
        if katilim_kapsami:
            query = query.filter(Seferler.katilimKapsami == katilim_kapsami)
        
        seferler = query.all()
        
        return jsonify({
            'seferler': [sefer.to_dict() for sefer in seferler],
            'count': len(seferler)
        }), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@bp.route('/', methods=['POST'])
def create_sefer():
    """Yeni sefer oluştur"""
    try:
        data = request.get_json()
        
        # Yeni sefer oluştur
        yeni_sefer = Seferler(
            olusturanKullaniciID=data.get('olusturanKullaniciID'),
            aracID=data.get('aracID'),
            seferTipi=data.get('seferTipi'),
            katilimKapsami=data.get('katilimKapsami', 'Tüm Üniversiteler'),
            seferTarihi=datetime.strptime(data.get('seferTarihi'), '%Y-%m-%d'),
            kalkisZamani=datetime.strptime(data.get('kalkisZamani'), '%Y-%m-%d %H:%M:%S'),
            maxKapasite=data.get('maxKapasite'),
            temelFiyat=data.get('temelFiyat'),
            aciklama=data.get('aciklama', '')
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