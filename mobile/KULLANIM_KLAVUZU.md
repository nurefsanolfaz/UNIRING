# 📱 UNIRING Mobil Uygulama - Kullanım Kılavuzu

## 🎯 PROJE HAZIR!

Mobil frontend yapısı tamamlandı. Artık uygulamanı çalıştırabilirsin!

---

## 📋 ÖNCELİKLE BUNLARI KONTROL ET

### 1. Node.js Kurulu mu?
Terminalde şunu çalıştır:
```bash
node --version
```
Versiyon gösteriyorsa tamam. Göstermiyorsa [buradan](https://nodejs.org) indir.

### 2. Telefona Expo Go Uygulamasını İndir
- **Android**: Play Store'dan "Expo Go" ara ve indir
- **iPhone**: App Store'dan "Expo Go" ara ve indir

---

## 🚀 UYGULAMAYI ÇALIŞTIR

### Adım 1: Mobil Klasörüne Git
```bash
cd C:\Users\alpal\Desktop\UNIRING\mobile
```

### Adım 2: Uygulamayı Başlat
```bash
npm start
```

### Adım 3: Telefonda Aç
- Terminalde QR kod çıkacak
- Telefonundaki **Expo Go** uygulamasını aç
- QR kodu tarat
- Uygulama telefonda açılacak! 🎉

---

## 📱 UYGULAMADA NELER VAR?

### ✅ Tamamlanan Ekranlar:

1. **Giriş Ekranı (Login)**
   - Email ve şifre ile giriş
   - Kayıt ol sayfasına yönlendirme

2. **Kayıt Ekranı (Register)**
   - Yeni kullanıcı kaydı
   - Form validasyonu

3. **Ana Sayfa (Home)**
   - Tüm yolculukları listele
   - Yenile (pull to refresh)
   - Yolculuk kartları

4. **Yolculuk Oluştur (Create Ride)**
   - Yeni yolculuk formu
   - Başlangıç/Varış noktası
   - Tarih/saat, fiyat, koltuk sayısı

5. **Profil Ekranı**
   - Kullanıcı bilgileri
   - Çıkış yap butonu

### 🎨 Özellikler:
- ✅ Giriş/Çıkış sistemi
- ✅ Token bazlı kimlik doğrulama
- ✅ Backend'e API bağlantısı
- ✅ Alt tab navigasyon (Ana Sayfa, Profil)
- ✅ Material Design UI (React Native Paper)
- ✅ Form validasyonları

---

## 🔧 BACKEND BAĞLANTISI

### Önemli: Backend Sunucunu Çalıştır!

Mobil uygulama çalışması için **Flask backend sunucusunun aktif olması gerekiyor**.

#### Backend'i Çalıştır:
```bash
cd C:\Users\alpal\Desktop\UNIRING\backend
python app.py
```

Backend `http://localhost:5000` adresinde çalışmalı.

### Telefonda Test Ediyorsan:

Telefonundan test ederken `localhost` çalışmaz! Bilgisayarının IP adresini kullanman gerekiyor:

1. IP adresini öğren:
```bash
ipconfig
```
IPv4 Address'i bul (örn: 192.168.1.100)

2. Config dosyasını güncelle:
```javascript
// mobile/src/constants/config.js
export const API_BASE_URL = 'http://192.168.1.100:5000/api';
```

---

## ⚠️ BACKEND'DE EKSİKLER VAR!

Şu an mobil uygulama hazır AMA backend API'leri tam çalışmıyor çünkü:

### Tamamlanması Gereken Backend Route'ları:

1. **auth.py** - Giriş/Kayıt mantığı eksik
2. **seferler.py** - Yolculuk CRUD işlemleri eksik
3. **rezervasyonlar.py** - Rezervasyon işlemleri eksik

### Ne Yapmalısın?

1. Backend route'larını tamamla (business logic yaz)
2. Database'i kur ve çalıştır
3. Test verisi ekle
4. Sonra mobil uygulamayı test et

---

## 🗂️ PROJE YAPISI

```
UNIRING/
├── backend/              # Flask API (MEVCUT)
│   ├── app/
│   ├── database/
│   └── requirements.txt
│
├── mobile/               # React Native Mobil (YENİ OLUŞTURULDU)
│   ├── src/
│   │   ├── screens/     # Ekranlar
│   │   ├── navigation/  # Navigasyon
│   │   ├── services/    # API servisleri
│   │   ├── context/     # State yönetimi
│   │   ├── components/  # UI bileşenleri
│   │   └── constants/   # Konfigürasyon
│   ├── App.js           # Ana dosya
│   └── package.json
│
└── README.md
```

---

## 🐛 SORUN YAŞARSAN

### "Network Error" Hatası
- Backend çalışıyor mu kontrol et
- IP adresi doğru mu kontrol et
- Firewall backend portunu engelliyor olabilir

### QR Kod Okutamıyorum
- Expo Go uygulaması güncel mi?
- Telefon ve bilgisayar aynı WiFi'de mi?
- `npm start` sonrası "Tunnel" modunu seç

### Ekranda Hata Görüyorum
- `npm start` durdurup tekrar başlat
- Expo Go'yu kapat aç
- Telefonu yeniden başlat

---

## 📈 SONRAKI ADIMLAR

### MVP İçin Eksikler:
1. ✅ Mobil UI tamamlandı
2. ❌ Backend API'leri tamamla
3. ❌ Database'i kur ve seed et
4. ❌ Yolculuk detay ekranı ekle
5. ❌ Rezervasyon sistemi ekle
6. ❌ Mesajlaşma ekle
7. ❌ Harita entegrasyonu ekle
8. ❌ Ödeme sistemi ekle

---

## 💡 ÖNEMLİ NOTLAR

1. **Şimdilik test için** backend'de dummy data kullanabilirsin
2. **Tarih formatı**: YYYY-MM-DD HH:MM (örn: 2024-12-25 14:30)
3. **Token** localStorage'da saklanıyor (AsyncStorage)
4. **Renkler** config.js'te tanımlı, değiştirebilirsin

---

## ✅ BAŞARILI! 

Mobil frontend yapısı **%100 tamamlandı**. 

Şimdi backend'i tamamla ve test et! 🚀
