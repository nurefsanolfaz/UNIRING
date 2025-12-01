-- ============================================
-- UNIRING - VERİ TEMİZLEME
-- Tüm tabloları foreign key sırasına göre temizle
-- ============================================

SET FOREIGN_KEY_CHECKS = 0;

-- En bağımlı tablolardan başla (child tables)
TRUNCATE TABLE Mesajlar;
TRUNCATE TABLE Yorumlar;
TRUNCATE TABLE Odemeler;
TRUNCATE TABLE Rezervasyonlar;
TRUNCATE TABLE SeferGuzergahNoktalari;
TRUNCATE TABLE Seferler;
TRUNCATE TABLE Araclar;
TRUNCATE TABLE Cuzdanlar;
TRUNCATE TABLE Kullanicilar;
TRUNCATE TABLE Universiteler;

SET FOREIGN_KEY_CHECKS = 1;

SELECT 'Tüm tablolar temizlendi!' AS durum;