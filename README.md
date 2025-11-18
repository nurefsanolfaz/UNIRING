# UNIRING - Üniversiteler Arası Akıllı Carpooling Platformu

**BIL372 Veritabanı Sistemleri Dersi Projesi**  
TOBB Ekonomi ve Teknoloji Üniversitesi  
Bilgisayar Mühendisliği Bölümü

## 📋 Proje Bilgileri

**Proje Adı:** UNIRING  
**Teslim Tarihi:** 3 Aralık 2025  
**Grup Üyeleri:**
- Nurefşan Olfaz (2113010008)
- Mehmet Alp Almacı (211401023)

## 🎯 Proje Özeti

UNIRING, Türkiye'deki üniversite öğrencilerine yönelik güvenlik ve esneklik odaklı, akıllı bir carpooling (araç paylaşımı) platformudur. Platform, öğrencilerin günlük ulaşım ihtiyaçlarını ekonomik, güvenli ve sosyal bir şekilde çözmelerini hedeflemektedir.

## 🏗️ Mimari

- **Frontend:** React (PWA - Progressive Web App)
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

### Backend Setup

```bash
# Virtual environment oluştur
cd backend
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Bağımlılıkları yükle
pip install -r requirements.txt

# MySQL veritabanını oluştur
mysql -u root -p
CREATE DATABASE uniring_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
exit;

# Şema ve verileri yükle
mysql -u root -p uniring_db < ../database/schema.sql
mysql -u root -p uniring_db < ../database/views.sql
mysql -u root -p uniring_db < ../database/indexes.sql

# Flask uygulamasını başlat
python app.py
```

### Frontend Setup

```bash
cd frontend
npm install
npm start
```

Uygulama `http://localhost:3000` adresinde çalışacaktır.

## 📁 Proje Yapısı

```
UNIRING/
├── backend/
│   ├── app.py              # Flask ana dosya
│   ├── models.py           # SQLAlchemy modelleri
│   ├── routes/             # API endpoints
│   └── requirements.txt
├── database/
│   ├── schema.sql          # CREATE TABLE scripts
│   ├── views.sql           # VIEW tanımları
│   ├── indexes.sql         # INDEX tanımları
│   └── queries.sql         # Non-trivial sorgular
├── frontend/
│   ├── src/
│   │   ├── components/     # React componentleri
│   │   ├── pages/          # Sayfa componentleri
│   │   └── services/       # API çağrıları
│   └── package.json
└── docs/
    ├── ara_rapor.docx
    └── son_rapor.docx
```

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
- ✅ Kayıt olma ve .edu email doğrulama
- ✅ Sefer oluşturma (Organizatör)
- ✅ Sefer arama ve filtreleme
- ✅ Rezervasyon yapma (Yolcu)
- ✅ Rezervasyon yönetimi
- ✅ Sefer bazlı mesajlaşma
- ✅ Kullanıcı profili ve güvenlik skoru
- ✅ Cüzdan yönetimi

### Teknik Özellikler
- ✅ Mobile-responsive tasarım
- ✅ RESTful API
- ✅ JWT Authentication (opsiyonel)
- ✅ Real-time updates (opsiyonel)

## 📈 Performans Optimizasyonları

- **Composite Indexes:** Sıkça birlikte sorgulanan kolonlar için
- **Full-Text Indexes:** Metin araması için (kullanıcı adı, konum)
- **Covering Indexes:** SELECT sorgularını hızlandırmak için
- **Query Optimization:** EXPLAIN ile analiz edilmiş sorgular

## 🔒 Güvenlik

- Password hashing (Werkzeug)
- SQL Injection koruması (SQLAlchemy ORM)
- CORS yapılandırması
- Input validation

## 📊 Test Verisi

Test verisi oluşturmak için:
1. [Mockaroo](https://www.mockaroo.com/) kullanılabilir
2. `database/sample_data.sql` içinde örnek veri scriptleri bulunur
3. En az 500-1000 satır veri yüklenmeli

## 📝 Raporlar

- **Ara Rapor:** `docs/ara_rapor.docx` (19 Ekim 2025)
- **Son Rapor:** `docs/son_rapor.docx` (3 Aralık 2025)

## 🎯 Demo Hazırlığı

Demo sunumunda gösterilecekler:
1. Database schema ve ilişkiler
2. VIEW'ler ve kullanım örnekleri
3. Non-trivial SQL sorguları (5-6 adet)
4. Çalışan uygulama (tüm core fonksiyonlar)
5. Mobile-responsive tasarım

## 🐛 Bilinen Sorunlar ve TODO

- [ ] Frontend componentlerini tamamla
- [ ] API route'larını implement et
- [ ] Test verisi yükle
- [ ] EER diyagramını ekle
- [ ] Son raporu hazırla

## 📞 İletişim

**Nurefşan Olfaz:** nolfaz@etu.edu.tr  
**Mehmet Alp Almacı:** malmaci@etu.edu.tr

## 📄 Lisans

Bu proje TOBB ETÜ BIL372 Veritabanı Sistemleri dersi kapsamında eğitim amaçlı geliştirilmiştir.
# UNIRING
