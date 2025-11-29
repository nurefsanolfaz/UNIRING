"""
UNIRING - University Carpooling Platform
Flask Backend Application
"""

from flask import Flask, jsonify
from flask_cors import CORS
import os

# Flask app initialization
app = Flask(__name__)
CORS(app)

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
from routes import auth, seferler, rezervasyonlar, kullanicilar

# Register blueprints
app.register_blueprint(auth.bp)
app.register_blueprint(seferler.bp)
app.register_blueprint(rezervasyonlar.bp)
app.register_blueprint(kullanicilar.bp)

# Health check endpoint
@app.route('/')
def index():
    return jsonify({
        'message': 'UNIRING API is running!',
        'version': '1.0.0',
        'status': 'healthy'
    })

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