# UNIRING - Üniversiteler Arası Akıllı Carpooling Platformu

**BIL372 Veritabanı Sistemleri Dersi Projesi**
TOBB Ekonomi ve Teknoloji Üniversitesi
Bilgisayar Mühendisliği Bölümü

## 📋 Proje Bilgileri

**Proje Adı:** UNIRING**Teslim Tarihi:** 3 Aralık 2025**Grup Üyeleri:**

- Nurefşan Olfaz (2113010008)
- Mehmet Alp Almacı (211401023)

## 🎯 Proje Özeti

UNIRING, Türkiye'deki üniversite öğrencilerine yönelik güvenlik ve esneklik odaklı, akıllı bir carpooling (araç paylaşımı) platformudur. Platform, öğrencilerin günlük ulaşım ihtiyaçlarını ekonomik, güvenli ve sosyal bir şekilde çözmelerini hedeflemektedir.

## 🏗️ Mimari

- **Mobile Frontend:** React Native + Expo
- **Backend:** Flask + SQLAlchemy
- **Database:** MySQL
- **API:** RESTful JSON API

## 📊 Veritabanı Tasarımı

### Tablolar (10 Core Tables)

1. **Universiteler** - Üniversite bilgileri
2. **Kullanicilar** - Kullanıcı profilleri ve kimlik doğrulama
3. **Araclar** - Kayıtlı araçlar
4. **Seferler** - Oluşturulan seferler
5. **SeferGuzergahNoktalari** - Çok duraklı rota noktaları
6. **Rezervasyonlar** - Yolcu rezervasyonları
7. **Cuzdanlar** - Sanal cüzdan bakiyeleri
8. **Odemeler** - Ödeme işlemleri
9. **Yorumlar** - Kullanıcı değerlendirmeleri
10. **Mesajlar** - Sefer bazlı mesajlaşma

### Öne Çıkan Özellikler

- ✅ 3NF normalizasyon
- ✅ 15+ performans indeksi
- ✅ 6 karmaşık VIEW
- ✅ 10+ non-trivial SQL sorgusu
- ✅ Foreign key ilişkileri ve cascade kuralları

## 🚀 Kurulum

### Gereksinimler

- Python 3.8+
- Node.js 16+
- MySQL 8.0+
- Expo CLI (mobile için)

### Backend Setup

# Backend klasörüne git

cd backend

# Virtual environment oluştur (opsiyonel ama önerilen)

python -m venv venv

# Windows

venv\Scripts\activate

# Linux/Mac

source venv/bin/activate

# Bağımlılıkları yükle

pip install -r requirements.txt

# MySQL veritabanını oluştur

mysql -u root -p
CREATE DATABASE uniring_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
exit;

# Şema ve verileri yükle

cd ../database
mysql -u root -p uniring_db < schema.sql
mysql -u root -p uniring_db < data.sql
mysql -u root -p uniring_db < views.sql
mysql -u root -p uniring_db < indexes.sql

# Backend'i çalıştır

cd ../backend
python app.py

Backend `http://localhost:5001` adresinde çalışacaktır.

### Mobile Frontend Setup

```bash
# Mobile klasörüne git
cd mobile

# Bağımlılıkları yükle
npm install

# Expo uygulamasını başlat
npx expo start

# Seçenekler:
# - 'a' tuşuna basarak Android emulator'da aç
# - 'i' tuşuna basarak iOS simulator'da aç
# - QR kod ile telefonda Expo Go uygulamasından aç
```

**Not:** Backend'in `http://localhost:5001` adresinde çalıştığından emin olun. Emulator kullanıyorsanız `mobile/src/constants/config.js` dosyasındaki API URL'ini kontrol edin.

## 📁 Proje 

UNIRING/
├── backend/
│   ├── app.py                  # Flask ana dosya
│   ├── models.py               # SQLAlchemy modelleri
│   ├── routes/
│   │   ├── auth.py            # Kimlik doğrulama
│   │   ├── seferler.py        # Sefer işlemleri
│   │   ├── rezervasyonlar.py  # Rezervasyon yönetimi
│   │   ├── kullanicilar.py    # Kullanıcı profilleri
│   │   └── araclar.py         # Araç yönetimi
│   └── requirements.txt
├── database/
│   ├── schema.sql             # CREATE TABLE scripts
│   ├── views.sql              # VIEW tanımları
│   ├── indexes.sql            # INDEX tanımları
│   ├── queries.sql            # Non-trivial sorgular
│   └── data.sql               # Test verisi
├── mobile/
│   ├── src/
│   │   ├── components/        # Reusable componentler
│   │   ├── screens/
│   │   │   ├── auth/         # Login, Register
│   │   │   ├── rides/        # Sefer listesi, detay, oluşturma
│   │   │   └── vehicles/     # Araç yönetimi
│   │   ├── navigation/       # React Navigation setup
│   │   ├── services/         # API servisleri
│   │   ├── context/          # Auth context
│   │   └── constants/        # Config, colors, fonts
│   ├── assets/               # Icon, splash screen
│   ├── package.json
│   └── app.json
└── docs/
    └── UniringReport.pdf

## 🔍 Non-Trivial SQL Sorguları

Projede 10+ karmaşık SQL sorgusu bulunmaktadır:

1. **En Popüler Organizatörler** - JOIN, GROUP BY, HAVING, Subquery
2. **Üniversiteler Arası Sefer Analizi** - SELF JOIN, Multiple JOINs
3. **Zaman Bazlı Talep Analizi** - Window Functions, CASE
4. **Gelir ve Kazanç Analizi** - Correlated Subquery
5. **Rezervasyon Onaylama Performansı** - DATEDIFF, AVG
6. **Çapraz Satış Fırsatları** - UNION, Multiple Aggregates
7. **Güzergah Optimizasyon Analizi** - Complex Aggregation
8. **Güvenlik Skoru Korelasyon** - Statistical Analysis
9. **Zaman Serisi Trend Analizi** - Window Functions, LAG
10. **RFM Analizi** - Multiple CTEs, NTILE

Tüm sorgular `database/queries.sql` dosyasında bulunmaktadır.

## 🎨 Uygulama Özellikleri

### Kullanıcı Fonksiyonları

- ✅ Kayıt olma ve giriş yapma
- ✅ Profil yönetimi (kompakt accordion tasarım)
- ✅ Araç ekleme ve yönetimi
- ✅ Sefer oluşturma (çoklu güzergah noktaları)
- ✅ Sefer arama ve filtreleme (bugün, yarın, ucuz)
- ✅ Sefer detayları görüntüleme
- ✅ Rezervasyon yapma ve yönetimi
- ✅ Rezervasyon iptali
- ✅ Kullanıcı değerlendirme sistemi
- ✅ Güvenlik skoru hesaplama

### Teknik Özellikler

- ✅ Mobile-first responsive tasarım
- ✅ RESTful API
- ✅ JWT benzeri token authentication
- ✅ AsyncStorage ile local data persistence
- ✅ Pull-to-refresh
- ✅ Pagination (5 sefer/sayfa)
- ✅ Real-time validation
- ✅ Material Design UI (React Native Paper)
- ✅ Bottom tab navigation
- ✅ Stack navigation

### UI/UX Özellikleri

- 🎨 Kompakt kart tasarımı
- 🎨 Floating Action Button (FAB)
- 🎨 Chip-based araç seçimi
- 🎨 Status badge'ler
- 🎨 Empty state handling
- 🎨 Loading states
- 🎨 Error handling with user-friendly messages

## 📈 Performans Optimizasyonları

- **Composite Indexes:** Sıkça birlikte sorgulanan kolonlar için
- **Full-Text Indexes:** Metin araması için (kullanıcı adı, konum)
- **Covering Indexes:** SELECT sorgularını hızlandırmak için
- **Query Optimization:** EXPLAIN ile analiz edilmiş sorgular
- **Frontend Caching:** AsyncStorage ile local caching
- **Pagination:** Büyük veri setleri için sayfalama

## 🔒 Güvenlik

- Password hashing (Werkzeug)
- SQL Injection koruması (SQLAlchemy ORM)
- CORS yapılandırması
- Input validation (frontend + backend)
- Plaka format validation (regex)
- Email format validation

## 🎯 Demo Hazırlığı

Demo sunumunda gösterilecekler:

1. ✅ Database schema ve ilişkiler
2. ✅ VIEW'ler ve kullanım örnekleri
3. ✅ Non-trivial SQL sorguları (10+ adet)
4. ✅ Çalışan mobile uygulama (tüm core fonksiyonlar)
5. ✅ Mobile-responsive tasarım
6. ✅ CRUD operasyonları (Araç, Sefer, Rezervasyon)
7. ✅ Filtreleme ve arama
8. ✅ Kullanıcı profil yönetimi

## 🐛 Bilinen Sorunlar ve Geliştirme Önerileri

### Tamamlanan

- ✅ Backend API routes
- ✅ Mobile frontend tüm ekranlar
- ✅ Araç yönetim sistemi
- ✅ Rezervasyon sistemi
- ✅ Kullanıcı authentication
- ✅ UI/UX iyileştirmeleri

### Gelecek Geliştirmeler (Opsiyonel)

- [ ] Real-time chat (Mesajlar tablosu için)
- [ ] Push notifications
- [ ] Payment gateway entegrasyonu (Odemeler tablosu için)
- [ ] Google Maps entegrasyonu
- [ ] Rating & review sistemi detaylandırma
- [ ] Admin panel

## 📱 API Endpoints

### Authentication

- `POST /api/auth/register` - Yeni kullanıcı kaydı
- `POST /api/auth/login` - Kullanıcı girişi

### Seferler

- `GET /api/seferler` - Tüm seferleri listele
- `GET /api/seferler/:id` - Sefer detayı
- `GET /api/seferler/benim` - Kullanıcının seferleri
- `POST /api/seferler` - Yeni sefer oluştur
- `PUT /api/seferler/:id` - Sefer güncelle
- `DELETE /api/seferler/:id` - Sefer sil

### Rezervasyonlar

- `GET /api/rezervasyonlar/benim` - Kullanıcının rezervasyonları
- `POST /api/rezervasyonlar` - Yeni rezervasyon
- `PUT /api/rezervasyonlar/:id/iptal` - Rezervasyon iptali

### Araçlar

- `GET /api/araclar` - Kullanıcının araçları
- `POST /api/araclar` - Yeni araç ekle
- `PUT /api/araclar/:id` - Araç güncelle
- `DELETE /api/araclar/:id` - Araç sil

### Kullanıcılar

- `GET /api/kullanicilar/:id` - Kullanıcı profili
- `PUT /api/kullanicilar/:id` - Profil güncelle

## 📞 İletişim

**Nurefşan Olfaz:** nolfaz@etu.edu.tr
**Mehmet Alp Almacı:** malmaci@etu.edu.tr

## 📄 Lisans

Bu proje TOBB ETÜ BIL372 Veritabanı Sistemleri dersi kapsamında eğitim amaçlı geliştirilmiştir.
