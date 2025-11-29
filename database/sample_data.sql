-- ============================================
-- UNIRING - SAMPLE DATA INSERTION
-- ============================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0; -- İlişki hatalarını önlemek için geçici kapatma

-- Mevcut verileri temizle (İsteğe bağlı, temiz kurulum için)
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

-- ============================================
-- 1. UNIVERSITELER
-- ============================================
INSERT INTO Universiteler (universiteAdi, emailDomain, sehir, logoURL) VALUES
('TOBB Ekonomi ve Teknoloji Üniversitesi', 'etu.edu.tr', 'Ankara', 'https://logo.etu.edu.tr/tobb.png'),
('Orta Doğu Teknik Üniversitesi', 'metu.edu.tr', 'Ankara', 'https://logo.metu.edu.tr/odtu.png'),
('İhsan Doğramacı Bilkent Üniversitesi', 'bilkent.edu.tr', 'Ankara', 'https://logo.bilkent.edu.tr/bilkent.png');

-- ============================================
-- 2. KULLANICILAR
-- ============================================
-- Kullanıcı 1: TOBB ETÜ'den Araç Sahibi (Ahmet)
INSERT INTO Kullanicilar (universiteID, ad, soyad, email, emailDogrulandi, sifreHash, telefonNo, cinsiyet, dogumTarihi, ogrenciBelgesiURL, hesapDurumu, guvenlikSkoru) VALUES
(1, 'Ahmet', 'Yılmaz', 'yilmaz.ahmet@etu.edu.tr', TRUE, 'hash12345', '5551112233', 'Erkek', '2001-05-15', 'docs/ahmet_ogrenci.pdf', 'Aktif', 95.50);

-- Kullanıcı 2: ODTÜ'den Araç Sahibi (Ayşe)
INSERT INTO Kullanicilar (universiteID, ad, soyad, email, emailDogrulandi, sifreHash, telefonNo, cinsiyet, dogumTarihi, ogrenciBelgesiURL, hesapDurumu, guvenlikSkoru) VALUES
(2, 'Ayşe', 'Demir', 'ayse.demir@metu.edu.tr', TRUE, 'hash67890', '5554445566', 'Kadın', '2002-08-20', 'docs/ayse_ogrenci.pdf', 'Aktif', 98.00);

-- Kullanıcı 3: TOBB ETÜ'den Yolcu (Mehmet)
INSERT INTO Kullanicilar (universiteID, ad, soyad, email, emailDogrulandi, sifreHash, telefonNo, cinsiyet, dogumTarihi, ogrenciBelgesiURL, hesapDurumu) VALUES
(1, 'Mehmet', 'Kaya', 'mkaya@etu.edu.tr', TRUE, 'hashabcde', '5557778899', 'Erkek', '2003-01-10', 'docs/mehmet_ogrenci.pdf', 'Aktif');

-- Kullanıcı 4: Bilkent'ten Yolcu (Zeynep)
INSERT INTO Kullanicilar (universiteID, ad, soyad, email, emailDogrulandi, sifreHash, telefonNo, cinsiyet, dogumTarihi, ogrenciBelgesiURL, hesapDurumu) VALUES
(3, 'Zeynep', 'Çelik', 'zeynep.celik@bilkent.edu.tr', TRUE, 'hashfghij', '5550001122', 'Kadın', '2002-11-05', 'docs/zeynep_ogrenci.pdf', 'Aktif');

-- ============================================
-- 3. CUZDANLAR (Her kullanıcı için otomatik)
-- ============================================
INSERT INTO Cuzdanlar (kullaniciID, bakiye) VALUES
(1, 500.00), -- Ahmet
(2, 750.50), -- Ayşe
(3, 120.00), -- Mehmet
(4, 340.00); -- Zeynep

-- ============================================
-- 4. ARACLAR
-- ============================================
-- Ahmet'in Aracı
INSERT INTO Araclar (sahipID, plaka, marka, model, renk, yil, yolcuKapasitesi, onayDurumu) VALUES
(1, '06ETU123', 'Fiat', 'Egea', 'Beyaz', 2020, 4, 'Onaylandı');

-- Ayşe'nin Aracı
INSERT INTO Araclar (sahipID, plaka, marka, model, renk, yil, yolcuKapasitesi, onayDurumu) VALUES
(2, '06ODT456', 'Renault', 'Clio', 'Kırmızı', 2019, 3, 'Onaylandı');

-- ============================================
-- 5. SEFERLER
-- ============================================
-- Sefer 1: Ahmet TOBB'dan Tunalı'ya gidiyor (Tamamlanmış Sefer)
INSERT INTO Seferler (olusturanKullaniciID, aracID, seferTipi, katilimKapsami, seferTarihi, kalkisZamani, tahminiVarisZamani, maxKapasite, mevcutDoluluk, seferDurumu, fiyatlandirmaTipi, temelFiyat, aciklama) VALUES
(1, 1, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-10-15', '2025-10-15 17:30:00', '2025-10-15 18:15:00', 3, 1, 'Tamamlandı', 'Sabit', 40.00, 'Okul çıkışı Tunalıya geçiyorum, bagaj boş.');

-- Sefer 2: Ayşe ODTÜ'den Çayyolu'na gidiyor (Aktif/Planlanan Sefer)
INSERT INTO Seferler (olusturanKullaniciID, aracID, seferTipi, katilimKapsami, seferTarihi, kalkisZamani, tahminiVarisZamani, maxKapasite, mevcutDoluluk, seferDurumu, fiyatlandirmaTipi, temelFiyat, aciklama) VALUES
(2, 2, 'Araç Paylaşımı', 'Sadece Kendi Üniversitesi', '2025-12-05', '2025-12-05 16:00:00', '2025-12-05 16:45:00', 3, 0, 'Planlanıyor', 'Sabit', 35.00, 'A1 kapısından alabilirim. Sadece ODTÜ öğrencileri.');

-- ============================================
-- 6. SEFER GUZERGAH NOKTALARI
-- ============================================
-- Sefer 1 için Noktalar (TOBB -> Bahçeli -> Tunalı)
INSERT INTO SeferGuzergahNoktalari (seferID, konumAdi, latitude, longitude, siraNo, planlananVarisZamani) VALUES
(1, 'TOBB ETÜ Ana Kapı', 39.9210, 32.7975, 1, '17:30:00'),
(1, 'Bahçelievler 7. Cadde', 39.9250, 32.8200, 2, '17:45:00'),
(1, 'Tunalı Hilmi Caddesi', 39.9050, 32.8600, 3, '18:15:00');

-- Sefer 2 için Noktalar (ODTÜ A1 -> Gordion)
INSERT INTO SeferGuzergahNoktalari (seferID, konumAdi, latitude, longitude, siraNo, planlananVarisZamani) VALUES
(2, 'ODTÜ A1 Kapısı', 39.8910, 32.7750, 1, '16:00:00'),
(2, 'Gordion AVM', 39.8950, 32.6500, 2, '16:45:00');

-- ============================================
-- 7. REZERVASYONLAR
-- ============================================
-- Mehmet, Ahmet'in seferine (Sefer 1) rezervasyon yapmış ve tamamlanmış.
-- Biniş: TOBB (Nokta 1), İniş: Bahçelievler (Nokta 2)
INSERT INTO Rezervasyonlar (seferID, yolcuID, binisNoktaID, inisNoktaID, yolcuSayisi, hesaplananUcret, odenecekTutar, durum, olusturulmaTarihi, onaylanmaTarihi, yolcuDegerlendirdiMi) VALUES
(1, 3, 1, 2, 1, 40.00, 40.00, 'Tamamlandı', '2025-10-14 10:00:00', '2025-10-14 11:30:00', TRUE);

-- ============================================
-- 8. ODEMELER
-- ============================================
-- Mehmet'in Ahmet'e yaptığı ödeme
INSERT INTO Odemeler (rezervasyonID, seferID, borcluID, alacakliID, tutar, platformKomisyonu, netTutar, odemeTipi, odemeDurumu, islemTarihi) VALUES
(1, 1, 3, 1, 40.00, 4.00, 36.00, 'Cüzdan', 'Ödendi', '2025-10-15 17:30:00');

-- ============================================
-- 9. YORUMLAR
-- ============================================
-- Mehmet, Ahmet'e yorum yapıyor
INSERT INTO Yorumlar (rezervasyonID, degerlendirenKullaniciID, degerlendirilenKullaniciID, seferID, puan, yorum, gorunurluk) VALUES
(1, 3, 1, 1, 5, 'Çok keyifli bir yolculuktu, Ahmet çok dakik.', 'Genel');

-- ============================================
-- 10. MESAJLAR
-- ============================================
-- Sefer 1 için konuşma
INSERT INTO Mesajlar (seferID, gonderenID, mesajMetni, gonderimZamani, okunduMu) VALUES
(1, 3, 'Selam Ahmet, tam ana kapıda bekliyorum.', '2025-10-15 17:25:00', TRUE),
(1, 1, 'Selam Mehmet, 2 dakikaya oradayım gri Egea.', '2025-10-15 17:26:00', TRUE);