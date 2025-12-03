-- ============================================
-- UNIRING - University Carpooling Platform
-- Database Schema (10 Core Tables)
-- BIL372 Database Systems Project
-- ============================================

-- Drop tables if exists (reverse order due to foreign keys)

USE uniring;


DROP TABLE IF EXISTS Mesajlar;
DROP TABLE IF EXISTS Yorumlar;
DROP TABLE IF EXISTS Odemeler;
DROP TABLE IF EXISTS CuzdanIslemleri;
DROP TABLE IF EXISTS Cuzdanlar;
DROP TABLE IF EXISTS Rezervasyonlar;
DROP TABLE IF EXISTS SeferGuzergahNoktalari;
DROP TABLE IF EXISTS Seferler;
DROP TABLE IF EXISTS Araclar;
DROP TABLE IF EXISTS Kullanicilar;
DROP TABLE IF EXISTS Universiteler;

-- ============================================
-- TABLO 1: Universiteler
-- ============================================
CREATE TABLE Universiteler (
    universiteID INT PRIMARY KEY AUTO_INCREMENT,
    universiteAdi VARCHAR(150) NOT NULL,
    emailDomain VARCHAR(100) NOT NULL UNIQUE,
    sehir VARCHAR(50) NOT NULL,
    logoURL VARCHAR(255),
    INDEX idx_email_domain (emailDomain),
    INDEX idx_sehir (sehir)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLO 2: Kullanicilar
-- ============================================
CREATE TABLE Kullanicilar (
    kullaniciID INT PRIMARY KEY AUTO_INCREMENT,
    universiteID INT NOT NULL,
    ad VARCHAR(150) NOT NULL,
    soyad VARCHAR(150) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    emailDogrulandi BOOLEAN DEFAULT FALSE,
    sifreHash VARCHAR(255) NOT NULL,
    telefonNo VARCHAR(15),  
    telefonDogrulandi BOOLEAN DEFAULT FALSE,
    cinsiyet ENUM('Erkek', 'Kadın', 'Belirtmek İstemiyorum') NOT NULL,
    dogumTarihi DATE NOT NULL,
    profilFotoURL VARCHAR(255),
    biyografi TEXT,
    cinsiyetTercihi ENUM('Fark Etmez', 'Sadece Kadın', 'Sadece Erkek') DEFAULT 'Fark Etmez',
    sigaraIciyorMu BOOLEAN DEFAULT FALSE,
    muzikTercihi VARCHAR(100),
    guvenlikSkoru DECIMAL(5,2) DEFAULT 50.00,
    ogrenciBelgesiURL VARCHAR(255) NOT NULL,
    ogrenciBelgesiOnaylandi BOOLEAN DEFAULT FALSE,
    surusBelgesiNo VARCHAR(20),
    surusBelgesiOnaylandi BOOLEAN DEFAULT FALSE,
    kayitTarihi DATETIME DEFAULT CURRENT_TIMESTAMP,
    sonGirisTarihi DATETIME,
    hesapDurumu ENUM('Aktif', 'Askıda', 'Yasaklı') DEFAULT 'Aktif',
    FOREIGN KEY (universiteID) REFERENCES Universiteler(universiteID) ON DELETE RESTRICT,
    INDEX idx_email (email),
    INDEX idx_universite (universiteID),
    INDEX idx_guvenlik_skoru (guvenlikSkoru),
    INDEX idx_hesap_durumu (hesapDurumu)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLO 3: Araclar
-- ============================================
CREATE TABLE Araclar (
    aracID INT PRIMARY KEY AUTO_INCREMENT,
    sahipID INT NOT NULL,
    plaka VARCHAR(10) NOT NULL UNIQUE,
    marka VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    renk VARCHAR(30),
    yil YEAR,
    yolcuKapasitesi TINYINT NOT NULL,
    sigortaBitisTarihi DATE,
    ruhsatFotoURL VARCHAR(255),
    onayDurumu ENUM('Beklemede', 'Onaylandı', 'Reddedildi') DEFAULT 'Beklemede',
    eklenmeTarihi DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sahipID) REFERENCES Kullanicilar(kullaniciID) ON DELETE CASCADE,
    INDEX idx_sahip (sahipID),
    INDEX idx_plaka (plaka),
    INDEX idx_onay_durumu (onayDurumu)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLO 4: Seferler
-- ============================================
CREATE TABLE Seferler (
    seferID INT PRIMARY KEY AUTO_INCREMENT,
    olusturanKullaniciID INT NOT NULL,
    aracID INT,
    seferTipi ENUM('Araç Paylaşımı', 'Ortak Araç Kullanımı') NOT NULL,
    katilimKapsami ENUM('Sadece Kendi Üniversitesi', 'Tüm Üniversiteler') DEFAULT 'Tüm Üniversiteler',
    seferTarihi DATE NOT NULL,
    kalkisZamani DATETIME NOT NULL,
    tahminiVarisZamani DATETIME,
    maxKapasite TINYINT NOT NULL,
    mevcutDoluluk TINYINT DEFAULT 0,
    seferDurumu ENUM('Planlanıyor', 'Aktif', 'Devam Ediyor', 'Tamamlandı', 'İptal Edildi') DEFAULT 'Planlanıyor',
    bagajAlaniVar BOOLEAN DEFAULT TRUE,
    klimaVar BOOLEAN DEFAULT TRUE,
    aciklama TEXT,
    fiyatlandirmaTipi ENUM('Sabit', 'Dinamik') DEFAULT 'Sabit',
    temelFiyat DECIMAL(10,2) NOT NULL,
    olusturulmaTarihi DATETIME DEFAULT CURRENT_TIMESTAMP,
    iptalNedeni TEXT,
    FOREIGN KEY (olusturanKullaniciID) REFERENCES Kullanicilar(kullaniciID) ON DELETE CASCADE,
    FOREIGN KEY (aracID) REFERENCES Araclar(aracID) ON DELETE SET NULL,
    INDEX idx_organizator (olusturanKullaniciID),
    INDEX idx_sefer_tarihi (seferTarihi),
    INDEX idx_kalkis_zamani (kalkisZamani),
    INDEX idx_sefer_durumu (seferDurumu),
    INDEX idx_katilim_kapsami (katilimKapsami),
    INDEX idx_sefer_tipi (seferTipi)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLO 5: SeferGuzergahNoktalari
-- ============================================
CREATE TABLE SeferGuzergahNoktalari (
    noktaID INT PRIMARY KEY AUTO_INCREMENT,
    seferID INT NOT NULL,
    konumAdi VARCHAR(255) NOT NULL,
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    siraNo TINYINT NOT NULL,
    planlananVarisZamani TIME,
    gercekVarisZamani DATETIME,
    mesafeOncekiNoktaya DECIMAL(6,2),
    FOREIGN KEY (seferID) REFERENCES Seferler(seferID) ON DELETE CASCADE,
    INDEX idx_sefer (seferID),
    INDEX idx_sira (seferID, siraNo),
    INDEX idx_konum (konumAdi)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLO 6: Rezervasyonlar
-- ============================================
CREATE TABLE Rezervasyonlar (
    rezervasyonID INT PRIMARY KEY AUTO_INCREMENT,
    seferID INT NOT NULL,
    yolcuID INT NOT NULL,
    binisNoktaID INT NOT NULL,
    inisNoktaID INT NOT NULL,
    yolcuSayisi TINYINT DEFAULT 1,
    hesaplananUcret DECIMAL(10,2) NOT NULL,
    indirimMiktari DECIMAL(10,2) DEFAULT 0.00,
    odenecekTutar DECIMAL(10,2) NOT NULL,
    durum ENUM('Beklemede', 'Onaylandı', 'Reddedildi', 'İptal Edildi', 'Tamamlandı') DEFAULT 'Beklemede',
    olusturulmaTarihi DATETIME DEFAULT CURRENT_TIMESTAMP,
    onaylanmaTarihi DATETIME,
    iptalNedeni TEXT,
    yolcuDegerlendirdiMi BOOLEAN DEFAULT FALSE,
    organizatorDegerlendirdiMi BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (seferID) REFERENCES Seferler(seferID) ON DELETE CASCADE,
    FOREIGN KEY (yolcuID) REFERENCES Kullanicilar(kullaniciID) ON DELETE CASCADE,
    FOREIGN KEY (binisNoktaID) REFERENCES SeferGuzergahNoktalari(noktaID) ON DELETE RESTRICT,
    FOREIGN KEY (inisNoktaID) REFERENCES SeferGuzergahNoktalari(noktaID) ON DELETE RESTRICT,
    INDEX idx_sefer (seferID),
    INDEX idx_yolcu (yolcuID),
    INDEX idx_durum (durum),
    INDEX idx_tarih (olusturulmaTarihi)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLO 7: Cuzdanlar
-- ============================================
CREATE TABLE Cuzdanlar (
    cuzdanID INT PRIMARY KEY AUTO_INCREMENT,
    kullaniciID INT NOT NULL UNIQUE,
    bakiye DECIMAL(10,2) DEFAULT 0.00,
    sonGuncelleme DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (kullaniciID) REFERENCES Kullanicilar(kullaniciID) ON DELETE CASCADE,
    INDEX idx_kullanici (kullaniciID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLO 8: Odemeler
-- ============================================
CREATE TABLE Odemeler (
    odemeID INT PRIMARY KEY AUTO_INCREMENT,
    rezervasyonID INT,
    seferID INT NOT NULL,
    borcluID INT NOT NULL,
    alacakliID INT NOT NULL,
    tutar DECIMAL(10,2) NOT NULL,
    platformKomisyonu DECIMAL(10,2) DEFAULT 0.00,
    netTutar DECIMAL(10,2) NOT NULL,
    odemeTipi ENUM('Cüzdan', 'Kredi Kartı', 'IBAN', 'Nakit') DEFAULT 'Cüzdan',
    odemeDurumu ENUM('Ödenmedi', 'Onay Bekliyor', 'Ödendi', 'İade Edildi') DEFAULT 'Ödenmedi',
    islemTarihi DATETIME DEFAULT CURRENT_TIMESTAMP,
    onayTarihi DATETIME,
    faturaURL VARCHAR(255),
    FOREIGN KEY (rezervasyonID) REFERENCES Rezervasyonlar(rezervasyonID) ON DELETE SET NULL,
    FOREIGN KEY (seferID) REFERENCES Seferler(seferID) ON DELETE CASCADE,
    FOREIGN KEY (borcluID) REFERENCES Kullanicilar(kullaniciID) ON DELETE RESTRICT,
    FOREIGN KEY (alacakliID) REFERENCES Kullanicilar(kullaniciID) ON DELETE RESTRICT,
    INDEX idx_rezervasyon (rezervasyonID),
    INDEX idx_sefer (seferID),
    INDEX idx_borclu (borcluID),
    INDEX idx_alacakli (alacakliID),
    INDEX idx_durum (odemeDurumu),
    INDEX idx_tarih (islemTarihi)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLO 9: Yorumlar
-- ============================================
CREATE TABLE Yorumlar (
    yorumID INT PRIMARY KEY AUTO_INCREMENT,
    rezervasyonID INT NOT NULL,
    degerlendirenKullaniciID INT NOT NULL,
    degerlendirilenKullaniciID INT NOT NULL,
    seferID INT NOT NULL,
    puan TINYINT NOT NULL CHECK (puan BETWEEN 1 AND 5),
    yorum TEXT,
    kategoriler JSON,
    yorumTarihi DATETIME DEFAULT CURRENT_TIMESTAMP,
    gorunurluk ENUM('Genel', 'Sadece Kullanıcı', 'Gizli') DEFAULT 'Genel',
    FOREIGN KEY (rezervasyonID) REFERENCES Rezervasyonlar(rezervasyonID) ON DELETE CASCADE,
    FOREIGN KEY (degerlendirenKullaniciID) REFERENCES Kullanicilar(kullaniciID) ON DELETE CASCADE,
    FOREIGN KEY (degerlendirilenKullaniciID) REFERENCES Kullanicilar(kullaniciID) ON DELETE CASCADE,
    FOREIGN KEY (seferID) REFERENCES Seferler(seferID) ON DELETE CASCADE,
    INDEX idx_rezervasyon (rezervasyonID),
    INDEX idx_degerlendirilen (degerlendirilenKullaniciID),
    INDEX idx_puan (puan),
    INDEX idx_tarih (yorumTarihi)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLO 10: Mesajlar
-- ============================================
CREATE TABLE Mesajlar (
    mesajID INT PRIMARY KEY AUTO_INCREMENT,
    seferID INT NOT NULL,
    gonderenID INT NOT NULL,
    mesajMetni TEXT NOT NULL,
    gonderimZamani DATETIME DEFAULT CURRENT_TIMESTAMP,
    okunduMu BOOLEAN DEFAULT FALSE,
    mesajTipi ENUM('Metin', 'Konum', 'Dosya') DEFAULT 'Metin',
    dosyaURL VARCHAR(255),
    FOREIGN KEY (seferID) REFERENCES Seferler(seferID) ON DELETE CASCADE,
    FOREIGN KEY (gonderenID) REFERENCES Kullanicilar(kullaniciID) ON DELETE CASCADE,
    INDEX idx_sefer (seferID),
    INDEX idx_gonderen (gonderenID),
    INDEX idx_tarih (gonderimZamani),
    INDEX idx_okundu (okunduMu)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- END OF SCHEMA
-- ============================================
