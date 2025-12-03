# 🚀 BACKEND API GEREKSİNİMLERİ

Mobile frontend'in çalışması için backend'de olması gereken API endpoint'leri.

## 📋 İÇİNDEKİLER
- [Kimlik Doğrulama](#kimlik-doğrulama)
- [Sefer İşlemleri](#sefer-işlemleri)
- [Rezervasyon İşlemleri](#rezervasyon-işlemleri)
- [Kullanıcı İşlemleri](#kullanıcı-işlemleri)

---

## 🔐 Kimlik Doğrulama

### 1. Kayıt Ol
```http
POST /api/auth/register
Content-Type: application/json

Request Body:
{
  "firstName": "Ahmet",
  "lastName": "Yılmaz",
  "email": "ahmet@sabanciuniv.edu",
  "password": "password123",
  "phoneNumber": "05551234567",
  "universityId": 1,
  "gender": "Erkek",
  "birthDate": "2000-05-15",
  "studentDocument": "base64_encoded_file_or_url"
}

Response (201):
{
  "success": true,
  "message": "Kullanıcı başarıyla oluşturuldu",
  "kullanici": {
    "kullaniciID": 123,
    "ad": "Ahmet",
    "soyad": "Yılmaz",
    "email": "ahmet@sabanciuniv.edu",
    "universiteID": 1
  },
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}

Error (400/409):
{
  "success": false,
  "message": "Email zaten kullanımda"
}
```

### 2. Giriş Yap
```http
POST /api/auth/login
Content-Type: application/json

Request Body:
{
  "email": "ahmet@sabanciuniv.edu",
  "password": "password123"
}

Response (200):
{
  "success": true,
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "kullanici": {
    "kullaniciID": 123,
    "ad": "Ahmet",
    "soyad": "Yılmaz",
    "email": "ahmet@sabanciuniv.edu",
    "universiteID": 1,
    "profilFotoURL": "https://...",
    "guvenlikSkoru": 75.5
  }
}

Error (401):
{
  "success": false,
  "message": "Email veya şifre hatalı"
}
```

### 3. Çıkış Yap
```http
POST /api/auth/logout
Authorization: Bearer <token>

Response (200):
{
  "success": true,
  "message": "Çıkış yapıldı"
}
```

---

## 🚗 Sefer İşlemleri

### 4. Tüm Aktif Seferleri Listele
```http
GET /api/seferler
Authorization: Bearer <token>

Query Parameters (opsiyonel):
- durum: Aktif, Planlanıyor, Tamamlandı
- limit: 20
- offset: 0

Response (200):
{
  "success": true,
  "seferler": [
    {
      "seferID": 1,
      "olusturanKullaniciID": 10,
      "seferTipi": "Araç Paylaşımı",
      "kalkisZamani": "2025-12-05T08:00:00Z",
      "tahminiVarisZamani": "2025-12-05T10:30:00Z",
      "maxKapasite": 4,
      "mevcutDoluluk": 2,
      "seferDurumu": "Aktif",
      "temelFiyat": 150.00,
      "bagajAlaniVar": true,
      "klimaVar": true,
      "katilimKapsami": "Tüm Üniversiteler",
      "aciklama": "Ankara'ya gidiyorum...",
      "guzergah": [
        {
          "noktaID": 1,
          "konumAdi": "İstanbul Sabancı Üniversitesi",
          "latitude": 40.8863,
          "longitude": 29.3767,
          "siraNo": 1,
          "planlananVarisZamani": "08:00:00"
        },
        {
          "noktaID": 2,
          "konumAdi": "Ankara ODTÜ",
          "latitude": 39.8917,
          "longitude": 32.7833,
          "siraNo": 2,
          "planlananVarisZamani": "10:30:00",
          "mesafeOncekiNoktaya": 350.5
        }
      ],
      "organizator": {
        "kullaniciID": 10,
        "ad": "Mehmet",
        "soyad": "Demir",
        "guvenlikSkoru": 85.5,
        "profilFotoURL": "https://...",
        "universitAdi": "Sabancı Üniversitesi"
      },
      "arac": {
        "aracID": 5,
        "marka": "Toyota",
        "model": "Corolla",
        "renk": "Beyaz",
        "yil": 2020,
        "plaka": "34 ABC 123"
      }
    }
  ],
  "toplam": 45
}
```

### 5. Sefer Detayı Getir
```http
GET /api/seferler/:seferID
Authorization: Bearer <token>

Response (200):
{
  "success": true,
  "seferID": 1,
  "olusturanKullaniciID": 10,
  "seferTipi": "Araç Paylaşımı",
  "kalkisZamani": "2025-12-05T08:00:00Z",
  "tahminiVarisZamani": "2025-12-05T10:30:00Z",
  "maxKapasite": 4,
  "mevcutDoluluk": 2,
  "seferDurumu": "Aktif",
  "temelFiyat": 150.00,
  "bagajAlaniVar": true,
  "klimaVar": true,
  "katilimKapsami": "Tüm Üniversiteler",
  "aciklama": "Ankara'ya gidiyorum...",
  "guzergah": [...],
  "organizator": {...},
  "arac": {...}
}

Error (404):
{
  "success": false,
  "message": "Sefer bulunamadı"
}
```

### 6. Yeni Sefer Oluştur
```http
POST /api/seferler
Authorization: Bearer <token>
Content-Type: application/json

Request Body:
{
  "aracID": 5,
  "seferTipi": "Araç Paylaşımı",
  "katilimKapsami": "Tüm Üniversiteler",
  "seferTarihi": "2025-12-05",
  "kalkisZamani": "2025-12-05T08:00:00Z",
  "tahminiVarisZamani": "2025-12-05T10:30:00Z",
  "maxKapasite": 4,
  "temelFiyat": 150.00,
  "bagajAlaniVar": true,
  "klimaVar": true,
  "aciklama": "Ankara'ya gidiyorum...",
  "guzergah": [
    {
      "konumAdi": "İstanbul Sabancı Üniversitesi",
      "latitude": 40.8863,
      "longitude": 29.3767,
      "siraNo": 1,
      "planlananVarisZamani": "08:00:00"
    },
    {
      "konumAdi": "Ankara ODTÜ",
      "latitude": 39.8917,
      "longitude": 32.7833,
      "siraNo": 2,
      "planlananVarisZamani": "10:30:00",
      "mesafeOncekiNoktaya": 350.5
    }
  ]
}

Response (201):
{
  "success": true,
  "message": "Sefer başarıyla oluşturuldu",
  "seferID": 123
}
```

### 7. Kullanıcının Oluşturduğu Seferler
```http
GET /api/seferler/benim
Authorization: Bearer <token>

Response (200):
{
  "success": true,
  "seferler": [...]
}
```

### 8. Sefer Ara/Filtrele
```http
POST /api/seferler/ara
Authorization: Bearer <token>
Content-Type: application/json

Request Body:
{
  "kalkisKonumu": "İstanbul",
  "varisKonumu": "Ankara",
  "tarih": "2025-12-05",
  "minFiyat": 0,
  "maxFiyat": 200,
  "seferTipi": "Araç Paylaşımı"
}

Response (200):
{
  "success": true,
  "seferler": [...],
  "toplam": 12
}
```

---

## 🎫 Rezervasyon İşlemleri

### 9. Rezervasyon Oluştur
```http
POST /api/rezervasyonlar
Authorization: Bearer <token>
Content-Type: application/json

Request Body:
{
  "seferID": 1,
  "binisNoktaID": 1,
  "inisNoktaID": 2,
  "yolcuSayisi": 1
}

Response (201):
{
  "success": true,
  "message": "Rezervasyon oluşturuldu",
  "rezervasyon": {
    "rezervasyonID": 456,
    "seferID": 1,
    "yolcuID": 123,
    "durum": "Beklemede",
    "hesaplananUcret": 150.00,
    "indirimMiktari": 0.00,
    "odenecekTutar": 150.00,
    "olusturulmaTarihi": "2025-12-02T10:00:00Z"
  }
}

Error (400):
{
  "success": false,
  "message": "Sefer dolu"
}
```

### 10. Kullanıcının Rezervasyonları
```http
GET /api/rezervasyonlar/benim
Authorization: Bearer <token>

Response (200):
{
  "success": true,
  "rezervasyonlar": [
    {
      "rezervasyonID": 456,
      "seferID": 1,
      "yolcuID": 123,
      "yolcuSayisi": 1,
      "durum": "Onaylandı",
      "odenecekTutar": 150.00,
      "olusturulmaTarihi": "2025-12-02T10:00:00Z",
      "binisNokta": {
        "noktaID": 1,
        "konumAdi": "İstanbul Sabancı Üniversitesi"
      },
      "inisNokta": {
        "noktaID": 2,
        "konumAdi": "Ankara ODTÜ"
      },
      "sefer": {
        "seferID": 1,
        "kalkisZamani": "2025-12-05T08:00:00Z",
        "seferDurumu": "Aktif",
        "organizator": {
          "ad": "Mehmet",
          "soyad": "Demir"
        }
      }
    }
  ]
}
```

### 11. Rezervasyon İptali
```http
PUT /api/rezervasyonlar/:rezervasyonID/iptal
Authorization: Bearer <token>
Content-Type: application/json

Request Body:
{
  "iptalNedeni": "Planlarım değişti"
}

Response (200):
{
  "success": true,
  "message": "Rezervasyon iptal edildi"
}
```

---

## 👤 Kullanıcı İşlemleri

### 12. Profil Bilgileri Getir
```http
GET /api/kullanicilar/profil
Authorization: Bearer <token>

Response (200):
{
  "success": true,
  "kullanici": {
    "kullaniciID": 123,
    "ad": "Ahmet",
    "soyad": "Yılmaz",
    "email": "ahmet@sabanciuniv.edu",
    "telefonNo": "05551234567",
    "cinsiyet": "Erkek",
    "dogumTarihi": "2000-05-15",
    "profilFotoURL": "https://...",
    "biyografi": "Merhaba!",
    "guvenlikSkoru": 75.5,
    "kayitTarihi": "2025-01-01T00:00:00Z",
    "universite": {
      "universiteID": 1,
      "universiteAdi": "Sabancı Üniversitesi",
      "sehir": "İstanbul"
    }
  }
}
```

### 13. Profil Güncelle
```http
PUT /api/kullanicilar/profil
Authorization: Bearer <token>
Content-Type: application/json

Request Body:
{
  "telefonNo": "05559876543",
  "biyografi": "Güncellenmiş biyografi",
  "cinsiyetTercihi": "Fark Etmez",
  "sigaraIciyorMu": false,
  "muzikTercihi": "Pop"
}

Response (200):
{
  "success": true,
  "message": "Profil güncellendi"
}
```

---

## 📝 NOTLAR

### Kimlik Doğrulama
- Tüm endpoint'ler (auth hariç) `Authorization: Bearer <token>` header'ı gerektirir
- Token, JWT formatında olmalı
- Token içinde `kullaniciID` bulunmalı

### Veri Formatları
- **Tarih/Saat**: ISO 8601 formatı (`2025-12-05T08:00:00Z`)
- **Para**: Decimal, 2 basamak (`150.00`)
- **Enum'lar**: Schema'daki değerler (örn: `Aktif`, `Beklemede`)

### Hata Kodları
- `400 Bad Request`: Geçersiz istek
- `401 Unauthorized`: Token yok/geçersiz
- `403 Forbidden`: Yetki yok
- `404 Not Found`: Kaynak bulunamadı
- `409 Conflict`: Çakışma (örn: email zaten var)
- `500 Internal Server Error`: Sunucu hatası

### İlişkili Veriler
Sefer detayı getirirken şunlar da dahil edilmeli:
- `guzergah` (SeferGuzergahNoktalari)
- `organizator` (Kullanicilar - ad, soyad, güvenlik skoru, profil foto)
- `arac` (Araclar - sadece seferTipi='Araç Paylaşımı' ise)

Rezervasyon listelerinde şunlar dahil:
- `sefer` (temel bilgiler + organizator)
- `binisNokta` ve `inisNokta` (konumAdi)

### Önemli İş Kuralları
1. Rezervasyon oluştururken `mevcutDoluluk` arttırılmalı
2. Rezervasyon iptalinde `mevcutDoluluk` azaltılmalı
3. Sefer dolu ise (`mevcutDoluluk >= maxKapasite`) rezervasyon kabul edilmemeli
4. Kullanıcı kendi seferine rezervasyon yapamamalı

---

## 🧪 TEST ETMEK İÇİN

Frontend çalışırken backend terminal'de istekleri göreceksin:
```
POST /api/auth/register - 201
POST /api/auth/login - 200
GET /api/seferler - 200
GET /api/seferler/123 - 200
POST /api/rezervasyonlar - 201
```

Herhangi bir endpoint eksik/hatalıysa frontend console'da error göreceksin!
