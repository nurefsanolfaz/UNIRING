"""
UNIRING - University Carpooling Platform
Flask Backend Application
BIL372 Database Systems Project
"""

from flask import Flask, jsonify, request
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import os

# Flask app initialization
app = Flask(__name__)
CORS(app)  # Enable CORS for React frontend

# Database configuration
app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv(
    'DATABASE_URL',
    'mysql+pymysql://root:password@localhost/uniring_db'
)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = 'uniring-secret-key-2025'  # Change in production

# Database instance
db = SQLAlchemy(app)

# Import models
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

# Database initialization
@app.route('/api/init-db')
def init_db():
    """Initialize database tables"""
    try:
        db.create_all()
        return jsonify({
            'message': 'Database tables created successfully!',
            'status': 'success'
        })
    except Exception as e:
        return jsonify({
            'message': f'Error creating tables: {str(e)}',
            'status': 'error'
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
    app.run(debug=True, host='0.0.0.0', port=5000)
