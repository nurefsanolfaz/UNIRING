-- UNIRING Veritabanı Kontrol Sorguları
-- Bu dosyayı SQLTools ile çalıştırabilirsiniz

USE uniring_db;

-- 1. Tüm kullanıcıları göster (son kayıt olanlar üstte)
SELECT 
    kullaniciID,
    ad,
    soyad,
    email,
    telefonNo,
    universiteID,
    kayitTarihi,
    sonGirisTarihi
FROM Kullanicilar
ORDER BY kayitTarihi DESC
LIMIT 20;

-- 2. Tüm seferleri göster (son eklenenler üstte)
SELECT 
    s.seferID,
    s.seferTipi,
    s.seferDurumu,
    s.kalkisZamani,
    s.maxKapasite,
    s.mevcutDoluluk,
    s.temelFiyat,
    CONCAT(k.ad, ' ', k.soyad) as organizator,
    k.email as organizator_email
FROM Seferler s
LEFT JOIN Kullanicilar k ON s.organizatorID = k.kullaniciID
ORDER BY s.kalkisZamani DESC
LIMIT 20;

-- 3. Rezervasyonları göster
SELECT 
    r.rezervasyonID,
    r.rezervasyonDurumu,
    r.odemeTutari,
    CONCAT(k.ad, ' ', k.soyad) as yolcu,
    s.seferID,
    s.seferTipi
FROM Rezervasyonlar r
LEFT JOIN Kullanicilar k ON r.kullaniciID = k.kullaniciID
LEFT JOIN Seferler s ON r.seferID = s.seferID
ORDER BY r.rezervasyonID DESC
LIMIT 20;

-- 4. Üniversiteleri göster
SELECT 
    universiteID,
    ad,
    emailDomains,
    kampusAdresID
FROM Universiteler
ORDER BY ad;

-- 5. Son 5 dakikada kayıt olan kullanıcılar (yeni kayıtları kontrol için)
SELECT 
    kullaniciID,
    ad,
    soyad,
    email,
    kayitTarihi
FROM Kullanicilar
WHERE kayitTarihi >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)
ORDER BY kayitTarihi DESC;

-- 6. Toplam istatistikler
SELECT 
    (SELECT COUNT(*) FROM Kullanicilar) as toplam_kullanici,
    (SELECT COUNT(*) FROM Seferler) as toplam_sefer,
    (SELECT COUNT(*) FROM Rezervasyonlar) as toplam_rezervasyon,
    (SELECT COUNT(*) FROM Universiteler) as toplam_universite;
