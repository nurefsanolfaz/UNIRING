from flask import Blueprint, request, jsonify
from models import db, Kullanicilar, Universiteler, Cuzdanlar
from datetime import datetime

bp = Blueprint('auth', __name__, url_prefix='/api/auth')

@bp.route('/register', methods=['POST'])
def register():
    """Yeni kullanıcı kaydı"""
    try:
        data = request.get_json()
        
        # Email domain kontrolü
        email = data.get('email')
        email_domain = email.split('@')[1]
        
        universite = Universiteler.query.filter_by(emailDomain=email_domain).first()
        if not universite:
            return jsonify({'error': 'Geçersiz üniversite email domaini'}), 400
        
        # Kullanıcı var mı kontrol
        if Kullanicilar.query.filter_by(email=email).first():
            return jsonify({'error': 'Bu email zaten kayıtlı'}), 400
        
        # Yeni kullanıcı oluştur
        yeni_kullanici = Kullanicilar(
            universiteID=universite.universiteID,
            ad=data.get('ad'),
            soyad=data.get('soyad'),
            email=email,
            cinsiyet=data.get('cinsiyet'),
            dogumTarihi=datetime.strptime(data.get('dogumTarihi'), '%Y-%m-%d'),
            ogrenciBelgesiURL=data.get('ogrenciBelgesiURL', 'placeholder.jpg')
        )
        yeni_kullanici.set_password(data.get('sifre'))
        
        db.session.add(yeni_kullanici)
        db.session.commit()
        
        # Cüzdan oluştur
        cuzdan = Cuzdanlar(kullaniciID=yeni_kullanici.kullaniciID)
        db.session.add(cuzdan)
        db.session.commit()
        
        return jsonify({
            'message': 'Kayıt başarılı',
            'kullanici': yeni_kullanici.to_dict()
        }), 201
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500

@bp.route('/login', methods=['POST'])
def login():
    """Kullanıcı girişi"""
    try:
        data = request.get_json()
        email = data.get('email')
        sifre = data.get('sifre')
        
        kullanici = Kullanicilar.query.filter_by(email=email).first()
        
        if not kullanici or not kullanici.check_password(sifre):
            return jsonify({'error': 'Email veya şifre hatalı'}), 401
        
        # Son giriş tarihini güncelle
        kullanici.sonGirisTarihi = datetime.utcnow()
        db.session.commit()
        
        return jsonify({
            'message': 'Giriş başarılı',
            'kullanici': kullanici.to_dict()
        }), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500