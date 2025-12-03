-- UNIRING Veritabanı Hızlı Kontrol
USE uniring_db;

-- Tüm seferleri göster (aktifseferlerview'dan)
SELECT * FROM aktifseferlerview;

-- Kullanıcıları göster
SELECT * FROM Kullanicilar ORDER BY kayitTarihi DESC;

-- Seferler tablosunu göster
SELECT * FROM Seferler;

-- Rezervasyonları göster
SELECT * FROM Rezervasyonlar;

-- Üniversiteleri göster
SELECT * FROM universiteler;