"""
UNIRING Backend - Test Server
Basitleştirilmiş Flask sunucusu (Database olmadan test için)
"""

from flask import Flask, jsonify, request
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# Test için dummy data
test_users = []
test_rides = []

# Health check
@app.route('/', methods=['GET'])
def index():
    return jsonify({
        'message': 'UNIRING API is running!',
        'version': '1.0.0',
        'status': 'healthy'
    })

# Auth routes
@app.route('/api/auth/register', methods=['POST'])
def register():
    try:
        data = request.get_json()
        
        # Basit validasyon
        if not data.get('email') or not data.get('password'):
            return jsonify({'message': 'Email ve şifre gerekli'}), 400
        
        # Email kontrolü
        if any(u['email'] == data['email'] for u in test_users):
            return jsonify({'message': 'Bu email zaten kayıtlı'}), 400
        
        # Kullanıcı oluştur
        user = {
            'id': len(test_users) + 1,
            'first_name': data.get('first_name', ''),
            'last_name': data.get('last_name', ''),
            'email': data['email'],
            'phone_number': data.get('phone_number', ''),
            'university_id': data.get('university_id', 1)
        }
        test_users.append(user)
        
        return jsonify({
            'message': 'Kayıt başarılı',
            'user': user,
            'token': f'test-token-{user["id"]}'
        }), 201
        
    except Exception as e:
        return jsonify({'message': str(e)}), 500

@app.route('/api/auth/login', methods=['POST'])
def login():
    try:
        data = request.get_json()
        email = data.get('email')
        password = data.get('password')
        
        if not email or not password:
            return jsonify({'message': 'Email ve şifre gerekli'}), 400
        
        # Kullanıcı bul
        user = next((u for u in test_users if u['email'] == email), None)
        
        if not user:
            return jsonify({'message': 'Kullanıcı bulunamadı'}), 404
        
        return jsonify({
            'message': 'Giriş başarılı',
            'user': user,
            'token': f'test-token-{user["id"]}'
        }), 200
        
    except Exception as e:
        return jsonify({'message': str(e)}), 500

# Rides routes
@app.route('/api/rides', methods=['GET'])
def get_rides():
    return jsonify({
        'message': 'Yolculuklar listelendi',
        'rides': test_rides
    }), 200

@app.route('/api/rides', methods=['POST'])
def create_ride():
    try:
        data = request.get_json()
        
        ride = {
            'id': len(test_rides) + 1,
            'start_location': data.get('start_location'),
            'end_location': data.get('end_location'),
            'departure_time': data.get('departure_time'),
            'available_seats': data.get('available_seats'),
            'price_per_seat': data.get('price_per_seat'),
            'description': data.get('description', ''),
            'driver_name': 'Test Sürücü'
        }
        test_rides.append(ride)
        
        return jsonify({
            'message': 'Yolculuk oluşturuldu',
            'ride': ride
        }), 201
        
    except Exception as e:
        return jsonify({'message': str(e)}), 500

@app.route('/api/rides/search', methods=['POST'])
def search_rides():
    return jsonify({
        'message': 'Arama sonuçları',
        'rides': test_rides
    }), 200

@app.route('/api/rides/<int:ride_id>', methods=['GET'])
def get_ride(ride_id):
    ride = next((r for r in test_rides if r['id'] == ride_id), None)
    if not ride:
        return jsonify({'message': 'Yolculuk bulunamadı'}), 404
    return jsonify({'ride': ride}), 200

@app.route('/api/rides/my-rides', methods=['GET'])
def get_my_rides():
    return jsonify({
        'message': 'Yolculuklarım',
        'rides': test_rides
    }), 200

if __name__ == '__main__':
    print("🚀 UNIRING Backend Test Server başlatılıyor...")
    print("📱 Mobil uygulamadan bağlanabilirsiniz!")
    print("🌐 URL: http://localhost:5000")
    print("=" * 50)
    app.run(debug=True, host='0.0.0.0', port=5000)
