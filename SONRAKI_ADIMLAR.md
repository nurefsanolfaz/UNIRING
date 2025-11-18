# 🎯 UNIRING PROJESİ - SONRAKI ADIMLAR

## ✅ TAMAMLANAN İŞLER (İlk Adım)

### 1. Veritabanı Altyapısı (100% Tamamlandı)
- ✅ 10 tablo CREATE scripts (schema.sql)
- ✅ 6 karmaşık VIEW (views.sql)
- ✅ 15+ performans INDEX'i (indexes.sql)
- ✅ 10 non-trivial SQL sorgusu (queries.sql)
- ✅ Normalizasyon (3NF)
- ✅ Foreign key ilişkileri

### 2. Backend Altyapısı (80% Tamamlandı)
- ✅ Flask uygulama yapısı (app.py)
- ✅ SQLAlchemy modelleri (models.py)
- ✅ Requirements.txt
- ⚠️ API route'ları (boş template'ler hazır)

### 3. Dokümantasyon (100% Tamamlandı)
- ✅ README.md (detaylı kurulum ve açıklamalar)
- ✅ Proje yapısı
- ✅ SQL sorgu açıklamaları

## 📋 YAPILACAKLAR LİSTESİ (Öncelik Sırasına Göre)

### 🔴 HAFTA 1 (Kritik - Backend)

#### Gün 1-2: MySQL Setup ve Veri Yükleme
**Yapılacaklar:**
1. MySQL'de `uniring_db` veritabanını oluştur
2. `schema.sql` dosyasını çalıştır (tablolar)
3. `views.sql` dosyasını çalıştır (view'ler)
4. `indexes.sql` dosyasını çalıştır (index'ler)
5. Mockaroo ile test verisi üret (500-1000 satır)
   - Universiteler: 20 üniversite
   - Kullanicilar: 100-200 kullanıcı
   - Araclar: 30-50 araç
   - Seferler: 100-150 sefer
   - Rezervasyonlar: 200-300 rezervasyon

**Komutlar:**
```bash
mysql -u root -p
CREATE DATABASE uniring_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE uniring_db;
SOURCE database/schema.sql;
SOURCE database/views.sql;
SOURCE database/indexes.sql;
```

**Test Sorguları:**
```sql
-- Tabloları kontrol et
SHOW TABLES;

-- VIEW'leri test et
SELECT * FROM AktifSeferlerView LIMIT 10;
SELECT * FROM KullaniciIstatistikleriView LIMIT 10;

-- INDEX'leri kontrol et
SHOW INDEX FROM Seferler;

-- Non-trivial sorguları çalıştır
-- (queries.sql'den kopyala)
```

#### Gün 3-4: Flask Backend API
**Yapılacaklar:**
1. Backend route'larını implement et:
   - `auth.py` → Kayıt, giriş, çıkış
   - `seferler.py` → Sefer CRUD işlemleri
   - `rezervasyonlar.py` → Rezervasyon işlemleri
   - `kullanicilar.py` → Profil işlemleri

**Örnek Route Yapısı:**
```python
# routes/auth.py
from flask import Blueprint, request, jsonify
from models import db, Kullanicilar, Universiteler
from datetime import datetime

bp = Blueprint('auth', __name__, url_prefix='/api/auth')

@bp.route('/register', methods=['POST'])
def register():
    # Kullanıcı kaydı
    pass

@bp.route('/login', methods=['POST'])
def login():
    # Giriş işlemi
    pass
```

2. Postman/Insomnia ile API testleri yap

#### Gün 5-7: Core API Endpoints
**Öncelikli Endpoint'ler:**
1. `POST /api/auth/register` - Kayıt
2. `POST /api/auth/login` - Giriş
3. `GET /api/seferler` - Sefer listesi
4. `POST /api/seferler` - Sefer oluştur
5. `GET /api/seferler/:id` - Sefer detay
6. `POST /api/rezervasyonlar` - Rezervasyon yap
7. `PUT /api/rezervasyonlar/:id` - Rezervasyon onayla/reddet
8. `GET /api/kullanicilar/:id` - Profil bilgisi

### 🟡 HAFTA 2 (Önemli - Frontend)

#### Gün 8-10: React Setup
**Yapılacaklar:**
1. React projesi oluştur:
```bash
npx create-react-app frontend
cd frontend
npm install react-router-dom axios @mui/material @emotion/react @emotion/styled
```

2. Klasör yapısı:
```
src/
├── components/
│   ├── Navbar.js
│   ├── SeferCard.js
│   ├── SeferForm.js
│   └── RezervasyonModal.js
├── pages/
│   ├── HomePage.js
│   ├── LoginPage.js
│   ├── RegisterPage.js
│   ├── SeferlerPage.js
│   ├── SeferDetayPage.js
│   └── ProfilPage.js
├── services/
│   └── api.js
└── App.js
```

3. API service dosyası:
```javascript
// services/api.js
import axios from 'axios';

const API_BASE_URL = 'http://localhost:5000/api';

export const apiClient = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

export const authAPI = {
  register: (data) => apiClient.post('/auth/register', data),
  login: (data) => apiClient.post('/auth/login', data),
};

export const seferlerAPI = {
  getAll: () => apiClient.get('/seferler'),
  getById: (id) => apiClient.get(`/seferler/${id}`),
  create: (data) => apiClient.post('/seferler', data),
};
```

#### Gün 11-14: Core Sayfalar
**Öncelik Sırası:**
1. **LoginPage** - Giriş sayfası
2. **RegisterPage** - Kayıt sayfası
3. **HomePage** - Sefer arama (ana sayfa)
4. **SeferlerPage** - Sefer listesi
5. **SeferDetayPage** - Sefer detayı ve rezervasyon
6. **ProfilPage** - Kullanıcı profili

**Mobile-First Tasarım:**
- Material-UI kullan
- Responsive breakpoints
- 375px (mobile) öncelikli

### 🟢 HAFTA 3 (İyileştirme - Test & Polish)

#### Gün 15-17: Testing & Bug Fixes
1. Tüm API endpoint'lerini test et
2. Frontend-Backend entegrasyonunu test et
3. Bug'ları düzelt
4. Edge case'leri handle et

#### Gün 18-19: Son Rapor
1. EER diyagramı çiz (MySQL Workbench veya draw.io)
2. Schema diyagramı oluştur
3. Ekran görüntüleri al
4. Son raporu yaz (template ara rapordaki gibi)

#### Gün 20-21: Demo Hazırlık
1. Demo senaryosu hazırla
2. Sunum slaytları (15-20 slayt)
3. Prova yap

## 📦 MOCKAROO VERİ ÜRETİMİ

### Universiteler Tablosu (20 satır)
```
universiteAdi: University Name (custom list)
emailDomain: Custom Format - "etu.edu.tr", "bilkent.edu.tr", etc.
sehir: City
logoURL: URL
```

### Kullanicilar Tablosu (100-200 satır)
```
universiteID: Number (1-20)
ad: First Name
soyad: Last Name
email: Email (custom domain from universities)
sifreHash: MD5 (temp, real hash later)
telefonNo: Phone
cinsiyet: Custom List (Erkek, Kadın, Belirtmek İstemiyorum)
dogumTarihi: Date (1995-2005)
guvenlikSkoru: Number (30-100)
```

### Seferler Tablosu (100-150 satır)
```
olusturanKullaniciID: Number (1-200)
seferTipi: Custom List (Araç Paylaşımı, Ortak Araç Kullanımı)
seferTarihi: Date (today + 0-30 days)
kalkisZamani: Datetime
maxKapasite: Number (1-4)
temelFiyat: Money (50-300 TL)
seferDurumu: Custom List (Planlanıyor, Aktif, Tamamlandı)
```

## 🎯 DEMO SUNUMU ŞABLONU

**Slayt Yapısı (15-20 slayt):**
1. Kapak (Proje adı, grup üyeleri)
2. Problem Tanımı
3. Çözüm ve Özellikler
4. Database Schema (ER diagram)
5. Tablo İlişkileri
6. VIEW'ler (2-3 örnek)
7. INDEX'ler ve Performans
8. Non-Trivial Sorgular (3-4 örnek + sonuçları)
9. Uygulama Mimarisi
10. Demo - Kayıt & Giriş
11. Demo - Sefer Oluşturma
12. Demo - Rezervasyon
13. Demo - Mesajlaşma
14. Mobil Görünüm
15. İstatistikler (kaç sefer, kaç kullanıcı, vb.)
16. Gelecek Planları
17. Teşekkür & Sorular

## 🔧 YAKIN GELECEK TODOs

### Backend
- [ ] Auth route'larını implement et
- [ ] Seferler route'larını implement et
- [ ] Rezervasyonlar route'larını implement et
- [ ] JWT token sistemi ekle (opsiyonel)
- [ ] Error handling iyileştir

### Database
- [ ] Test verisi yükle (Mockaroo)
- [ ] Stored procedure ekle (bonus)
- [ ] Trigger ekle (bonus)

### Frontend
- [ ] React projesi oluştur
- [ ] Ana sayfayı tasarla
- [ ] Sefer arama fonksiyonu
- [ ] Rezervasyon formu
- [ ] Responsive tasarım

### Dokümantasyon
- [ ] EER diyagramı çiz
- [ ] API dokümantasyonu (Postman collection)
- [ ] Son raporu yaz
- [ ] Demo sunum hazırla

## 💡 İPUÇLARI

1. **Git Kullanımı:**
   ```bash
   # Her gün commit at
   git add .
   git commit -m "feat: sefer API endpoints implemented"
   git push origin main
   ```

2. **Test Ederken:**
   - Postman collection oluştur
   - Her endpoint için örnek request/response kaydet

3. **Demo İçin:**
   - En az 50 sefer, 100 kullanıcı, 200 rezervasyon olsun
   - "Showcase" kullanıcıları hazırla (iyi skorlu, çok seferli)

4. **Zaman Yönetimi:**
   - Backend'e 7 gün (kritik!)
   - Frontend'e 7 gün
   - Test & Rapor'a 7 gün

## 📞 YARDIM GEREKTİĞİNDE

- Backend API sorunları → Flask/SQLAlchemy dokümantasyonu
- Frontend → React + Material-UI dokümantasyonu
- SQL soruları → MySQL referans
- Git sorunları → GitHub Desktop veya komut satırı

## 🎓 NOTLAR

- Ara rapor zaten hazır (UniringReport.docx)
- Database tasarımı %100 tamamlandı
- Backend yapısı hazır, sadece route içerikleri eksik
- Frontend sıfırdan başlanacak ama hızlı ilerleyebilir

---

**SON TESLİM:** 3 Aralık 2025  
**KALAN SÜRE:** ~3 hafta  
**MEVCUT DURUM:** %40 tamamlandı (database + backend altyapısı)

Başarılar! 🚀
