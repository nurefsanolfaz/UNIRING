"""
Araçlar Route - Araç Ekleme ve Yönetimi
"""

from flask import Blueprint, request, jsonify
from models import db, Araclar, Kullanicilar
from datetime import datetime

bp = Blueprint('araclar', __name__, url_prefix='/api/araclar')

@bp.route('', methods=['GET'])
def get_kullanici_araclari():
    """Kullanıcının araçlarını listele"""
    try:
        # Gerçek uygulamada JWT token'dan alınacak
        kullanici_id = request.args.get('kullaniciID', type=int)
        
        if not kullanici_id:
            return jsonify({
                'success': False,
                'message': 'Kullanıcı ID gerekli'
            }), 400
        
        araclar = Araclar.query.filter_by(sahipID=kullanici_id).all()
        
        return jsonify({
            'success': True,
            'araclar': [arac.to_dict() for arac in araclar]
        }), 200
        
    except Exception as e:
        return jsonify({
            'success': False,
            'message': f'Hata: {str(e)}'
        }), 500

@bp.route('/<int:arac_id>', methods=['GET'])
def get_arac_detay(arac_id):
    """Araç detaylarını getir"""
    try:
        arac = Araclar.query.get(arac_id)
        
        if not arac:
            return jsonify({
                'success': False,
                'message': 'Araç bulunamadı'
            }), 404
        
        return jsonify({
            'success': True,
            'arac': arac.to_dict()
        }), 200
        
    except Exception as e:
        return jsonify({
            'success': False,
            'message': f'Hata: {str(e)}'
        }), 500

@bp.route('', methods=['POST'])
def arac_ekle():
    """Yeni araç ekle"""
    try:
        data = request.get_json()
        
        # Zorunlu alanları kontrol et
        required_fields = ['sahipID', 'plaka', 'marka', 'model', 'yolcuKapasitesi']
        for field in required_fields:
            if field not in data:
                return jsonify({
                    'success': False,
                    'message': f'{field} alanı gerekli'
                }), 400
        
        # Plaka kontrolü
        mevcut_arac = Araclar.query.filter_by(plaka=data['plaka']).first()
        if mevcut_arac:
            return jsonify({
                'success': False,
                'message': 'Bu plaka zaten kayıtlı'
            }), 409
        
        # Yeni araç oluştur
        yeni_arac = Araclar(
            sahipID=data['sahipID'],
            plaka=data['plaka'],
            marka=data['marka'],
            model=data['model'],
            renk=data.get('renk'),
            yil=data.get('yil'),
            yolcuKapasitesi=data['yolcuKapasitesi'],
            sigortaBitisTarihi=datetime.strptime(data['sigortaBitisTarihi'], '%Y-%m-%d').date() if data.get('sigortaBitisTarihi') else None,
            ruhsatFotoURL=data.get('ruhsatFotoURL'),
            onayDurumu='Beklemede'
        )
        
        db.session.add(yeni_arac)
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': 'Araç başarıyla eklendi',
            'arac': yeni_arac.to_dict()
        }), 201
        
    except Exception as e:
        db.session.rollback()
        return jsonify({
            'success': False,
            'message': f'Hata: {str(e)}'
        }), 500

@bp.route('/<int:arac_id>', methods=['PUT'])
def arac_guncelle(arac_id):
    """Araç bilgilerini güncelle"""
    try:
        arac = Araclar.query.get(arac_id)
        
        if not arac:
            return jsonify({
                'success': False,
                'message': 'Araç bulunamadı'
            }), 404
        
        data = request.get_json()
        
        # Kullanıcı kontrolü (gerçek uygulamada JWT'den)
        if data.get('sahipID') and arac.sahipID != data['sahipID']:
            return jsonify({
                'success': False,
                'message': 'Bu aracı güncelleme yetkiniz yok'
            }), 403
        
        # Güncellenebilir alanlar
        if 'marka' in data:
            arac.marka = data['marka']
        if 'model' in data:
            arac.model = data['model']
        if 'renk' in data:
            arac.renk = data['renk']
        if 'yil' in data:
            arac.yil = data['yil']
        if 'yolcuKapasitesi' in data:
            arac.yolcuKapasitesi = data['yolcuKapasitesi']
        if 'sigortaBitisTarihi' in data:
            arac.sigortaBitisTarihi = datetime.strptime(data['sigortaBitisTarihi'], '%Y-%m-%d').date()
        if 'ruhsatFotoURL' in data:
            arac.ruhsatFotoURL = data['ruhsatFotoURL']
        
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': 'Araç güncellendi',
            'arac': arac.to_dict()
        }), 200
        
    except Exception as e:
        db.session.rollback()
        return jsonify({
            'success': False,
            'message': f'Hata: {str(e)}'
        }), 500

@bp.route('/<int:arac_id>', methods=['DELETE'])
def arac_sil(arac_id):
    """Araç sil"""
    try:
        arac = Araclar.query.get(arac_id)
        
        if not arac:
            return jsonify({
                'success': False,
                'message': 'Araç bulunamadı'
            }), 404
        
        # Aktif seferi olan araç silinemez
        from models import Seferler
        aktif_sefer = Seferler.query.filter_by(
            aracID=arac_id
        ).filter(
            Seferler.seferDurumu.in_(['Planlanıyor', 'Aktif', 'Devam Ediyor'])
        ).first()
        
        if aktif_sefer:
            return jsonify({
                'success': False,
                'message': 'Aktif seferi olan araç silinemez'
            }), 400
        
        db.session.delete(arac)
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': 'Araç silindi'
        }), 200
        
    except Exception as e:
        db.session.rollback()
        return jsonify({
            'success': False,
            'message': f'Hata: {str(e)}'
        }), 500
