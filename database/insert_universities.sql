-- UNIRING - Üniversiteleri Ekle
-- SQLTools ile çalıştır

USE uniring_db;

-- Mevcut üniversiteleri temizle (istersen)
-- DELETE FROM Universiteler;

-- Üniversiteleri ekle
INSERT INTO Universiteler (universiteAdi, emailDomain, sehir, logoURL) VALUES
-- Ankara
('TOBB Ekonomi ve Teknoloji Üniversitesi', 'etu.edu.tr', 'Ankara', 'https://logos.uniring.com/etu.png'),
('Orta Doğu Teknik Üniversitesi', 'metu.edu.tr', 'Ankara', 'https://logos.uniring.com/odtu.png'),
('İhsan Doğramacı Bilkent Üniversitesi', 'bilkent.edu.tr', 'Ankara', 'https://logos.uniring.com/bilkent.png'),
('Hacettepe Üniversitesi', 'hacettepe.edu.tr', 'Ankara', 'https://logos.uniring.com/hacettepe.png'),
('Ankara Üniversitesi', 'ankara.edu.tr', 'Ankara', 'https://logos.uniring.com/ankara.png'),
('Gazi Üniversitesi', 'gazi.edu.tr', 'Ankara', 'https://logos.uniring.com/gazi.png'),

-- İstanbul
('Boğaziçi Üniversitesi', 'boun.edu.tr', 'İstanbul', 'https://logos.uniring.com/bogazici.png'),
('İstanbul Teknik Üniversitesi', 'itu.edu.tr', 'İstanbul', 'https://logos.uniring.com/itu.png'),
('Koç Üniversitesi', 'ku.edu.tr', 'İstanbul', 'https://logos.uniring.com/koc.png'),
('Sabancı Üniversitesi', 'sabanciuniv.edu.tr', 'İstanbul', 'https://logos.uniring.com/sabanci.png'),
('Marmara Üniversitesi', 'marmara.edu.tr', 'İstanbul', 'https://logos.uniring.com/marmara.png'),
('Yıldız Teknik Üniversitesi', 'yildiz.edu.tr', 'İstanbul', 'https://logos.uniring.com/yildiz.png'),

-- İzmir
('Ege Üniversitesi', 'ege.edu.tr', 'İzmir', 'https://logos.uniring.com/ege.png'),
('Dokuz Eylül Üniversitesi', 'deu.edu.tr', 'İzmir', 'https://logos.uniring.com/deu.png'),
('İzmir Ekonomi Üniversitesi', 'ieu.edu.tr', 'İzmir', 'https://logos.uniring.com/izmirekn.png');

-- Kontrol et
SELECT universiteID, universiteAdi, emailDomain, sehir 
FROM Universiteler 
ORDER BY sehir, universiteAdi;
