"""
UNIRING - University Carpooling Platform
Flask Backend Application
"""

from flask import Flask, jsonify, request
from flask_cors import CORS
import os

# Flask app initialization
app = Flask(__name__)
CORS(app, resources={
    r"/api/*": {
        "origins": ["http://localhost:8081", "http://localhost:19006"],
        "methods": ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
        "allow_headers": ["Content-Type", "Authorization", "X-User-ID"]
    }
})

# Database configuration
app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv(
    'DATABASE_URL',
    'mysql+pymysql://root:password@localhost/uniring_db'
)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = 'uniring-secret-key-2025'

# Initialize database
from models import db
db.init_app(app)

# Import models after db init
with app.app_context():
    from models import (
        Universiteler, Kullanicilar, Araclar, Seferler,
        SeferGuzergahNoktalari, Rezervasyonlar, Cuzdanlar,
        Odemeler, Yorumlar, Mesajlar
    )

# Import routes
from routes import auth, seferler, rezervasyonlar, kullanicilar, araclar

# Register blueprints
app.register_blueprint(auth.bp)
app.register_blueprint(seferler.bp)
app.register_blueprint(rezervasyonlar.bp)
app.register_blueprint(kullanicilar.bp)
app.register_blueprint(araclar.bp)


@app.route('/api/seferler/<int:sefer_id>/katil', methods=['POST'])
def join_sefer(sefer_id):
    """Kullanıcının bir sefere katılmasını sağlar"""
    print(f"\n{'='*60}")
    print(f"🔵 SEFER KATILIM İSTEĞİ: sefer_id={sefer_id}")
    print(f"{'='*60}")
    
    try:
        data = request.get_json() or {}
        print(f"📥 Gelen veri: {data}")
        print(f"📋 Headers: X-User-ID={request.headers.get('X-User-ID')}")

        yolcu_id = data.get('yolcuID') or request.headers.get('X-User-ID', type=int)
        if not yolcu_id:
            print("❌ Kullanıcı bilgisi bulunamadı")
            return jsonify({'error': 'Kullanıcı bilgisi bulunamadı'}), 400

        print(f"👤 Yolcu ID: {yolcu_id}")
        
        sefer = Seferler.query.get_or_404(sefer_id)
        print(f"🚗 Sefer bulundu: {sefer.seferID} - Durum: {sefer.seferDurumu}")

        if sefer.seferDurumu in ['İptal Edildi', 'Tamamlandı']:
            print(f"❌ Sefer durumu uygun değil: {sefer.seferDurumu}")
            return jsonify({'error': 'Bu sefere katılım kapalı'}), 400

        if sefer.olusturanKullaniciID == yolcu_id:
            print("❌ Kullanıcı kendi seferine katılmaya çalışıyor")
            return jsonify({'error': 'Kendi seferinize katılamazsınız'}), 400

        try:
            yolcu_sayisi = int(data.get('yolcuSayisi', 1))
        except (TypeError, ValueError):
            print("❌ Geçersiz yolcu sayısı")
            return jsonify({'error': 'Geçersiz yolcu sayısı'}), 400

        yolcu_sayisi = max(1, yolcu_sayisi)
        print(f"👥 Yolcu sayısı: {yolcu_sayisi}")
        
        if sefer.mevcutDoluluk + yolcu_sayisi > sefer.maxKapasite:
            print(f"❌ Kapasite dolu: {sefer.mevcutDoluluk}/{sefer.maxKapasite}")
            return jsonify({'error': 'Sefer kapasitesi dolu'}), 400

        kullanici = Kullanicilar.query.get(yolcu_id)
        if not kullanici:
            print(f"❌ Kullanıcı bulunamadı: {yolcu_id}")
            return jsonify({'error': 'Kullanıcı bulunamadı'}), 404

        guzergah = (
            SeferGuzergahNoktalari.query
            .filter_by(seferID=sefer_id)
            .order_by(SeferGuzergahNoktalari.siraNo.asc())
            .all()
        )

        if not guzergah:
            print("❌ Güzergah bulunamadı")
            return jsonify({'error': 'Bu sefer için güzergah bulunmuyor'}), 400

        print(f"📍 Güzergah noktası sayısı: {len(guzergah)}")

        default_binis = guzergah[0].noktaID
        default_inis = guzergah[-1].noktaID

        binis_nokta_id = data.get('binisNoktaID', default_binis)
        inis_nokta_id = data.get('inisNoktaID', default_inis)
        
        print(f"📍 Biniş nokta ID: {binis_nokta_id}, İniş nokta ID: {inis_nokta_id}")

        binis_nokta = next((n for n in guzergah if n.noktaID == binis_nokta_id), None)
        inis_nokta = next((n for n in guzergah if n.noktaID == inis_nokta_id), None)

        if not binis_nokta or not inis_nokta:
            print("❌ Güzergah noktaları bulunamadı")
            return jsonify({'error': 'Güzergah noktaları bulunamadı'}), 404

        if binis_nokta.siraNo >= inis_nokta.siraNo:
            print("❌ Biniş noktası sıra hatalı")
            return jsonify({'error': 'Biniş noktası iniş noktasından önce olmalı'}), 400

        mevcut_rezervasyon = Rezervasyonlar.query.filter_by(
            seferID=sefer_id,
            yolcuID=yolcu_id
        ).first()

        if mevcut_rezervasyon:
            print(f"❌ Kullanıcı zaten kayıtlı: rezervasyon_id={mevcut_rezervasyon.rezervasyonID}")
            return jsonify({'error': 'Bu sefere zaten kayıtlısınız'}), 400

        hesaplanan_ucret = float(data.get('hesaplananUcret', sefer.temelFiyat or 0))
        indirim = float(data.get('indirimMiktari', 0))
        odenecek_tutar = max(0, hesaplanan_ucret - indirim)

        print(f"💰 Ücret: {hesaplanan_ucret} TL, İndirim: {indirim} TL, Ödenecek: {odenecek_tutar} TL")

        yeni_rezervasyon = Rezervasyonlar(
            seferID=sefer.seferID,
            yolcuID=yolcu_id,
            binisNoktaID=binis_nokta.noktaID,
            inisNoktaID=inis_nokta.noktaID,
            yolcuSayisi=yolcu_sayisi,
            hesaplananUcret=hesaplanan_ucret,
            indirimMiktari=indirim,
            odenecekTutar=odenecek_tutar,
            durum='Beklemede'
        )

        db.session.add(yeni_rezervasyon)
        sefer.mevcutDoluluk += yolcu_sayisi
        db.session.commit()

        print(f"✅ Rezervasyon oluşturuldu: ID={yeni_rezervasyon.rezervasyonID}")
        print(f"{'='*60}\n")

        return jsonify({
            'message': 'Sefere katılım talebiniz oluşturuldu',
            'rezervasyon': yeni_rezervasyon.to_dict()
        }), 201

    except Exception as error:
        print(f"❌ HATA: {str(error)}")
        print(f"{'='*60}\n")
        db.session.rollback()
        return jsonify({'error': str(error)}), 500

# Health check endpoint
@app.route('/')
def index():
    return jsonify({
        'message': 'UNIRING API is running!',
        'version': '1.0.0',
        'status': 'healthy'
    })

# Database test endpoint
@app.route('/test/db')
def test_db():
    try:
        from models import Universiteler
        universities = Universiteler.query.all()
        return jsonify({
            'status': 'connected',
            'university_count': len(universities),
            'universities': [{'id': u.universiteID, 'name': u.universiteAdi, 'domain': u.emailDomain} for u in universities[:5]]
        })
    except Exception as e:
        return jsonify({
            'status': 'error',
            'error': str(e)
        }), 500

# Error handlers
@app.errorhandler(404)
def not_found(error):
    return jsonify({
        'error': 'Not Found',
        'message': 'The requested resource was not found'
    }), 404

@app.errorhandler(500)
def internal_error(error):
    db.session.rollback()
    return jsonify({
        'error': 'Internal Server Error',
        'message': 'An internal error occurred'
    }), 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5001)