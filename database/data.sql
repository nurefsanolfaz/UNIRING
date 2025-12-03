-- ============================================
-- UNIRING - TEST VERİSİ: ÜNİVERSİTELER
-- ADIM 1/10
-- ============================================

USE uniring_db;

INSERT INTO Universiteler (universiteAdi, emailDomain, sehir, logoURL) VALUES
-- Ankara (6)
('TOBB Ekonomi ve Teknoloji Üniversitesi', 'etu.edu.tr', 'Ankara', 'https://logos.uniring.com/etu.png'),
('Orta Doğu Teknik Üniversitesi', 'metu.edu.tr', 'Ankara', 'https://logos.uniring.com/odtu.png'),
('İhsan Doğramacı Bilkent Üniversitesi', 'bilkent.edu.tr', 'Ankara', 'https://logos.uniring.com/bilkent.png'),
('Hacettepe Üniversitesi', 'hacettepe.edu.tr', 'Ankara', 'https://logos.uniring.com/hacettepe.png'),
('Ankara Üniversitesi', 'ankara.edu.tr', 'Ankara', 'https://logos.uniring.com/ankara.png'),
('Gazi Üniversitesi', 'gazi.edu.tr', 'Ankara', 'https://logos.uniring.com/gazi.png'),

-- İstanbul (6)
('Boğaziçi Üniversitesi', 'boun.edu.tr', 'İstanbul', 'https://logos.uniring.com/bogazici.png'),
('İstanbul Teknik Üniversitesi', 'itu.edu.tr', 'İstanbul', 'https://logos.uniring.com/itu.png'),
('Koç Üniversitesi', 'ku.edu.tr', 'İstanbul', 'https://logos.uniring.com/koc.png'),
('Sabancı Üniversitesi', 'sabanciuniv.edu.tr', 'İstanbul', 'https://logos.uniring.com/sabanci.png'),
('Marmara Üniversitesi', 'marmara.edu.tr', 'İstanbul', 'https://logos.uniring.com/marmara.png'),
('Yıldız Teknik Üniversitesi', 'yildiz.edu.tr', 'İstanbul', 'https://logos.uniring.com/yildiz.png'),

-- İzmir (3)
('Ege Üniversitesi', 'ege.edu.tr', 'İzmir', 'https://logos.uniring.com/ege.png'),
('Dokuz Eylül Üniversitesi', 'deu.edu.tr', 'İzmir', 'https://logos.uniring.com/deu.png'),
('İzmir Ekonomi Üniversitesi', 'ieu.edu.tr', 'İzmir', 'https://logos.uniring.com/izmirekn.png'),

-- Diğer şehirler (10)
('Anadolu Üniversitesi', 'anadolu.edu.tr', 'Eskişehir', 'https://logos.uniring.com/anadolu.png'),
('Osmangazi Üniversitesi', 'ogu.edu.tr', 'Eskişehir', 'https://logos.uniring.com/ogu.png'),
('Akdeniz Üniversitesi', 'akdeniz.edu.tr', 'Antalya', 'https://logos.uniring.com/akdeniz.png'),
('Kocaeli Üniversitesi', 'kocaeli.edu.tr', 'Kocaeli', 'https://logos.uniring.com/kocaeli.png'),
('Gaziantep Üniversitesi', 'gantep.edu.tr', 'Gaziantep', 'https://logos.uniring.com/gantep.png'),
('Ondokuz Mayıs Üniversitesi', 'omu.edu.tr', 'Samsun', 'https://logos.uniring.com/omu.png'),
('Karadeniz Teknik Üniversitesi', 'ktu.edu.tr', 'Trabzon', 'https://logos.uniring.com/ktu.png'),
('Selçuk Üniversitesi', 'selcuk.edu.tr', 'Konya', 'https://logos.uniring.com/selcuk.png'),
('Çukurova Üniversitesi', 'cu.edu.tr', 'Adana', 'https://logos.uniring.com/cu.png'),
('Uludağ Üniversitesi', 'uludag.edu.tr', 'Bursa', 'https://logos.uniring.com/uludag.png');

-- ============================================
-- UNIRING - TEST VERİSİ: KULLANICILAR
-- ADIM 2/10 - 120 Kullanıcı
-- ============================================

INSERT INTO Kullanicilar (universiteID, ad, soyad, email, emailDogrulandi, sifreHash, telefonNo, telefonDogrulandi, cinsiyet, dogumTarihi, profilFotoURL, biyografi, cinsiyetTercihi, sigaraIciyorMu, muzikTercihi, guvenlikSkoru, ogrenciBelgesiURL, ogrenciBelgesiOnaylandi, surusBelgesiNo, surusBelgesiOnaylandi, hesapDurumu) VALUES

-- TOBB ETÜ Kullanıcıları (15 kişi)
(1, 'Ahmet', 'Yılmaz', 'ahmet.yilmaz@etu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeC', '5551234567', TRUE, 'Erkek', '2002-03-15', 'https://i.pravatar.cc/150?img=11', 'Bilgisayar mühendisliği 3. sınıf öğrencisiyim. Sabah erken kalkmayı severim.', 'Fark Etmez', FALSE, 'Pop, Rock', 95.50, 'https://docs.uniring.com/ogrenci_1.pdf', TRUE, 'U12345678', TRUE, 'Aktif'),
(1, 'Ayşe', 'Demir', 'ayse.demir@etu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeD', '5551234568', TRUE, 'Kadın', '2003-05-20', 'https://i.pravatar.cc/150?img=5', 'Endüstri mühendisliği okuyorum. Temiz ve sessiz yolculukları tercih ederim.', 'Sadece Kadın', FALSE, 'Klasik, Caz', 98.00, 'https://docs.uniring.com/ogrenci_2.pdf', TRUE, 'U23456789', TRUE, 'Aktif'),
(1, 'Mehmet', 'Kaya', 'mehmet.kaya@etu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeE', '5551234569', TRUE, 'Erkek', '2001-08-10', 'https://i.pravatar.cc/150?img=12', 'Spor bilimleri bölümündeyim. Aktif ve sosyal biriyim.', 'Fark Etmez', FALSE, 'Rap, Hip-Hop', 87.30, 'https://docs.uniring.com/ogrenci_3.pdf', TRUE, NULL, FALSE, 'Aktif'),
(1, 'Zeynep', 'Çelik', 'zeynep.celik@etu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeF', '5551234570', TRUE, 'Kadın', '2002-11-25', 'https://i.pravatar.cc/150?img=9', 'İşletme 2. sınıf. Yolculuk sırasında çalışmayı severim.', 'Fark Etmez', FALSE, 'İndie, Alternatif', 92.00, 'https://docs.uniring.com/ogrenci_4.pdf', TRUE, NULL, FALSE, 'Aktif'),
(1, 'Can', 'Öztürk', 'can.ozturk@etu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeG', '5551234571', TRUE, 'Erkek', '2003-01-05', 'https://i.pravatar.cc/150?img=13', 'Makine mühendisliği öğrencisiyim.', 'Fark Etmez', FALSE, 'Elektronik, House', 89.50, 'https://docs.uniring.com/ogrenci_5.pdf', TRUE, 'U34567890', TRUE, 'Aktif'),
(1, 'Elif', 'Arslan', 'elif.arslan@etu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeH', '5551234572', FALSE, 'Kadın', '2002-06-12', 'https://i.pravatar.cc/150?img=10', 'Mimarlık okuyorum. Yaratıcı biriyim.', 'Sadece Kadın', FALSE, 'Pop', 91.00, 'https://docs.uniring.com/ogrenci_6.pdf', TRUE, NULL, FALSE, 'Aktif'),
(1, 'Burak', 'Şahin', 'burak.sahin@etu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeI', '5551234573', TRUE, 'Erkek', '2001-09-18', 'https://i.pravatar.cc/150?img=14', 'Elektrik-Elektronik mühendisliği.', 'Fark Etmez', TRUE, 'Rock, Metal', 85.20, 'https://docs.uniring.com/ogrenci_7.pdf', TRUE, 'U45678901', TRUE, 'Aktif'),
(1, 'Selin', 'Aydın', 'selin.aydin@etu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeJ', '5551234574', TRUE, 'Kadın', '2003-04-22', 'https://i.pravatar.cc/150?img=20', 'Hukuk fakültesi 1. sınıf.', 'Fark Etmez', FALSE, 'Pop, R&B', 93.50, 'https://docs.uniring.com/ogrenci_8.pdf', TRUE, NULL, FALSE, 'Aktif'),
(1, 'Emre', 'Koç', 'emre.koc@etu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeK', '5551234575', TRUE, 'Erkek', '2002-12-08', 'https://i.pravatar.cc/150?img=15', 'Ekonomi bölümü öğrencisiyim.', 'Fark Etmez', FALSE, 'Jazz, Blues', 88.00, 'https://docs.uniring.com/ogrenci_9.pdf', TRUE, 'U56789012', TRUE, 'Aktif'),
(1, 'Deniz', 'Yıldız', 'deniz.yildiz@etu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeL', '5551234576', FALSE, 'Kadın', '2001-07-30', 'https://i.pravatar.cc/150?img=23', 'Uluslararası ilişkiler okuyorum.', 'Fark Etmez', FALSE, 'Pop', 90.00, 'https://docs.uniring.com/ogrenci_10.pdf', TRUE, NULL, FALSE, 'Aktif'),
(1, 'Cem', 'Bulut', 'cem.bulut@etu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeM', '5551234577', TRUE, 'Erkek', '2003-02-14', 'https://i.pravatar.cc/150?img=16', 'Yazılım geliştiriyorum, yeni teknolojilere ilgiliyim.', 'Fark Etmez', FALSE, 'Elektronik', 94.00, 'https://docs.uniring.com/ogrenci_11.pdf', TRUE, 'U67890123', TRUE, 'Aktif'),
(1, 'Gizem', 'Erdoğan', 'gizem.erdogan@etu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeN', '5551234578', TRUE, 'Kadın', '2002-10-05', 'https://i.pravatar.cc/150?img=24', 'Psikoloji öğrencisiyim.', 'Sadece Kadın', FALSE, 'Klasik', 96.00, 'https://docs.uniring.com/ogrenci_12.pdf', TRUE, NULL, FALSE, 'Aktif'),
(1, 'Kaan', 'Aslan', 'kaan.aslan@etu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeO', '5551234579', TRUE, 'Erkek', '2001-05-17', 'https://i.pravatar.cc/150?img=17', 'Kimya mühendisliği son sınıf.', 'Fark Etmez', FALSE, 'Rock', 86.50, 'https://docs.uniring.com/ogrenci_13.pdf', TRUE, 'U78901234', TRUE, 'Aktif'),
(1, 'İrem', 'Yurt', 'irem.yurt@etu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeP', '5551234580', TRUE, 'Kadın', '2003-03-09', 'https://i.pravatar.cc/150?img=25', 'Biyoloji öğrencisiyim.', 'Fark Etmez', FALSE, 'Pop', 89.00, 'https://docs.uniring.com/ogrenci_14.pdf', TRUE, NULL, FALSE, 'Aktif'),
(1, 'Onur', 'Kılıç', 'onur.kilic@etu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeQ', '5551234581', TRUE, 'Erkek', '2002-08-21', 'https://i.pravatar.cc/150?img=18', 'İnşaat mühendisliği 3. sınıf.', 'Fark Etmez', TRUE, 'Hip-Hop', 83.00, 'https://docs.uniring.com/ogrenci_15.pdf', TRUE, 'U89012345', TRUE, 'Aktif'),

-- ODTÜ Kullanıcıları (15 kişi)
(2, 'Ali', 'Yavuz', 'ali.yavuz@metu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeR', '5552234567', TRUE, 'Erkek', '2001-04-12', 'https://i.pravatar.cc/150?img=19', 'Bilgisayar mühendisliği master öğrencisiyim.', 'Fark Etmez', FALSE, 'Rock, Alternative', 97.00, 'https://docs.uniring.com/ogrenci_16.pdf', TRUE, 'U90123456', TRUE, 'Aktif'),
(2, 'Merve', 'Güler', 'merve.guler@metu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeS', '5552234568', TRUE, 'Kadın', '2002-07-25', 'https://i.pravatar.cc/150?img=26', 'Elektrik-Elektronik mühendisliği.', 'Fark Etmez', FALSE, 'Pop, Jazz', 94.50, 'https://docs.uniring.com/ogrenci_17.pdf', TRUE, 'U01234567', TRUE, 'Aktif'),
(2, 'Barış', 'Şen', 'baris.sen@metu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeT', '5552234569', TRUE, 'Erkek', '2003-01-18', 'https://i.pravatar.cc/150?img=20', 'Makine mühendisliği 2. sınıf.', 'Fark Etmez', FALSE, 'Elektronik', 91.00, 'https://docs.uniring.com/ogrenci_18.pdf', TRUE, NULL, FALSE, 'Aktif'),
(2, 'Ezgi', 'Akın', 'ezgi.akin@metu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeU', '5552234570', TRUE, 'Kadın', '2001-09-30', 'https://i.pravatar.cc/150?img=27', 'Endüstri mühendisliği son sınıf.', 'Sadece Kadın', FALSE, 'Pop', 95.00, 'https://docs.uniring.com/ogrenci_19.pdf', TRUE, NULL, FALSE, 'Aktif'),
(2, 'Murat', 'Özkan', 'murat.ozkan@metu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeV', '5552234571', TRUE, 'Erkek', '2002-05-14', 'https://i.pravatar.cc/150?img=21', 'Kimya mühendisliği.', 'Fark Etmez', TRUE, 'Rock', 88.00, 'https://docs.uniring.com/ogrenci_20.pdf', TRUE, 'U12345670', TRUE, 'Aktif'),
(2, 'Ceren', 'Tekin', 'ceren.tekin@metu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeW', '5552234572', TRUE, 'Kadın', '2003-11-08', 'https://i.pravatar.cc/150?img=28', 'Mimarlık 1. sınıf öğrencisiyim.', 'Fark Etmez', FALSE, 'İndie', 92.50, 'https://docs.uniring.com/ogrenci_21.pdf', TRUE, NULL, FALSE, 'Aktif'),
(2, 'Oğuz', 'Demirci', 'oguz.demirci@metu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeX', '5552234573', TRUE, 'Erkek', '2001-12-22', 'https://i.pravatar.cc/150?img=22', 'İnşaat mühendisliği.', 'Fark Etmez', FALSE, 'Metal', 86.00, 'https://docs.uniring.com/ogrenci_22.pdf', TRUE, 'U23456781', TRUE, 'Aktif'),
(2, 'Pınar', 'Kurt', 'pinar.kurt@metu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeY', '5552234574', TRUE, 'Kadın', '2002-03-16', 'https://i.pravatar.cc/150?img=29', 'Biyoloji bölümü öğrencisiyim.', 'Fark Etmez', FALSE, 'Klasik', 93.00, 'https://docs.uniring.com/ogrenci_23.pdf', TRUE, NULL, FALSE, 'Aktif'),
(2, 'Serkan', 'Acar', 'serkan.acar@metu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeZ', '5552234575', TRUE, 'Erkek', '2003-06-05', 'https://i.pravatar.cc/150?img=23', 'Fizik bölümü 2. sınıf.', 'Fark Etmez', FALSE, 'Jazz', 90.00, 'https://docs.uniring.com/ogrenci_24.pdf', TRUE, 'U34567892', TRUE, 'Aktif'),
(2, 'Gamze', 'Öz', 'gamze.oz@metu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lf0', '5552234576', TRUE, 'Kadın', '2001-10-19', 'https://i.pravatar.cc/150?img=30', 'Matematik bölümü öğrencisiyim.', 'Sadece Kadın', FALSE, 'Pop', 94.00, 'https://docs.uniring.com/ogrenci_25.pdf', TRUE, NULL, FALSE, 'Aktif'),
(2, 'Tolga', 'Çakır', 'tolga.cakir@metu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lf1', '5552234577', TRUE, 'Erkek', '2002-02-28', 'https://i.pravatar.cc/150?img=24', 'Jeoloji mühendisliği.', 'Fark Etmez', TRUE, 'Rock', 84.50, 'https://docs.uniring.com/ogrenci_26.pdf', TRUE, 'U45678903', TRUE, 'Aktif'),
(2, 'Aslı', 'Polat', 'asli.polat@metu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lf2', '5552234578', TRUE, 'Kadın', '2003-08-11', 'https://i.pravatar.cc/150?img=31', 'İstatistik bölümü.', 'Fark Etmez', FALSE, 'Pop, R&B', 91.50, 'https://docs.uniring.com/ogrenci_27.pdf', TRUE, NULL, FALSE, 'Aktif'),
(2, 'Kerem', 'Uysal', 'kerem.uysal@metu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lf3', '5552234579', TRUE, 'Erkek', '2001-11-24', 'https://i.pravatar.cc/150?img=25', 'Havacılık ve uzay mühendisliği.', 'Fark Etmez', FALSE, 'Elektronik', 96.50, 'https://docs.uniring.com/ogrenci_28.pdf', TRUE, 'U56789014', TRUE, 'Aktif'),
(2, 'Burcu', 'Öztürk', 'burcu.ozturk@metu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lf4', '5552234580', TRUE, 'Kadın', '2002-04-07', 'https://i.pravatar.cc/150?img=32', 'Çevre mühendisliği öğrencisiyim.', 'Fark Etmez', FALSE, 'İndie', 89.50, 'https://docs.uniring.com/ogrenci_29.pdf', TRUE, NULL, FALSE, 'Aktif'),
(2, 'Hakan', 'Erdem', 'hakan.erdem@metu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lf5', '5552234581', TRUE, 'Erkek', '2003-09-13', 'https://i.pravatar.cc/150?img=26', 'Gıda mühendisliği 1. sınıf.', 'Fark Etmez', FALSE, 'Pop', 87.00, 'https://docs.uniring.com/ogrenci_30.pdf', TRUE, 'U67890125', TRUE, 'Aktif'),

-- Bilkent Kullanıcıları (12 kişi)
(3, 'Arda', 'Yılmaz', 'arda.yilmaz@bilkent.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lf6', '5553234567', TRUE, 'Erkek', '2002-01-20', 'https://i.pravatar.cc/150?img=27', 'Bilgisayar bilimleri doktora öğrencisiyim.', 'Fark Etmez', FALSE, 'Klasik, Jazz', 98.50, 'https://docs.uniring.com/ogrenci_31.pdf', TRUE, 'U78901236', TRUE, 'Aktif'),
(3, 'Naz', 'Demirkan', 'naz.demirkan@bilkent.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lf7', '5553234568', TRUE, 'Kadın', '2001-06-15', 'https://i.pravatar.cc/150?img=33', 'İktisat bölümü son sınıf.', 'Fark Etmez', FALSE, 'Pop', 95.50, 'https://docs.uniring.com/ogrenci_32.pdf', TRUE, 'U89012347', TRUE, 'Aktif'),
(3, 'Berk', 'Tuncer', 'berk.tuncer@bilkent.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lf8', '5553234569', TRUE, 'Erkek', '2003-03-08', 'https://i.pravatar.cc/150?img=28', 'İşletme 2. sınıf öğrencisiyim.', 'Fark Etmez', FALSE, 'Elektronik', 92.00, 'https://docs.uniring.com/ogrenci_33.pdf', TRUE, NULL, FALSE, 'Aktif'),
(3, 'Derin', 'Kaya', 'derin.kaya@bilkent.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lf9', '5553234570', TRUE, 'Kadın', '2002-09-27', 'https://i.pravatar.cc/150?img=34', 'Uluslararası ilişkiler okuyorum.', 'Sadece Kadın', FALSE, 'İndie', 93.50, 'https://docs.uniring.com/ogrenci_34.pdf', TRUE, NULL, FALSE, 'Aktif'),
(3, 'Ege', 'Ateş', 'ege.ates@bilkent.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lg0', '5553234571', TRUE, 'Erkek', '2001-12-03', 'https://i.pravatar.cc/150?img=29', 'Hukuk fakültesi öğrencisiyim.', 'Fark Etmez', FALSE, 'Rock', 90.00, 'https://docs.uniring.com/ogrenci_35.pdf', TRUE, 'U90123458', TRUE, 'Aktif'),
(3, 'Ece', 'Yaman', 'ece.yaman@bilkent.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lg1', '5553234572', TRUE, 'Kadın', '2003-05-19', 'https://i.pravatar.cc/150?img=35', 'Psikoloji bölümü 1. sınıf.', 'Fark Etmez', FALSE, 'Pop', 94.00, 'https://docs.uniring.com/ogrenci_36.pdf', TRUE, NULL, FALSE, 'Aktif'),
(3, 'Alp', 'Özkan', 'alp.ozkan@bilkent.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lg2', '5553234573', TRUE, 'Erkek', '2002-08-12', 'https://i.pravatar.cc/150?img=30', 'Elektrik-Elektronik mühendisliği.', 'Fark Etmez', FALSE, 'Jazz', 91.50, 'https://docs.uniring.com/ogrenci_37.pdf', TRUE, 'U01234569', TRUE, 'Aktif'),
(3, 'Su', 'Güneş', 'su.gunes@bilkent.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lg3', '5553234574', TRUE, 'Kadın', '2001-11-28', 'https://i.pravatar.cc/150?img=36', 'Endüstri mühendisliği son sınıf.', 'Fark Etmez', FALSE, 'Klasik', 96.00, 'https://docs.uniring.com/ogrenci_38.pdf', TRUE, NULL, FALSE, 'Aktif'),
(3, 'Yiğit', 'Başar', 'yigit.basar@bilkent.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lg4', '5553234575', TRUE, 'Erkek', '2003-02-14', 'https://i.pravatar.cc/150?img=31', 'Makine mühendisliği 2. sınıf.', 'Fark Etmez', TRUE, 'Metal', 85.00, 'https://docs.uniring.com/ogrenci_39.pdf', TRUE, 'U12345681', TRUE, 'Aktif'),
(3, 'Ela', 'Şimşek', 'ela.simsek@bilkent.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lg5', '5553234576', TRUE, 'Kadın', '2002-07-06', 'https://i.pravatar.cc/150?img=37', 'Mimarlık öğrencisiyim.', 'Sadece Kadın', FALSE, 'Pop, R&B', 92.50, 'https://docs.uniring.com/ogrenci_40.pdf', TRUE, NULL, FALSE, 'Aktif'),
(3, 'Kağan', 'Demir', 'kagan.demir@bilkent.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lg6', '5553234577', TRUE, 'Erkek', '2001-10-22', 'https://i.pravatar.cc/150?img=32', 'İnşaat mühendisliği.', 'Fark Etmez', FALSE, 'Hip-Hop', 88.00, 'https://docs.uniring.com/ogrenci_41.pdf', TRUE, 'U23456792', TRUE, 'Aktif'),
(3, 'Lara', 'Çetin', 'lara.cetin@bilkent.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lg7', '5553234578', TRUE, 'Kadın', '2003-04-17', 'https://i.pravatar.cc/150?img=38', 'Moleküler biyoloji ve genetik.', 'Fark Etmez', FALSE, 'İndie', 93.00, 'https://docs.uniring.com/ogrenci_42.pdf', TRUE, NULL, FALSE, 'Aktif'),

-- Hacettepe Kullanıcıları (10 kişi)
(4, 'Sinan', 'Aydın', 'sinan.aydin@hacettepe.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lg8', '5554234567', TRUE, 'Erkek', '2002-02-11', 'https://i.pravatar.cc/150?img=33', 'Tıp fakültesi 4. sınıf öğrencisiyim.', 'Fark Etmez', FALSE, 'Klasik', 97.00, 'https://docs.uniring.com/ogrenci_43.pdf', TRUE, 'U34567893', TRUE, 'Aktif'),
(4, 'Melis', 'Karaca', 'melis.karaca@hacettepe.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lg9', '5554234568', TRUE, 'Kadın', '2001-07-23', 'https://i.pravatar.cc/150?img=39', 'Hemşirelik bölümü son sınıf.', 'Fark Etmez', FALSE, 'Pop', 94.50, 'https://docs.uniring.com/ogrenci_44.pdf', TRUE, NULL, FALSE, 'Aktif'),
(4, 'Orkun', 'Topal', 'orkun.topal@hacettepe.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lh0', '5554234569', TRUE, 'Erkek', '2003-01-09', 'https://i.pravatar.cc/150?img=34', 'Eczacılık 2. sınıf öğrencisiyim.', 'Fark Etmez', FALSE, 'Rock', 90.00, 'https://docs.uniring.com/ogrenci_45.pdf', TRUE, 'U45678904', TRUE, 'Aktif'),
(4, 'Dilara', 'Bozkurt', 'dilara.bozkurt@hacettepe.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lh1', '5554234570', TRUE, 'Kadın', '2002-06-18', 'https://i.pravatar.cc/150?img=40', 'Diş hekimliği fakültesi.', 'Sadece Kadın', FALSE, 'Jazz', 95.00, 'https://docs.uniring.com/ogrenci_46.pdf', TRUE, NULL, FALSE, 'Aktif'),
(4, 'Eren', 'Koçak', 'eren.kocak@hacettepe.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lh2', '5554234571', TRUE, 'Erkek', '2001-11-04', 'https://i.pravatar.cc/150?img=35', 'Biyoloji bölümü öğrencisiyim.', 'Fark Etmez', FALSE, 'Elektronik', 89.00, 'https://docs.uniring.com/ogrenci_47.pdf', TRUE, 'U56789015', TRUE, 'Aktif'),
(4, 'Seda', 'Altın', 'seda.altin@hacettepe.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lh3', '5554234572', TRUE, 'Kadın', '2003-04-26', 'https://i.pravatar.cc/150?img=41', 'Fizyoterapi ve rehabilitasyon.', 'Fark Etmez', FALSE, 'Pop', 92.50, 'https://docs.uniring.com/ogrenci_48.pdf', TRUE, NULL, FALSE, 'Aktif'),
(4, 'Uğur', 'Bayram', 'ugur.bayram@hacettepe.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lh4', '5554234573', TRUE, 'Erkek', '2002-09-15', 'https://i.pravatar.cc/150?img=36', 'Kimya bölümü.', 'Fark Etmez', TRUE, 'Metal', 86.50, 'https://docs.uniring.com/ogrenci_49.pdf', TRUE, 'U67890126', TRUE, 'Aktif'),
(4, 'İpek', 'Doğan', 'ipek.dogan@hacettepe.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lh5', '5554234574', TRUE, 'Kadın', '2001-12-29', 'https://i.pravatar.cc/150?img=42', 'Beslenme ve diyetetik bölümü.', 'Fark Etmez', FALSE, 'İndie', 91.00, 'https://docs.uniring.com/ogrenci_50.pdf', TRUE, NULL, FALSE, 'Aktif'),
(4, 'Umut', 'Şahin', 'umut.sahin@hacettepe.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lh6', '5554234575', TRUE, 'Erkek', '2003-03-21', 'https://i.pravatar.cc/150?img=37', 'Spor bilimleri fakültesi.', 'Fark Etmez', FALSE, 'Hip-Hop', 88.50, 'https://docs.uniring.com/ogrenci_51.pdf', TRUE, 'U78901237', TRUE, 'Aktif'),
(4, 'Nehir', 'Özdemir', 'nehir.ozdemir@hacettepe.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lh7', '5554234576', TRUE, 'Kadın', '2002-08-07', 'https://i.pravatar.cc/150?img=43', 'Psikoloji bölümü son sınıf.', 'Sadece Kadın', FALSE, 'Pop, R&B', 93.50, 'https://docs.uniring.com/ogrenci_52.pdf', TRUE, NULL, FALSE, 'Aktif'),

-- Boğaziçi Kullanıcıları (12 kişi)
(7, 'Taylan', 'Karaman', 'taylan.karaman@boun.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lh8', '5557234567', TRUE, 'Erkek', '2001-05-13', 'https://i.pravatar.cc/150?img=38', 'Bilgisayar mühendisliği master.', 'Fark Etmez', FALSE, 'Jazz, Blues', 98.00, 'https://docs.uniring.com/ogrenci_53.pdf', TRUE, 'U89012348', TRUE, 'Aktif'),
(7, 'Rüya', 'Çelik', 'ruya.celik@boun.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lh9', '5557234568', TRUE, 'Kadın', '2002-10-28', 'https://i.pravatar.cc/150?img=44', 'İşletme fakültesi son sınıf.', 'Fark Etmez', FALSE, 'Pop', 96.00, 'https://docs.uniring.com/ogrenci_54.pdf', TRUE, 'U90123459', TRUE, 'Aktif'),
(7, 'Doruk', 'Özgür', 'doruk.ozgur@boun.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Li0', '5557234569', TRUE, 'Erkek', '2003-02-16', 'https://i.pravatar.cc/150?img=39', 'Elektrik-Elektronik mühendisliği.', 'Fark Etmez', FALSE, 'Rock', 93.00, 'https://docs.uniring.com/ogrenci_55.pdf', TRUE, NULL, FALSE, 'Aktif'),
(7, 'Defne', 'Yılmaz', 'defne.yilmaz@boun.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Li1', '5557234570', TRUE, 'Kadın', '2001-07-09', 'https://i.pravatar.cc/150?img=45', 'Ekonomi bölümü öğrencisiyim.', 'Fark Etmez', FALSE, 'Klasik', 94.50, 'https://docs.uniring.com/ogrenci_56.pdf', TRUE, NULL, FALSE, 'Aktif'),
(7, 'Kıvanç', 'Güzel', 'kivanc.guzel@boun.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Li2', '5557234571', TRUE, 'Erkek', '2002-12-24', 'https://i.pravatar.cc/150?img=40', 'Makine mühendisliği.', 'Fark Etmez', FALSE, 'Elektronik', 91.00, 'https://docs.uniring.com/ogrenci_57.pdf', TRUE, 'U01234570', TRUE, 'Aktif'),
(7, 'Yasemin', 'Avcı', 'yasemin.avci@boun.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Li3', '5557234572', TRUE, 'Kadın', '2003-05-06', 'https://i.pravatar.cc/150?img=46', 'Uluslararası ilişkiler 2. sınıf.', 'Sadece Kadın', FALSE, 'Pop', 95.50, 'https://docs.uniring.com/ogrenci_58.pdf', TRUE, NULL, FALSE, 'Aktif'),
(7, 'Berkay', 'Turan', 'berkay.turan@boun.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Li4', '5557234573', TRUE, 'Erkek', '2001-09-19', 'https://i.pravatar.cc/150?img=41', 'Kimya mühendisliği son sınıf.', 'Fark Etmez', TRUE, 'Metal', 87.00, 'https://docs.uniring.com/ogrenci_59.pdf', TRUE, 'U12345682', TRUE, 'Aktif'),
(7, 'Selin', 'Koç', 'selin.koc@boun.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Li5', '5557234574', TRUE, 'Kadın', '2002-03-31', 'https://i.pravatar.cc/150?img=47', 'Sosyoloji bölümü öğrencisiyim.', 'Fark Etmez', FALSE, 'İndie', 92.00, 'https://docs.uniring.com/ogrenci_60.pdf', TRUE, NULL, FALSE, 'Aktif'),
(7, 'Mert', 'Aksoy', 'mert.aksoy@boun.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Li6', '5557234575', TRUE, 'Erkek', '2003-08-14', 'https://i.pravatar.cc/150?img=42', 'Fizik bölümü 1. sınıf.', 'Fark Etmez', FALSE, 'Jazz', 89.50, 'https://docs.uniring.com/ogrenci_61.pdf', TRUE, 'U23456793', TRUE, 'Aktif'),
(7, 'Nazlı', 'Keskin', 'nazli.keskin@boun.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Li7', '5557234576', TRUE, 'Kadın', '2001-11-27', 'https://i.pravatar.cc/150?img=48', 'Matematik bölümü son sınıf.', 'Fark Etmez', FALSE, 'Klasik', 94.00, 'https://docs.uniring.com/ogrenci_62.pdf', TRUE, NULL, FALSE, 'Aktif'),
(7, 'Cem', 'Demir', 'cem.demir@boun.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Li8', '5557234577', TRUE, 'Erkek', '2002-06-10', 'https://i.pravatar.cc/150?img=43', 'Endüstri mühendisliği.', 'Fark Etmez', FALSE, 'Rock', 90.50, 'https://docs.uniring.com/ogrenci_63.pdf', TRUE, 'U34567894', TRUE, 'Aktif'),
(7, 'Ada', 'Yücel', 'ada.yucel@boun.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Li9', '5557234578', TRUE, 'Kadın', '2003-01-23', 'https://i.pravatar.cc/150?img=49', 'Psikoloji bölümü 2. sınıf.', 'Fark Etmez', FALSE, 'Pop, R&B', 93.50, 'https://docs.uniring.com/ogrenci_64.pdf', TRUE, NULL, FALSE, 'Aktif'),

-- İTÜ Kullanıcıları (10 kişi)
(8, 'Okan', 'Balcı', 'okan.balci@itu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lj0', '5558234567', TRUE, 'Erkek', '2001-04-16', 'https://i.pravatar.cc/150?img=44', 'İnşaat mühendisliği master.', 'Fark Etmez', FALSE, 'Rock', 96.00, 'https://docs.uniring.com/ogrenci_65.pdf', TRUE, 'U45678905', TRUE, 'Aktif'),
(8, 'Aylin', 'Yıldırım', 'aylin.yildirim@itu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lj1', '5558234568', TRUE, 'Kadın', '2002-09-08', 'https://i.pravatar.cc/150?img=50', 'Mimarlık fakültesi son sınıf.', 'Fark Etmez', FALSE, 'Pop', 94.00, 'https://docs.uniring.com/ogrenci_66.pdf', TRUE, NULL, FALSE, 'Aktif'),
(8, 'Deniz', 'Arslan', 'deniz.arslan@itu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lj2', '5558234569', TRUE, 'Erkek', '2003-01-29', 'https://i.pravatar.cc/150?img=45', 'Elektrik-Elektronik mühendisliği.', 'Fark Etmez', FALSE, 'Elektronik', 92.50, 'https://docs.uniring.com/ogrenci_67.pdf', TRUE, 'U56789016', TRUE, 'Aktif'),
(8, 'Esra', 'Bulut', 'esra.bulut@itu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lj3', '5558234570', TRUE, 'Kadın', '2001-06-22', 'https://i.pravatar.cc/150?img=51', 'Gemi inşaatı ve deniz bilimleri.', 'Fark Etmez', FALSE, 'Jazz', 91.00, 'https://docs.uniring.com/ogrenci_68.pdf', TRUE, NULL, FALSE, 'Aktif'),
(8, 'Volkan', 'Öztürk', 'volkan.ozturk@itu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lj4', '5558234571', TRUE, 'Erkek', '2002-11-14', 'https://i.pravatar.cc/150?img=46', 'Makine mühendisliği.', 'Fark Etmez', TRUE, 'Metal', 88.00, 'https://docs.uniring.com/ogrenci_69.pdf', TRUE, 'U67890127', TRUE, 'Aktif'),
(8, 'Tuğçe', 'Şahin', 'tugce.sahin@itu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lj5', '5558234572', TRUE, 'Kadın', '2003-04-05', 'https://i.pravatar.cc/150?img=52', 'Kimya mühendisliği 2. sınıf.', 'Sadece Kadın', FALSE, 'Pop', 93.00, 'https://docs.uniring.com/ogrenci_70.pdf', TRUE, NULL, FALSE, 'Aktif'),
(8, 'Batuhan', 'Koç', 'batuhan.koc@itu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lj6', '5558234573', TRUE, 'Erkek', '2001-08-27', 'https://i.pravatar.cc/150?img=47', 'Havacılık ve uzay mühendisliği.', 'Fark Etmez', FALSE, 'Rock', 95.50, 'https://docs.uniring.com/ogrenci_71.pdf', TRUE, 'U78901238', TRUE, 'Aktif'),
(8, 'Simge', 'Acar', 'simge.acar@itu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lj7', '5558234574', TRUE, 'Kadın', '2002-02-18', 'https://i.pravatar.cc/150?img=53', 'Jeoloji mühendisliği.', 'Fark Etmez', FALSE, 'İndie', 90.00, 'https://docs.uniring.com/ogrenci_72.pdf', TRUE, NULL, FALSE, 'Aktif'),
(8, 'Emre', 'Polat', 'emre.polat@itu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lj8', '5558234575', TRUE, 'Erkek', '2003-07-11', 'https://i.pravatar.cc/150?img=48', 'Endüstri ürünleri tasarımı.', 'Fark Etmez', FALSE, 'Elektronik', 89.50, 'https://docs.uniring.com/ogrenci_73.pdf', TRUE, 'U89012349', TRUE, 'Aktif'),
(8, 'Özge', 'Yaman', 'ozge.yaman@itu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lj9', '5558234576', TRUE, 'Kadın', '2001-12-04', 'https://i.pravatar.cc/150?img=54', 'Tekstil mühendisliği son sınıf.', 'Fark Etmez', FALSE, 'Pop', 92.00, 'https://docs.uniring.com/ogrenci_74.pdf', TRUE, NULL, FALSE, 'Aktif'),

-- Koç Üniversitesi (8 kişi)
(9, 'Bora', 'Eren', 'bora.eren@ku.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lk0', '5559234567', TRUE, 'Erkek', '2002-03-19', 'https://i.pravatar.cc/150?img=49', 'Bilgisayar mühendisliği 3. sınıf.', 'Fark Etmez', FALSE, 'Jazz', 97.00, 'https://docs.uniring.com/ogrenci_75.pdf', TRUE, 'U90123460', TRUE, 'Aktif'),
(9, 'Nil', 'Çetin', 'nil.cetin@ku.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lk1', '5559234568', TRUE, 'Kadın', '2001-08-31', 'https://i.pravatar.cc/150?img=55', 'İşletme fakültesi son sınıf.', 'Fark Etmez', FALSE, 'Pop', 95.00, 'https://docs.uniring.com/ogrenci_76.pdf', TRUE, 'U01234571', TRUE, 'Aktif'),
(9, 'Umut', 'Yalçın', 'umut.yalcin@ku.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lk2', '5559234569', TRUE, 'Erkek', '2003-01-14', 'https://i.pravatar.cc/150?img=50', 'Ekonomi bölümü 2. sınıf.', 'Fark Etmez', FALSE, 'Elektronik', 93.50, 'https://docs.uniring.com/ogrenci_77.pdf', TRUE, NULL, FALSE, 'Aktif'),
(9, 'İdil', 'Güneş', 'idil.gunes@ku.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lk3', '5559234570', TRUE, 'Kadın', '2002-06-26', 'https://i.pravatar.cc/150?img=56', 'Hukuk fakültesi öğrencisiyim.', 'Fark Etmez', FALSE, 'Klasik', 94.00, 'https://docs.uniring.com/ogrenci_78.pdf', TRUE, NULL, FALSE, 'Aktif'),
(9, 'Barış', 'Özdemir', 'baris.ozdemir@ku.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lk4', '5559234571', TRUE, 'Erkek', '2001-11-09', 'https://i.pravatar.cc/150?img=51', 'Elektrik-Elektronik mühendisliği.', 'Fark Etmez', FALSE, 'Rock', 91.50, 'https://docs.uniring.com/ogrenci_79.pdf', TRUE, 'U12345683', TRUE, 'Aktif'),
(9, 'Ceyda', 'Aksoy', 'ceyda.aksoy@ku.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lk5', '5559234572', TRUE, 'Kadın', '2003-04-21', 'https://i.pravatar.cc/150?img=57', 'Uluslararası ilişkiler 1. sınıf.', 'Sadece Kadın', FALSE, 'Pop', 92.50, 'https://docs.uniring.com/ogrenci_80.pdf', TRUE, NULL, FALSE, 'Aktif'),
(9, 'Koray', 'Şimşek', 'koray.simsek@ku.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lk6', '5559234573', TRUE, 'Erkek', '2002-09-03', 'https://i.pravatar.cc/150?img=52', 'Endüstri mühendisliği.', 'Fark Etmez', FALSE, 'Jazz', 90.00, 'https://docs.uniring.com/ogrenci_81.pdf', TRUE, 'U23456794', TRUE, 'Aktif'),
(9, 'Aslı', 'Kara', 'asli.kara@ku.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lk7', '5559234574', TRUE, 'Kadın', '2001-12-17', 'https://i.pravatar.cc/150?img=58', 'Psikoloji bölümü son sınıf.', 'Fark Etmez', FALSE, 'İndie', 93.00, 'https://docs.uniring.com/ogrenci_82.pdf', TRUE, NULL, FALSE, 'Aktif'),

-- Ege Üniversitesi (8 kişi)
(13, 'Çağrı', 'Aydın', 'cagri.aydin@ege.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lk8', '5560234567', TRUE, 'Erkek', '2002-05-07', 'https://i.pravatar.cc/150?img=53', 'Tıp fakültesi 3. sınıf.', 'Fark Etmez', FALSE, 'Klasik', 96.50, 'https://docs.uniring.com/ogrenci_83.pdf', TRUE, 'U34567895', TRUE, 'Aktif'),
(13, 'Sevgi', 'Kaplan', 'sevgi.kaplan@ege.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lk9', '5560234568', TRUE, 'Kadın', '2001-10-20', 'https://i.pravatar.cc/150?img=59', 'Hemşirelik fakültesi son sınıf.', 'Fark Etmez', FALSE, 'Pop', 94.00, 'https://docs.uniring.com/ogrenci_84.pdf', TRUE, NULL, FALSE, 'Aktif'),
(13, 'Tuna', 'Yılmaz', 'tuna.yilmaz@ege.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Ll0', '5560234569', TRUE, 'Erkek', '2003-02-11', 'https://i.pravatar.cc/150?img=54', 'Diş hekimliği 2. sınıf.', 'Fark Etmez', FALSE, 'Rock', 91.00, 'https://docs.uniring.com/ogrenci_85.pdf', TRUE, 'U45678906', TRUE, 'Aktif'),
(13, 'Deren', 'Koç', 'deren.koc@ege.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Ll1', '5560234570', TRUE, 'Kadın', '2002-07-24', 'https://i.pravatar.cc/150?img=60', 'Eczacılık fakültesi öğrencisiyim.', 'Fark Etmez', FALSE, 'Jazz', 95.50, 'https://docs.uniring.com/ogrenci_86.pdf', TRUE, NULL, FALSE, 'Aktif'),
(13, 'İlker', 'Demir', 'ilker.demir@ege.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Ll2', '5560234571', TRUE, 'Erkek', '2001-12-06', 'https://i.pravatar.cc/150?img=55', 'Bilgisayar mühendisliği.', 'Fark Etmez', FALSE, 'Elektronik', 89.50, 'https://docs.uniring.com/ogrenci_87.pdf', TRUE, 'U56789017', TRUE, 'Aktif'),
(13, 'Begüm', 'Öztürk', 'begum.ozturk@ege.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Ll3', '5560234572', TRUE, 'Kadın', '2003-05-18', 'https://i.pravatar.cc/150?img=61', 'Ziraat fakültesi 1. sınıf.', 'Fark Etmez', FALSE, 'Pop', 92.00, 'https://docs.uniring.com/ogrenci_88.pdf', TRUE, NULL, FALSE, 'Aktif'),
(13, 'Selim', 'Polat', 'selim.polat@ege.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Ll4', '5560234573', TRUE, 'Erkek', '2002-09-30', 'https://i.pravatar.cc/150?img=56', 'Kimya bölümü öğrencisiyim.', 'Fark Etmez', TRUE, 'Metal', 87.50, 'https://docs.uniring.com/ogrenci_89.pdf', TRUE, 'U67890128', TRUE, 'Aktif'),
(13, 'Zehra', 'Şahin', 'zehra.sahin@ege.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Ll5', '5560234574', TRUE, 'Kadın', '2001-11-13', 'https://i.pravatar.cc/150?img=62', 'Gıda mühendisliği son sınıf.', 'Fark Etmez', FALSE, 'İndie', 90.50, 'https://docs.uniring.com/ogrenci_90.pdf', TRUE, NULL, FALSE, 'Aktif'),

-- Diğer üniversitelerden karışık kullanıcılar (30 kişi daha)
(5, 'Canberk', 'Yurt', 'canberk.yurt@ankara.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Ll6', '5561234567', TRUE, 'Erkek', '2002-01-25', 'https://i.pravatar.cc/150?img=57', 'Hukuk fakültesi 3. sınıf.', 'Fark Etmez', FALSE, 'Pop', 91.00, 'https://docs.uniring.com/ogrenci_91.pdf', TRUE, 'U78901239', TRUE, 'Aktif'),
(6, 'Melisa', 'Kılıç', 'melisa.kilic@gazi.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Ll7', '5561234568', TRUE, 'Kadın', '2003-06-12', 'https://i.pravatar.cc/150?img=63', 'Eğitim fakültesi 1. sınıf.', 'Fark Etmez', FALSE, 'Jazz', 88.50, 'https://docs.uniring.com/ogrenci_92.pdf', TRUE, NULL, FALSE, 'Aktif'),
(10, 'Buğra', 'Arslan', 'bugra.arslan@sabanciuniv.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Ll8', '5561234569', TRUE, 'Erkek', '2001-09-03', 'https://i.pravatar.cc/150?img=58', 'Endüstri mühendisliği master.', 'Fark Etmez', FALSE, 'Rock', 97.50, 'https://docs.uniring.com/ogrenci_93.pdf', TRUE, 'U89012350', TRUE, 'Aktif'),
(11, 'Özlem', 'Güven', 'ozlem.guven@marmara.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Ll9', '5561234570', TRUE, 'Kadın', '2002-04-16', 'https://i.pravatar.cc/150?img=64', 'İletişim fakültesi son sınıf.', 'Sadece Kadın', FALSE, 'Pop', 93.00, 'https://docs.uniring.com/ogrenci_94.pdf', TRUE, NULL, FALSE, 'Aktif'),
(12, 'Serdar', 'Çelik', 'serdar.celik@yildiz.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lm0', '5561234571', TRUE, 'Erkek', '2003-07-28', 'https://i.pravatar.cc/150?img=59', 'Makine mühendisliği 2. sınıf.', 'Fark Etmez', FALSE, 'Elektronik', 90.00, 'https://docs.uniring.com/ogrenci_95.pdf', TRUE, 'U90123461', TRUE, 'Aktif'),
(14, 'Cansu', 'Özer', 'cansu.ozer@deu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lm1', '5561234572', TRUE, 'Kadın', '2001-12-10', 'https://i.pravatar.cc/150?img=65', 'Tıp fakültesi son sınıf.', 'Fark Etmez', FALSE, 'Klasik', 96.00, 'https://docs.uniring.com/ogrenci_96.pdf', TRUE, NULL, FALSE, 'Aktif'),
(15, 'Eray', 'Toprak', 'eray.toprak@ieu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lm2', '5561234573', TRUE, 'Erkek', '2002-08-22', 'https://i.pravatar.cc/150?img=60', 'İşletme fakültesi 3. sınıf.', 'Fark Etmez', FALSE, 'Hip-Hop', 89.00, 'https://docs.uniring.com/ogrenci_97.pdf', TRUE, 'U01234572', TRUE, 'Aktif'),
(16, 'Gülcan', 'Aydın', 'gulcan.aydin@anadolu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lm3', '5561234574', TRUE, 'Kadın', '2003-03-05', 'https://i.pravatar.cc/150?img=66', 'İletişim bilimleri 2. sınıf.', 'Fark Etmez', FALSE, 'Pop', 91.50, 'https://docs.uniring.com/ogrenci_98.pdf', TRUE, NULL, FALSE, 'Aktif'),
(17, 'Hüseyin', 'Kaya', 'huseyin.kaya@ogu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lm4', '5561234575', TRUE, 'Erkek', '2001-11-17', 'https://i.pravatar.cc/150?img=61', 'Bilgisayar mühendisliği.', 'Fark Etmez', TRUE, 'Rock', 86.00, 'https://docs.uniring.com/ogrenci_99.pdf', TRUE, 'U12345684', TRUE, 'Aktif'),
(18, 'Şeyda', 'Demir', 'seyda.demir@akdeniz.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lm5', '5561234576', TRUE, 'Kadın', '2002-06-29', 'https://i.pravatar.cc/150?img=67', 'Turizm fakültesi son sınıf.', 'Fark Etmez', FALSE, 'Pop, R&B', 92.50, 'https://docs.uniring.com/ogrenci_100.pdf', TRUE, NULL, FALSE, 'Aktif'),
(19, 'Tamer', 'Çetin', 'tamer.cetin@kocaeli.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lm6', '5561234577', TRUE, 'Erkek', '2003-01-11', 'https://i.pravatar.cc/150?img=62', 'Endüstri mühendisliği 2. sınıf.', 'Fark Etmez', FALSE, 'Jazz', 88.00, 'https://docs.uniring.com/ogrenci_101.pdf', TRUE, 'U23456795', TRUE, 'Aktif'),
(20, 'Yağmur', 'Koç', 'yagmur.koc@gantep.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lm7', '5561234578', TRUE, 'Kadın', '2001-09-23', 'https://i.pravatar.cc/150?img=68', 'Tıp fakültesi 5. sınıf.', 'Fark Etmez', FALSE, 'Klasik', 95.00, 'https://docs.uniring.com/ogrenci_102.pdf', TRUE, NULL, FALSE, 'Aktif'),
(21, 'Ramazan', 'Özkan', 'ramazan.ozkan@omu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lm8', '5561234579', TRUE, 'Erkek', '2002-05-06', 'https://i.pravatar.cc/150?img=63', 'Ziraat fakültesi 3. sınıf.', 'Fark Etmez', FALSE, 'Pop', 87.50, 'https://docs.uniring.com/ogrenci_103.pdf', TRUE, 'U34567896', TRUE, 'Aktif'),
(22, 'Nihan', 'Arslan', 'nihan.arslan@ktu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lm9', '5561234580', TRUE, 'Kadın', '2003-08-18', 'https://i.pravatar.cc/150?img=69', 'İnşaat mühendisliği 1. sınıf.', 'Fark Etmez', FALSE, 'İndie', 90.50, 'https://docs.uniring.com/ogrenci_104.pdf', TRUE, NULL, FALSE, 'Aktif'),
(23, 'Recep', 'Yılmaz', 'recep.yilmaz@selcuk.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Ln0', '5561234581', TRUE, 'Erkek', '2001-12-30', 'https://i.pravatar.cc/150?img=64', 'Veterinerlik fakültesi son sınıf.', 'Fark Etmez', FALSE, 'Rock', 91.00, 'https://docs.uniring.com/ogrenci_105.pdf', TRUE, 'U45678907', TRUE, 'Aktif'),
(24, 'Hilal', 'Polat', 'hilal.polat@cu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Ln1', '5561234582', TRUE, 'Kadın', '2002-04-13', 'https://i.pravatar.cc/150?img=70', 'Hemşirelik fakültesi öğrencisiyim.', 'Sadece Kadın', FALSE, 'Pop', 93.50, 'https://docs.uniring.com/ogrenci_106.pdf', TRUE, NULL, FALSE, 'Aktif'),
(25, 'Fatih', 'Güler', 'fatih.guler@uludag.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Ln2', '5561234583', TRUE, 'Erkek', '2003-07-25', 'https://i.pravatar.cc/150?img=65', 'Makine mühendisliği 2. sınıf.', 'Fark Etmez', FALSE, 'Elektronik', 89.00, 'https://docs.uniring.com/ogrenci_107.pdf', TRUE, 'U56789018', TRUE, 'Aktif'),
(5, 'Melike', 'Şen', 'melike.sen@ankara.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Ln3', '5561234584', TRUE, 'Kadın', '2001-11-08', 'https://i.pravatar.cc/150?img=71', 'Eczacılık fakültesi son sınıf.', 'Fark Etmez', FALSE, 'Jazz', 94.00, 'https://docs.uniring.com/ogrenci_108.pdf', TRUE, NULL, FALSE, 'Aktif'),
(6, 'İsmail', 'Koç', 'ismail.koc@gazi.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Ln4', '5561234585', TRUE, 'Erkek', '2002-09-20', 'https://i.pravatar.cc/150?img=66', 'İletişim fakültesi 3. sınıf.', 'Fark Etmez', TRUE, 'Metal', 84.50, 'https://docs.uniring.com/ogrenci_109.pdf', TRUE, 'U67890129', TRUE, 'Aktif'),
(10, 'Sinem', 'Acar', 'sinem.acar@sabanciuniv.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Ln5', '5561234586', TRUE, 'Kadın', '2003-02-02', 'https://i.pravatar.cc/150?img=72', 'Bilgisayar bilimi ve mühendislik.', 'Fark Etmez', FALSE, 'Pop', 96.50, 'https://docs.uniring.com/ogrenci_110.pdf', TRUE, NULL, FALSE, 'Aktif'),
(11, 'Burak', 'Tekin', 'burak.tekin@marmara.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Ln6', '5561234587', TRUE, 'Erkek', '2001-06-14', 'https://i.pravatar.cc/150?img=67', 'İşletme fakültesi son sınıf.', 'Fark Etmez', FALSE, 'Rock', 91.50, 'https://docs.uniring.com/ogrenci_111.pdf', TRUE, 'U78901240', TRUE, 'Aktif'),
(12, 'Derya', 'Özcan', 'derya.ozcan@yildiz.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Ln7', '5561234588', TRUE, 'Kadın', '2002-11-26', 'https://i.pravatar.cc/150?img=73', 'Kimya mühendisliği öğrencisiyim.', 'Fark Etmez', FALSE, 'İndie', 88.50, 'https://docs.uniring.com/ogrenci_112.pdf', TRUE, NULL, FALSE, 'Aktif'),
(14, 'Onur', 'Yurt', 'onur.yurt@deu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Ln8', '5561234589', TRUE, 'Erkek', '2003-04-09', 'https://i.pravatar.cc/150?img=68', 'Elektrik-Elektronik mühendisliği.', 'Fark Etmez', FALSE, 'Elektronik', 92.00, 'https://docs.uniring.com/ogrenci_113.pdf', TRUE, 'U89012351', TRUE, 'Aktif'),
(15, 'Berna', 'Akın', 'berna.akin@ieu.edu.tr', TRUE, '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Ln9', '5561234590', TRUE, 'Kadın', '2001-08-21', 'https://i.pravatar.cc/150?img=74', 'Uluslararası ticaret son sınıf.', 'Fark Etmez', FALSE, 'Jazz', 94.50, 'https://docs.uniring.com/ogrenci_114.pdf', TRUE, NULL, FALSE, 'Aktif'),
(16, 'Hasan', 'Çakır', 'hasan.cakir@anadolu.edu.tr', TRUE, '2b$12LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lo0', '5561234591', TRUE, 'Erkek', '2002-02-03', 'https://i.pravatar.cc/150?img=69', 'Bilgisayar öğretmenliği 3. sınıf.', 'Fark Etmez', FALSE, 'Pop', 87.00, 'https://docs.uniring.com/ogrenci_115.pdf', TRUE, 'U90123462', TRUE, 'Aktif'),
(17, 'Elif', 'Kaya', 'elif.kaya2@ogu.edu.tr', TRUE, '2b$12LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lo1', '5561234592', TRUE, 'Kadın', '2003-05-15', 'https://i.pravatar.cc/150?img=75', 'Mimarlık 2. sınıf öğrencisiyim.', 'Fark Etmez', FALSE, 'Klasik', 90.00, 'https://docs.uniring.com/ogrenci_116.pdf', TRUE, NULL, FALSE, 'Aktif'),
(18, 'Mete', 'Aydın', 'mete.aydin@akdeniz.edu.tr', TRUE, '2b$12LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lo2', '5561234593', TRUE, 'Erkek', '2001-10-27', 'https://i.pravatar.cc/150?img=70', 'İktisat bölümü son sınıf.', 'Fark Etmez', TRUE, 'Hip-Hop', 85.50, 'https://docs.uniring.com/ogrenci_117.pdf', TRUE, 'U01234573', TRUE, 'Aktif'),
(19, 'Damla', 'Özkan', 'damla.ozkan@kocaeli.edu.tr', TRUE, '2b$12LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lo3', '5561234594', TRUE, 'Kadın', '2002-07-10', 'https://i.pravatar.cc/150?img=76', 'Moleküler biyoloji ve genetik.', 'Fark Etmez', FALSE, 'Pop, R&B', 91.50, 'https://docs.uniring.com/ogrenci_118.pdf', TRUE, NULL, FALSE, 'Aktif'),
(20, 'Samet', 'Güler', 'samet.guler@gantep.edu.tr', TRUE, '2b$12LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lo4', '5561234595', TRUE, 'Erkek', '2003-09-22', 'https://i.pravatar.cc/150?img=71', 'Makine mühendisliği 1. sınıf.', 'Fark Etmez', FALSE, 'Rock', 86.50, 'https://docs.uniring.com/ogrenci_119.pdf', TRUE, 'U12345685', TRUE, 'Aktif'),
(21, 'Ecem', 'Demir', 'ecem.demir@omu.edu.tr', TRUE, '2b$12LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/Lo5', '5561234596', TRUE, 'Kadın', '2001-12-04', 'https://i.pravatar.cc/150?img=77', 'Hemşirelik son sınıf öğrencisiyim.', 'Sadece Kadın', FALSE, 'Pop', 93.00, 'https://docs.uniring.com/ogrenci_120.pdf', TRUE, NULL, FALSE, 'Aktif');

-- ============================================
-- UNIRING - TEST VERİSİ: CUZDANLAR
-- ADIM 3/10 - Her kullanıcı için cüzdan
-- ============================================

-- Her kullanıcı için otomatik cüzdan oluştur
-- Bakiyeler 0 ile 1000 TL arasında rastgele
INSERT INTO Cuzdanlar (kullaniciID, bakiye, sonGuncelleme) VALUES
-- TOBB ETÜ (kullaniciID 1-15)
(1, 450.00, '2025-11-28 14:30:00'),
(2, 780.50, '2025-11-29 09:15:00'),
(3, 120.00, '2025-11-25 16:45:00'),
(4, 340.75, '2025-11-27 11:20:00'),
(5, 890.00, '2025-11-30 08:00:00'),
(6, 0.00, '2025-11-15 10:30:00'),
(7, 620.30, '2025-11-26 13:40:00'),
(8, 250.00, '2025-11-29 17:25:00'),
(9, 510.80, '2025-11-28 12:10:00'),
(10, 95.50, '2025-11-24 15:00:00'),
(11, 735.00, '2025-11-30 10:45:00'),
(12, 420.25, '2025-11-27 14:20:00'),
(13, 860.00, '2025-11-29 09:30:00'),
(14, 180.00, '2025-11-26 16:15:00'),
(15, 305.50, '2025-11-28 11:50:00'),

-- ODTÜ (kullaniciID 16-30)
(16, 920.00, '2025-11-30 08:20:00'),
(17, 650.75, '2025-11-29 14:10:00'),
(18, 280.00, '2025-11-27 10:35:00'),
(19, 540.30, '2025-11-28 15:45:00'),
(20, 410.00, '2025-11-26 12:20:00'),
(21, 195.50, '2025-11-25 09:40:00'),
(22, 770.00, '2025-11-30 11:15:00'),
(23, 330.25, '2025-11-29 16:30:00'),
(24, 580.80, '2025-11-28 13:50:00'),
(25, 460.00, '2025-11-27 10:10:00'),
(26, 890.50, '2025-11-30 09:00:00'),
(27, 215.00, '2025-11-26 14:45:00'),
(28, 640.75, '2025-11-29 11:20:00'),
(29, 370.00, '2025-11-28 16:05:00'),
(30, 520.30, '2025-11-27 12:40:00'),

-- Bilkent (kullaniciID 31-42)
(31, 980.00, '2025-11-30 08:45:00'),
(32, 720.50, '2025-11-29 13:20:00'),
(33, 390.00, '2025-11-28 10:50:00'),
(34, 610.75, '2025-11-27 15:30:00'),
(35, 450.00, '2025-11-26 11:45:00'),
(36, 840.25, '2025-11-30 09:25:00'),
(37, 270.00, '2025-11-29 14:40:00'),
(38, 560.80, '2025-11-28 12:15:00'),
(39, 190.00, '2025-11-27 09:35:00'),
(40, 680.50, '2025-11-30 10:20:00'),
(41, 410.00, '2025-11-29 15:55:00'),
(42, 530.75, '2025-11-28 13:10:00'),

-- Hacettepe (kullaniciID 43-52)
(43, 870.00, '2025-11-30 08:30:00'),
(44, 620.50, '2025-11-29 12:45:00'),
(45, 340.00, '2025-11-28 10:15:00'),
(46, 790.75, '2025-11-27 14:50:00'),
(47, 480.00, '2025-11-26 11:20:00'),
(48, 250.30, '2025-11-30 09:40:00'),
(49, 710.00, '2025-11-29 15:10:00'),
(50, 390.25, '2025-11-28 12:35:00'),
(51, 580.00, '2025-11-27 10:05:00'),
(52, 460.80, '2025-11-30 10:50:00'),

-- Boğaziçi (kullaniciID 53-64)
(53, 950.00, '2025-11-30 08:15:00'),
(54, 810.50, '2025-11-29 13:30:00'),
(55, 420.00, '2025-11-28 10:45:00'),
(56, 670.75, '2025-11-27 15:15:00'),
(57, 530.00, '2025-11-26 12:00:00'),
(58, 290.30, '2025-11-30 09:35:00'),
(59, 740.00, '2025-11-29 14:50:00'),
(60, 480.25, '2025-11-28 11:25:00'),
(61, 620.00, '2025-11-27 09:50:00'),
(62, 380.80, '2025-11-30 10:30:00'),
(63, 560.00, '2025-11-29 15:40:00'),
(64, 710.50, '2025-11-28 13:05:00'),

-- İTÜ (kullaniciID 65-74)
(65, 880.00, '2025-11-30 08:25:00'),
(66, 640.50, '2025-11-29 13:15:00'),
(67, 370.00, '2025-11-28 10:40:00'),
(68, 590.75, '2025-11-27 14:55:00'),
(69, 450.00, '2025-11-26 11:30:00'),
(70, 820.30, '2025-11-30 09:20:00'),
(71, 310.00, '2025-11-29 14:35:00'),
(72, 550.25, '2025-11-28 12:00:00'),
(73, 690.00, '2025-11-27 10:25:00'),
(74, 430.80, '2025-11-30 10:55:00'),

-- Koç (kullaniciID 75-82)
(75, 970.00, '2025-11-30 08:10:00'),
(76, 750.50, '2025-11-29 13:25:00'),
(77, 410.00, '2025-11-28 10:55:00'),
(78, 630.75, '2025-11-27 15:20:00'),
(79, 490.00, '2025-11-26 11:50:00'),
(80, 270.30, '2025-11-30 09:30:00'),
(81, 780.00, '2025-11-29 14:45:00'),
(82, 520.25, '2025-11-28 12:20:00'),

-- Ege (kullaniciID 83-90)
(83, 860.00, '2025-11-30 08:35:00'),
(84, 610.50, '2025-11-29 13:10:00'),
(85, 350.00, '2025-11-28 10:30:00'),
(86, 720.75, '2025-11-27 15:00:00'),
(87, 470.00, '2025-11-26 11:25:00'),
(88, 240.30, '2025-11-30 09:45:00'),
(89, 680.00, '2025-11-29 15:05:00'),
(90, 400.25, '2025-11-28 12:30:00'),

-- Diğer üniversiteler (kullaniciID 91-120)
(91, 550.00, '2025-11-29 10:15:00'),
(92, 180.50, '2025-11-28 14:20:00'),
(93, 920.00, '2025-11-30 08:50:00'),
(94, 430.75, '2025-11-29 12:35:00'),
(95, 670.00, '2025-11-28 09:40:00'),
(96, 810.30, '2025-11-30 10:05:00'),
(97, 320.00, '2025-11-29 15:20:00'),
(98, 590.25, '2025-11-28 11:45:00'),
(99, 260.00, '2025-11-27 13:50:00'),
(100, 740.80, '2025-11-30 09:15:00'),
(101, 390.00, '2025-11-29 14:25:00'),
(102, 850.50, '2025-11-28 10:20:00'),
(103, 210.00, '2025-11-27 15:35:00'),
(104, 530.75, '2025-11-30 11:00:00'),
(105, 640.00, '2025-11-29 13:40:00'),
(106, 480.30, '2025-11-28 10:10:00'),
(107, 370.00, '2025-11-27 14:45:00'),
(108, 760.25, '2025-11-30 09:50:00'),
(109, 290.00, '2025-11-29 15:30:00'),
(110, 820.80, '2025-11-28 12:05:00'),
(111, 450.00, '2025-11-27 10:30:00'),
(112, 580.50, '2025-11-30 11:20:00'),
(113, 710.00, '2025-11-29 13:55:00'),
(114, 340.75, '2025-11-28 10:25:00'),
(115, 490.00, '2025-11-27 15:10:00'),
(116, 620.30, '2025-11-30 09:05:00'),
(117, 270.00, '2025-11-29 14:15:00'),
(118, 560.25, '2025-11-28 11:30:00'),
(119, 410.00, '2025-11-27 13:20:00'),
(120, 730.80, '2025-11-30 10:40:00');

-- ============================================
-- UNIRING - TEST VERİSİ: ARACLAR
-- ADIM 4/10 - 40 Araç (Organizatörler için)
-- ============================================

-- Sadece surusBelgesiOnaylandi = TRUE olan kullanıcılara araç ekle
-- Gerçekçi marka, model, plaka, renk kombinasyonları

INSERT INTO Araclar (sahipID, plaka, marka, model, renk, yil, yolcuKapasitesi, sigortaBitisTarihi, ruhsatFotoURL, onayDurumu, eklenmeTarihi) VALUES

-- TOBB ETÜ araçları
(1, '06ABC123', 'Fiat', 'Egea', 'Beyaz', 2020, 4, '2026-03-15', 'https://docs.uniring.com/ruhsat_1.pdf', 'Onaylandı', '2025-09-10 14:30:00'),
(2, '06DEF456', 'Renault', 'Clio', 'Kırmızı', 2019, 3, '2026-05-20', 'https://docs.uniring.com/ruhsat_2.pdf', 'Onaylandı', '2025-08-22 10:15:00'),
(5, '06GHI789', 'Volkswagen', 'Polo', 'Gri', 2021, 4, '2026-07-10', 'https://docs.uniring.com/ruhsat_3.pdf', 'Onaylandı', '2025-10-05 16:45:00'),
(7, '06JKL012', 'Hyundai', 'i20', 'Mavi', 2018, 4, '2026-02-28', 'https://docs.uniring.com/ruhsat_4.pdf', 'Onaylandı', '2025-07-18 11:20:00'),
(9, '06MNO345', 'Ford', 'Fiesta', 'Siyah', 2020, 4, '2026-08-14', 'https://docs.uniring.com/ruhsat_5.pdf', 'Onaylandı', '2025-09-30 09:00:00'),
(11, '06PQR678', 'Toyota', 'Corolla', 'Beyaz', 2022, 4, '2026-11-05', 'https://docs.uniring.com/ruhsat_6.pdf', 'Onaylandı', '2025-11-01 13:40:00'),
(13, '06STU901', 'Honda', 'Civic', 'Gümüş', 2021, 4, '2026-09-22', 'https://docs.uniring.com/ruhsat_7.pdf', 'Onaylandı', '2025-10-12 15:25:00'),
(15, '06VWX234', 'Peugeot', '301', 'Gri', 2019, 4, '2026-04-18', 'https://docs.uniring.com/ruhsat_8.pdf', 'Onaylandı', '2025-08-05 12:10:00'),

-- ODTÜ araçları
(16, '06YZA567', 'BMW', '3 Serisi', 'Siyah', 2021, 4, '2026-10-30', 'https://docs.uniring.com/ruhsat_9.pdf', 'Onaylandı', '2025-10-20 10:45:00'),
(17, '06BCD890', 'Mercedes', 'A180', 'Beyaz', 2022, 4, '2026-12-15', 'https://docs.uniring.com/ruhsat_10.pdf', 'Onaylandı', '2025-11-05 14:20:00'),
(20, '06EFG123', 'Volkswagen', 'Golf', 'Kırmızı', 2020, 4, '2026-06-08', 'https://docs.uniring.com/ruhsat_11.pdf', 'Onaylandı', '2025-09-15 11:50:00'),
(23, '06HIJ456', 'Renault', 'Megane', 'Mavi', 2019, 4, '2026-03-25', 'https://docs.uniring.com/ruhsat_12.pdf', 'Onaylandı', '2025-08-28 16:30:00'),
(25, '06KLM789', 'Fiat', 'Tipo', 'Gri', 2020, 4, '2026-07-19', 'https://docs.uniring.com/ruhsat_13.pdf', 'Onaylandı', '2025-09-22 13:15:00'),
(27, '06NOP012', 'Opel', 'Astra', 'Beyaz', 2018, 4, '2026-02-14', 'https://docs.uniring.com/ruhsat_14.pdf', 'Onaylandı', '2025-07-30 09:40:00'),
(29, '06QRS345', 'Nissan', 'Micra', 'Sarı', 2019, 3, '2026-05-07', 'https://docs.uniring.com/ruhsat_15.pdf', 'Onaylandı', '2025-08-17 15:05:00'),
(30, '06TUV678', 'Seat', 'Ibiza', 'Turuncu', 2021, 4, '2026-09-11', 'https://docs.uniring.com/ruhsat_16.pdf', 'Onaylandı', '2025-10-08 12:35:00'),

-- Bilkent araçları
(31, '06WXY901', 'Audi', 'A3', 'Gri', 2022, 4, '2026-11-20', 'https://docs.uniring.com/ruhsat_17.pdf', 'Onaylandı', '2025-11-10 09:25:00'),
(32, '06ZAB234', 'Volvo', 'S60', 'Siyah', 2021, 4, '2026-10-05', 'https://docs.uniring.com/ruhsat_18.pdf', 'Onaylandı', '2025-10-18 14:40:00'),
(35, '06CDE567', 'Mazda', '3', 'Kırmızı', 2020, 4, '2026-06-28', 'https://docs.uniring.com/ruhsat_19.pdf', 'Onaylandı', '2025-09-08 11:15:00'),
(37, '06FGH890', 'Skoda', 'Octavia', 'Beyaz', 2021, 4, '2026-08-22', 'https://docs.uniring.com/ruhsat_20.pdf', 'Onaylandı', '2025-10-01 16:20:00'),
(39, '06IJK123', 'Citroen', 'C3', 'Mavi', 2019, 3, '2026-04-10', 'https://docs.uniring.com/ruhsat_21.pdf', 'Onaylandı', '2025-08-12 13:50:00'),
(41, '06LMN456', 'Dacia', 'Sandero', 'Gri', 2020, 4, '2026-07-03', 'https://docs.uniring.com/ruhsat_22.pdf', 'Onaylandı', '2025-09-20 10:10:00'),

-- Hacettepe araçları
(43, '06OPQ789', 'Toyota', 'Yaris', 'Beyaz', 2021, 4, '2026-09-18', 'https://docs.uniring.com/ruhsat_23.pdf', 'Onaylandı', '2025-10-10 15:30:00'),
(45, '06RST012', 'Honda', 'Jazz', 'Gümüş', 2020, 4, '2026-05-29', 'https://docs.uniring.com/ruhsat_24.pdf', 'Onaylandı', '2025-09-02 11:45:00'),
(47, '06UVW345', 'Ford', 'Focus', 'Siyah', 2019, 4, '2026-03-12', 'https://docs.uniring.com/ruhsat_25.pdf', 'Onaylandı', '2025-08-08 14:20:00'),
(49, '06XYZ678', 'Hyundai', 'Accent', 'Kırmızı', 2020, 4, '2026-06-15', 'https://docs.uniring.com/ruhsat_26.pdf', 'Onaylandı', '2025-09-18 09:35:00'),
(51, '06ABC901', 'Renault', 'Symbol', 'Gri', 2018, 4, '2026-02-08', 'https://docs.uniring.com/ruhsat_27.pdf', 'Onaylandı', '2025-07-25 16:00:00'),

-- Boğaziçi araçları  
(53, '34DEF234', 'Mercedes', 'C200', 'Siyah', 2022, 4, '2026-12-01', 'https://docs.uniring.com/ruhsat_28.pdf', 'Onaylandı', '2025-11-08 10:50:00'),
(55, '34GHI567', 'BMW', '5 Serisi', 'Beyaz', 2021, 4, '2026-10-12', 'https://docs.uniring.com/ruhsat_29.pdf', 'Onaylandı', '2025-10-22 13:25:00'),
(57, '34JKL890', 'Audi', 'A4', 'Gri', 2020, 4, '2026-07-27', 'https://docs.uniring.com/ruhsat_30.pdf', 'Onaylandı', '2025-09-28 15:40:00'),
(59, '34MNO123', 'Volkswagen', 'Passat', 'Mavi', 2021, 4, '2026-09-05', 'https://docs.uniring.com/ruhsat_31.pdf', 'Onaylandı', '2025-10-14 11:05:00'),
(61, '34PQR456', 'Toyota', 'Camry', 'Gümüş', 2022, 4, '2026-11-18', 'https://docs.uniring.com/ruhsat_32.pdf', 'Onaylandı', '2025-11-02 14:30:00'),
(63, '34STU789', 'Volvo', 'V40', 'Siyah', 2020, 4, '2026-06-22', 'https://docs.uniring.com/ruhsat_33.pdf', 'Onaylandı', '2025-09-12 12:15:00'),

-- İTÜ araçları
(65, '34VWX012', 'Ford', 'Mondeo', 'Beyaz', 2019, 4, '2026-04-05', 'https://docs.uniring.com/ruhsat_34.pdf', 'Onaylandı', '2025-08-20 10:25:00'),
(67, '34YZA345', 'Peugeot', '508', 'Gri', 2020, 4, '2026-07-11', 'https://docs.uniring.com/ruhsat_35.pdf', 'Onaylandı', '2025-09-25 15:50:00'),
(69, '34BCD678', 'Skoda', 'Superb', 'Siyah', 2021, 4, '2026-08-30', 'https://docs.uniring.com/ruhsat_36.pdf', 'Onaylandı', '2025-10-06 13:10:00'),
(71, '34EFG901', 'Mazda', '6', 'Kırmızı', 2020, 4, '2026-05-17', 'https://docs.uniring.com/ruhsat_37.pdf', 'Onaylandı', '2025-09-05 11:35:00'),

-- Koç araçları
(75, '34HIJ234', 'BMW', 'X3', 'Beyaz', 2022, 4, '2026-12-08', 'https://docs.uniring.com/ruhsat_38.pdf', 'Onaylandı', '2025-11-12 09:45:00'),
(77, '34KLM567', 'Audi', 'Q3', 'Gri', 2021, 4, '2026-09-25', 'https://docs.uniring.com/ruhsat_39.pdf', 'Onaylandı', '2025-10-16 14:55:00'),
(79, '34NOP890', 'Mercedes', 'GLA', 'Siyah', 2022, 4, '2026-11-10', 'https://docs.uniring.com/ruhsat_40.pdf', 'Onaylandı', '2025-11-03 12:20:00');

-- ============================================
-- UNIRING - TEST VERİSİ: SEFERLER
-- ADIM 5/10 - 60 Sefer (Tamamlanmış, Aktif, Planlanıyor)
-- ============================================

-- Sefer dağılımı:
-- 25 Tamamlanmış (geçmiş tarihler)
-- 20 Aktif/Planlanıyor (gelecek tarihler)
-- 15 İptal Edilmiş

INSERT INTO Seferler (olusturanKullaniciID, aracID, seferTipi, katilimKapsami, seferTarihi, kalkisZamani, tahminiVarisZamani, maxKapasite, mevcutDoluluk, seferDurumu, bagajAlaniVar, klimaVar, aciklama, fiyatlandirmaTipi, temelFiyat, olusturulmaTarihi, iptalNedeni) VALUES

-- ============================================
-- TAMAMLANMIŞ SEFERLER (25 adet - Geçmiş)
-- ============================================

-- Sefer 1: TOBB -> Kızılay (Tamamlanmış)
(1, 1, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-10-15', '2025-10-15 17:30:00', '2025-10-15 18:15:00', 3, 2, 'Tamamlandı', TRUE, TRUE, 'Okul çıkışı Kızılaya gidiyorum. Bagaj var, klima var.', 'Sabit', 50.00, '2025-10-14 10:00:00', NULL),

-- Sefer 2: ODTÜ -> Tunalı (Tamamlanmış)
(16, 9, 'Araç Paylaşımı', 'Sadece Kendi Üniversitesi', '2025-10-18', '2025-10-18 16:00:00', '2025-10-18 16:45:00', 3, 3, 'Tamamlandı', TRUE, TRUE, 'A1 kapısından alıyorum, Tunalıya kadar.', 'Sabit', 45.00, '2025-10-17 14:30:00', NULL),

-- Sefer 3: Bilkent -> AVM (Tamamlanmış)
(31, 17, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-10-20', '2025-10-20 14:00:00', '2025-10-20 14:40:00', 3, 2, 'Tamamlandı', TRUE, TRUE, 'Ankamall\'a gidiyoruz, alışveriş yapacağım.', 'Sabit', 60.00, '2025-10-19 09:15:00', NULL),

-- Sefer 4: TOBB -> Bahçelievler (Tamamlanmış)
(2, 2, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-10-22', '2025-10-22 18:00:00', '2025-10-22 18:30:00', 3, 1, 'Tamamlandı', FALSE, TRUE, 'Akşam eve dönüş, Bahçelievler yönü.', 'Sabit', 40.00, '2025-10-21 16:20:00', NULL),

-- Sefer 5: Boğaziçi -> Taksim (Tamamlanmış)
(53, 28, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-10-25', '2025-10-25 19:00:00', '2025-10-25 19:35:00', 3, 2, 'Tamamlandı', TRUE, TRUE, 'Bebek kampüsünden Taksime gidiyorum.', 'Sabit', 70.00, '2025-10-24 11:00:00', NULL),

-- Sefer 6: ODTÜ -> Kızılay (Tamamlanmış)
(17, 10, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-10-28', '2025-10-28 17:30:00', '2025-10-28 18:10:00', 3, 3, 'Tamamlandı', TRUE, TRUE, 'Ders çıkışı Kızılaya geçiyorum.', 'Sabit', 55.00, '2025-10-27 13:45:00', NULL),

-- Sefer 7: Hacettepe -> Çankaya (Tamamlanmış)
(43, 23, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-01', '2025-11-01 16:00:00', '2025-11-01 16:35:00', 3, 1, 'Tamamlandı', TRUE, TRUE, 'Hastane çıkışı Çankaya yönü.', 'Sabit', 45.00, '2025-10-31 10:20:00', NULL),

-- Sefer 8: İTÜ -> Maslak (Tamamlanmış)
(65, 34, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-03', '2025-11-03 18:30:00', '2025-11-03 19:00:00', 3, 2, 'Tamamlandı', FALSE, TRUE, 'Ayazağa kampüsünden Maslak AVM.', 'Sabit', 50.00, '2025-11-02 15:10:00', NULL),

-- Sefer 9: TOBB -> Ulus (Tamamlanmış)
(5, 3, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-05', '2025-11-05 15:00:00', '2025-11-05 15:40:00', 4, 2, 'Tamamlandı', TRUE, TRUE, 'Ulus yönüne gidiyorum, 2 kişi alabilirim.', 'Sabit', 40.00, '2025-11-04 12:30:00', NULL),

-- Sefer 10: Koç -> Şişli (Tamamlanmış)
(75, 38, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-07', '2025-11-07 17:00:00', '2025-11-07 17:50:00', 3, 3, 'Tamamlandı', TRUE, TRUE, 'Rumeli Feneri\'nden Şişliye.', 'Sabit', 80.00, '2025-11-06 09:00:00', NULL),

-- Sefer 11: ODTÜ -> Çayyolu (Tamamlanmış)
(20, 11, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-08', '2025-11-08 16:30:00', '2025-11-08 17:10:00', 3, 2, 'Tamamlandı', TRUE, TRUE, 'Çayyoluya gidiyorum, yol üstü alabilirim.', 'Sabit', 50.00, '2025-11-07 14:15:00', NULL),

-- Sefer 12: Bilkent -> Söğütözü (Tamamlanmış)
(32, 18, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-10', '2025-11-10 14:00:00', '2025-11-10 14:30:00', 3, 1, 'Tamamlandı', TRUE, TRUE, 'İş görüşmesi var Söğütözünde.', 'Sabit', 45.00, '2025-11-09 11:00:00', NULL),

-- Sefer 13: Ege -> Konak (Tamamlanmış)
(83, NULL, 'Ortak Araç Kullanımı', 'Tüm Üniversiteler', '2025-11-12', '2025-11-12 18:00:00', '2025-11-12 18:40:00', 4, 3, 'Tamamlandı', FALSE, TRUE, 'Bornova kampüsünden Konağa taksi tutacağız.', 'Sabit', 30.00, '2025-11-11 16:30:00', NULL),

-- Sefer 14: TOBB -> Kavaklıdere (Tamamlanmış)
(7, 4, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-14', '2025-11-14 17:00:00', '2025-11-14 17:35:00', 4, 3, 'Tamamlandı', TRUE, TRUE, 'Akşam yemeğine gidiyorum Kavaklıdere.', 'Sabit', 50.00, '2025-11-13 10:20:00', NULL),

-- Sefer 15: Boğaziçi -> Kadıköy (Tamamlanmış)
(55, 29, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-15', '2025-11-15 16:00:00', '2025-11-15 17:00:00', 3, 2, 'Tamamlandı', TRUE, TRUE, 'Güney kampüsünden Kadıköye geçiyorum.', 'Sabit', 65.00, '2025-11-14 13:40:00', NULL),

-- Sefer 16: ODTÜ -> Bilkent (Tamamlanmış)
(23, 12, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-17', '2025-11-17 15:00:00', '2025-11-17 15:45:00', 3, 2, 'Tamamlandı', TRUE, TRUE, 'Bilkent\'te etkinlik var, beraber gidelim.', 'Sabit', 40.00, '2025-11-16 09:50:00', NULL),

-- Sefer 17: Hacettepe -> Kızılay (Tamamlanmış)
(45, 24, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-18', '2025-11-18 18:30:00', '2025-11-18 19:00:00', 3, 1, 'Tamamlandı', FALSE, TRUE, 'Sıhhiye kampüsünden Kızılaya.', 'Sabit', 35.00, '2025-11-17 15:20:00', NULL),

-- Sefer 18: İTÜ -> Beşiktaş (Tamamlanmış)
(67, 35, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-19', '2025-11-19 17:00:00', '2025-11-19 17:40:00', 3, 2, 'Tamamlandı', TRUE, TRUE, 'Maçlıka kampüsünden Beşiktaşa.', 'Sabit', 55.00, '2025-11-18 12:10:00', NULL),

-- Sefer 19: TOBB -> Tunalı (Tamamlanmış)
(9, 5, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-20', '2025-11-20 16:30:00', '2025-11-20 17:15:00', 4, 3, 'Tamamlandı', TRUE, TRUE, 'Hafta sonu Tunalıda buluşma var.', 'Sabit', 55.00, '2025-11-19 14:00:00', NULL),

-- Sefer 20: Bilkent -> ODTÜ (Tamamlanmış)
(35, 19, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-21', '2025-11-21 14:00:00', '2025-11-21 14:35:00', 3, 2, 'Tamamlandı', TRUE, TRUE, 'ODTÜ\'de seminer var, gidiyoruz.', 'Sabit', 40.00, '2025-11-20 10:30:00', NULL),

-- Sefer 21: Koç -> Bebek (Tamamlanmış)
(77, 39, 'Araç Paylaşımı', 'Sadece Kendi Üniversitesi', '2025-11-22', '2025-11-22 18:00:00', '2025-11-22 18:30:00', 3, 2, 'Tamamlandı', TRUE, TRUE, 'Sariyer kampüsünden Bebek sahile.', 'Sabit', 50.00, '2025-11-21 16:45:00', NULL),

-- Sefer 22: ODTÜ -> Ankamall (Tamamlanmış)
(25, 13, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-23', '2025-11-23 15:00:00', '2025-11-23 15:50:00', 3, 3, 'Tamamlandı', TRUE, TRUE, 'Alışverişe gidiyoruz, beraber gelenler?', 'Sabit', 50.00, '2025-11-22 11:20:00', NULL),

-- Sefer 23: Boğaziçi -> Ortaköy (Tamamlanmış)
(57, 30, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-24', '2025-11-24 19:00:00', '2025-11-24 19:30:00', 3, 2, 'Tamamlandı', FALSE, TRUE, 'Akşam Ortaköyde yemek yiyeceğiz.', 'Sabit', 60.00, '2025-11-23 13:50:00', NULL),

-- Sefer 24: Hacettepe -> Tunalı (Tamamlanmış)
(47, 25, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-25', '2025-11-25 17:30:00', '2025-11-25 18:00:00', 4, 2, 'Tamamlandı', TRUE, TRUE, 'Beytepe\'den Tunalıya gidiyorum.', 'Sabit', 60.00, '2025-11-24 15:10:00', NULL),

-- Sefer 25: İTÜ -> Levent (Tamamlanmış)
(69, 36, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-26', '2025-11-26 16:00:00', '2025-11-26 16:45:00', 3, 1, 'Tamamlandı', TRUE, TRUE, 'Ayazağadan Levente, iş çıkışı.', 'Sabit', 55.00, '2025-11-25 12:30:00', NULL),

-- ============================================
-- AKTİF / PLANLANMIŞ SEFERLER (20 adet - Gelecek)
-- ============================================

-- Sefer 26: TOBB -> Kızılay (Yarın - Aktif)
(11, 6, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-12-02', '2025-12-02 17:00:00', '2025-12-02 17:45:00', 4, 2, 'Aktif', TRUE, TRUE, 'Okul çıkışı Kızılaya gidiyorum, 2 kişi daha alabilirim.', 'Sabit', 50.00, '2025-11-30 10:00:00', NULL),

-- Sefer 27: ODTÜ -> Çayyolu (Yarın - Aktif)
(27, 14, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-12-02', '2025-12-02 16:30:00', '2025-12-02 17:15:00', 3, 1, 'Aktif', TRUE, TRUE, 'Çayyolu Parkora\'ya gidiyorum.', 'Sabit', 55.00, '2025-11-30 14:20:00', NULL),

-- Sefer 28: Bilkent -> Ankamall (Yarın - Planlanıyor)
(37, 20, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-12-02', '2025-12-02 15:00:00', '2025-12-02 15:50:00', 3, 0, 'Planlanıyor', TRUE, TRUE, 'AVM\'ye gidiyoruz, alışveriş yapacağız.', 'Sabit', 60.00, '2025-12-01 09:30:00', NULL),

-- Sefer 29: Boğaziçi -> Taksim (2 gün sonra)
(59, 31, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-12-03', '2025-12-03 18:00:00', '2025-12-03 18:45:00', 3, 1, 'Planlanıyor', TRUE, TRUE, 'Akşam Taksim\'e çıkıyorum.', 'Sabit', 70.00, '2025-12-01 11:15:00', NULL),

-- Sefer 30: TOBB -> Bahçelievler (2 gün sonra)
(13, 7, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-12-03', '2025-12-03 17:30:00', '2025-12-03 18:00:00', 4, 0, 'Planlanıyor', TRUE, TRUE, 'Eve dönüş, Bahçelievler üstü.', 'Sabit', 45.00, '2025-12-01 13:50:00', NULL),

-- Sefer 31: İTÜ -> Maslak (3 gün sonra)
(71, 37, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-12-04', '2025-12-04 16:00:00', '2025-12-04 16:40:00', 3, 0, 'Planlanıyor', TRUE, TRUE, 'Maslak\'ta buluşma var.', 'Sabit', 50.00, '2025-12-01 15:20:00', NULL),

-- Sefer 32: Hacettepe -> Kızılay (3 gün sonra)
(49, 26, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-12-04', '2025-12-04 17:00:00', '2025-12-04 17:30:00', 4, 1, 'Planlanıyor', FALSE, TRUE, 'Sıhhiye\'den Kızılaya.', 'Sabit', 40.00, '2025-12-01 16:45:00', NULL),

-- Sefer 33: ODTÜ -> Tunalı (4 gün sonra)
(29, 15, 'Araç Paylaşımı', 'Sadece Kendi Üniversitesi', '2025-12-05', '2025-12-05 16:00:00', '2025-12-05 16:45:00', 3, 0, 'Planlanıyor', TRUE, TRUE, 'A1\'den Tunalıya, sadece ODTÜ öğrencileri.', 'Sabit', 50.00, '2025-12-01 10:10:00', NULL),

-- Sefer 34: Koç -> Etiler (4 gün sonra)
(79, 40, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-12-05', '2025-12-05 18:00:00', '2025-12-05 18:35:00', 3, 0, 'Planlanıyor', TRUE, TRUE, 'Etiler\'e akşam yemeğine gidiyorum.', 'Sabit', 65.00, '2025-12-01 12:30:00', NULL),

-- Sefer 35: Bilkent -> ODTÜ (5 gün sonra)
(39, 21, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-12-06', '2025-12-06 14:00:00', '2025-12-06 14:35:00', 3, 1, 'Planlanıyor', TRUE, TRUE, 'ODTÜ\'de konferans var.', 'Sabit', 40.00, '2025-12-01 14:00:00', NULL),

-- Sefer 36: TOBB -> Ulus (5 gün sonra)
(15, 8, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-12-06', '2025-12-06 15:30:00', '2025-12-06 16:10:00', 4, 0, 'Planlanıyor', TRUE, TRUE, 'Ulus\'a gidiyorum, müze gezisi.', 'Sabit', 45.00, '2025-12-01 16:20:00', NULL),

-- Sefer 37: Boğaziçi -> Kadıköy (6 gün sonra)
(61, 32, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-12-07', '2025-12-07 16:00:00', '2025-12-07 17:00:00', 3, 0, 'Planlanıyor', TRUE, TRUE, 'Güney kampüsünden Kadıköy\'e geçiyorum.', 'Sabit', 70.00, '2025-12-01 11:40:00', NULL),

-- Sefer 38: ODTÜ -> Bilkent (7 gün sonra)
(30, 16, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-12-08', '2025-12-08 15:00:00', '2025-12-08 15:45:00', 3, 0, 'Planlanıyor', TRUE, TRUE, 'Bilkent\'te etkinlik var.', 'Sabit', 40.00, '2025-12-01 13:15:00', NULL),

-- Sefer 39: İTÜ -> Şişli (7 gün sonra - Ortak Araç)
(65, NULL, 'Ortak Araç Kullanımı', 'Tüm Üniversiteler', '2025-12-08', '2025-12-08 17:00:00', '2025-12-08 17:45:00', 4, 2, 'Planlanıyor', FALSE, TRUE, 'Şişli\'ye taksi tutacağız, 2 kişi daha arıyoruz.', 'Sabit', 35.00, '2025-12-01 15:50:00', NULL),

-- Sefer 40: Hacettepe -> Çankaya (8 gün sonra)
(51, 27, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-12-09', '2025-12-09 16:30:00', '2025-12-09 17:05:00', 4, 0, 'Planlanıyor', TRUE, TRUE, 'Çankaya\'ya gidiyorum.', 'Sabit', 50.00, '2025-12-01 17:30:00', NULL),

-- Sefer 41: TOBB -> Kavaklıdere (9 gün sonra)
(1, 1, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-12-10', '2025-12-10 17:00:00', '2025-12-10 17:35:00', 3, 1, 'Planlanıyor', TRUE, TRUE, 'Kavaklıdere\'de randevu var.', 'Sabit', 55.00, '2025-12-01 09:00:00', NULL),

-- Sefer 42: Bilkent -> Kızılay (10 gün sonra)
(41, 22, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-12-11', '2025-12-11 16:00:00', '2025-12-11 16:40:00', 3, 0, 'Planlanıyor', TRUE, TRUE, 'Kampüsten Kızılaya geçiyorum.', 'Sabit', 50.00, '2025-12-01 10:45:00', NULL),

-- Sefer 43: Boğaziçi -> Ortaköy (10 gün sonra)
(63, 33, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-12-11', '2025-12-11 18:00:00', '2025-12-11 18:30:00', 3, 0, 'Planlanıyor', TRUE, TRUE, 'Ortaköy\'de akşam yemeği.', 'Sabit', 60.00, '2025-12-01 12:20:00', NULL),

-- Sefer 44: ODTÜ -> Ulus (11 gün sonra)
(16, 9, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-12-12', '2025-12-12 14:00:00', '2025-12-12 14:50:00', 3, 0, 'Planlanıyor', TRUE, TRUE, 'Ulus\'ta gezilecek yerler var.', 'Sabit', 50.00, '2025-12-01 14:35:00', NULL),

-- Sefer 45: İTÜ -> Beşiktaş (12 gün sonra)
(67, 35, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-12-13', '2025-12-13 17:00:00', '2025-12-13 17:40:00', 3, 0, 'Planlanıyor', TRUE, TRUE, 'Beşiktaş\'a gidiyorum.', 'Sabit', 55.00, '2025-12-01 16:00:00', NULL),

-- ============================================
-- İPTAL EDİLMİŞ SEFERLER (15 adet)
-- ============================================

-- İptal 1: Hava kötü
(2, 2, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-10-16', '2025-10-16 16:00:00', '2025-10-16 16:45:00', 3, 0, 'İptal Edildi', TRUE, TRUE, 'Akşam Tunalıya gidecektim.', 'Sabit', 50.00, '2025-10-15 10:30:00', 'Hava çok kötü, iptal ediyorum.'),

-- İptal 2: Araç arızalandı
(5, 3, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-10-19', '2025-10-19 17:00:00', '2025-10-19 17:40:00', 4, 1, 'İptal Edildi', TRUE, TRUE, 'Çayyoluya gidiyordum.', 'Sabit', 55.00, '2025-10-18 14:00:00', 'Arabam arızalandı, servise götüreceğim.'),

-- İptal 3: Acil durum
(7, 4, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-10-21', '2025-10-21 15:00:00', '2025-10-21 15:45:00', 4, 0, 'İptal Edildi', TRUE, TRUE, 'Kızılay\'a gidecektim.', 'Sabit', 45.00, '2025-10-20 11:15:00', 'Acil bir durum çıktı, gidemiyorum.'),

-- İptal 4: Plan değişti
(9, 5, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-10-24', '2025-10-24 16:30:00', '2025-10-24 17:15:00', 4, 0, 'İptal Edildi', TRUE, TRUE, 'Bahçelievler yönü.', 'Sabit', 40.00, '2025-10-23 09:40:00', 'Plan değişti, başka gün gideceğim.'),

-- İptal 5: Katılımcı yok
(11, 6, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-10-27', '2025-10-27 17:00:00', '2025-10-27 17:50:00', 4, 0, 'İptal Edildi', TRUE, TRUE, 'Tunalıya gidecektim.', 'Sabit', 50.00, '2025-10-26 13:20:00', 'Kimse rezervasyon yapmadı, iptal ediyorum.'),

-- İptal 6: Hasta oldum
(13, 7, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-10-30', '2025-10-30 16:00:00', '2025-10-30 16:40:00', 4, 2, 'İptal Edildi', TRUE, TRUE, 'Kızılay\'a gidiyordum.', 'Sabit', 45.00, '2025-10-29 10:50:00', 'Hastalandım, gidemiyorum. Özür dilerim.'),

-- İptal 7: Trafik çok yoğun
(15, 8, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-02', '2025-11-02 18:00:00', '2025-11-02 18:45:00', 4, 1, 'İptal Edildi', TRUE, TRUE, 'Çankaya yönü.', 'Sabit', 50.00, '2025-11-01 15:30:00', 'Trafik çok kötü, başka gün gidelim.'),

-- İptal 8: Sınav var
(17, 10, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-04', '2025-11-04 15:00:00', '2025-11-04 15:50:00', 3, 0, 'İptal Edildi', TRUE, TRUE, 'Ankamall\'a gidecektim.', 'Sabit', 60.00, '2025-11-03 12:10:00', 'Yarın sınav olduğunu unuttum, çalışmalıyım.'),

-- İptal 9: Benzin yok
(20, 11, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-06', '2025-11-06 17:30:00', '2025-11-06 18:10:00', 3, 0, 'İptal Edildi', TRUE, TRUE, 'Tunalıya gidiyordum.', 'Sabit', 50.00, '2025-11-05 14:45:00', 'Benzin istasyonları kapalıymış, iptal.'),

-- İptal 10: Araç kullanımda
(23, 12, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-09', '2025-11-09 16:00:00', '2025-11-09 16:45:00', 3, 1, 'İptal Edildi', TRUE, TRUE, 'Bilkent\'e gidecektik.', 'Sabit', 40.00, '2025-11-08 11:30:00', 'Arabamı ailem kullanıyor, gidemiyorum.'),

-- İptal 11: Yağmur
(25, 13, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-11', '2025-11-11 14:00:00', '2025-11-11 14:50:00', 3, 0, 'İptal Edildi', TRUE, TRUE, 'Çayyolu yönü.', 'Sabit', 50.00, '2025-11-10 09:20:00', 'Çok yağmur yağıyor, tehlikeli.'),

-- İptal 12: Toplantı uzadı
(27, 14, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-13', '2025-11-13 17:00:00', '2025-11-13 17:40:00', 3, 0, 'İptal Edildi', TRUE, TRUE, 'Kızılay\'a gidiyordum.', 'Sabit', 45.00, '2025-11-12 15:50:00', 'Toplantı uzadı, vakti yok artık.'),

-- İptal 13: Lastik patladı
(29, 15, 'Araç Paylaşımı', 'Sadece Kendi Üniversitesi', '2025-11-16', '2025-11-16 16:30:00', '2025-11-16 17:15:00', 3, 2, 'İptal Edildi', TRUE, TRUE, 'ODTÜ çıkışı Tunalı.', 'Sabit', 50.00, '2025-11-15 12:40:00', 'Lastiğim patlamış, tamir ettireceğim.'),

-- İptal 14: Kampüs kapalı
(30, 16, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-27', '2025-11-27 15:00:00', '2025-11-27 15:45:00', 3, 0, 'İptal Edildi', TRUE, TRUE, 'Bilkent\'e gidecektim.', 'Sabit', 40.00, '2025-11-26 10:15:00', 'Kampüs kapalıymış bugün, iptal.'),

-- İptal 15: Yolda kaza olmuş
(32, 18, 'Araç Paylaşımı', 'Tüm Üniversiteler', '2025-11-28', '2025-11-28 17:00:00', '2025-11-28 17:50:00', 3, 1, 'İptal Edildi', TRUE, TRUE, 'Çankaya yönü.', 'Sabit', 55.00, '2025-11-27 14:30:00', 'Yolda kaza olmuş, trafik çok kötü.');


-- ============================================
-- UNIRING - TEST VERİSİ: SEFER GÜZERGAH NOKTALARI
-- ADIM 6/10 - Her sefer için rota noktaları
-- ============================================

-- Her sefer için başlangıç, ara duraklar ve varış noktaları
-- Gerçekçi Ankara ve İstanbul konumları

INSERT INTO SeferGuzergahNoktalari (seferID, konumAdi, latitude, longitude, siraNo, planlananVarisZamani, mesafeOncekiNoktaya) VALUES

-- ============================================
-- SEFER 1: TOBB -> Kızılay
-- ============================================
(1, 'TOBB ETÜ Ana Kapı', 39.9210, 32.7975, 1, '17:30:00', NULL),
(1, 'Bahçelievler 7. Cadde', 39.9250, 32.8200, 2, '17:45:00', 5.2),
(1, 'Kızılay Meydanı', 39.9208, 32.8541, 3, '18:15:00', 4.8),

-- ============================================
-- SEFER 2: ODTÜ -> Tunalı
-- ============================================
(2, 'ODTÜ A1 Kapısı', 39.8910, 32.7750, 1, '16:00:00', NULL),
(2, 'Kızılay', 39.9208, 32.8541, 2, '16:25:00', 8.5),
(2, 'Tunalı Hilmi Caddesi', 39.9050, 32.8600, 3, '16:45:00', 3.2),

-- ============================================
-- SEFER 3: Bilkent -> AVM
-- ============================================
(3, 'Bilkent Ana Giriş', 39.8650, 32.7492, 1, '14:00:00', NULL),
(3, 'Ankamall AVM', 39.9580, 32.7381, 2, '14:40:00', 12.5),

-- ============================================
-- SEFER 4: TOBB -> Bahçelievler
-- ============================================
(4, 'TOBB ETÜ Ana Kapı', 39.9210, 32.7975, 1, '18:00:00', NULL),
(4, 'Bahçelievler Meydanı', 39.9250, 32.8200, 2, '18:30:00', 5.2),

-- ============================================
-- SEFER 5: Boğaziçi -> Taksim
-- ============================================
(5, 'Boğaziçi Bebek Kampüsü', 41.0863, 29.0431, 1, '19:00:00', NULL),
(5, 'Beşiktaş İskelesi', 41.0425, 29.0075, 2, '19:15:00', 6.3),
(5, 'Taksim Meydanı', 41.0370, 28.9850, 3, '19:35:00', 3.8),

-- ============================================
-- SEFER 6: ODTÜ -> Kızılay
-- ============================================
(6, 'ODTÜ A1 Kapısı', 39.8910, 32.7750, 1, '17:30:00', NULL),
(6, 'Söğütözü', 39.9180, 32.8010, 2, '17:50:00', 6.5),
(6, 'Kızılay Meydanı', 39.9208, 32.8541, 3, '18:10:00', 5.8),

-- ============================================
-- SEFER 7: Hacettepe -> Çankaya
-- ============================================
(7, 'Hacettepe Sıhhiye Kampüsü', 39.9350, 32.8620, 1, '16:00:00', NULL),
(7, 'Kızılay', 39.9208, 32.8541, 2, '16:15:00', 2.5),
(7, 'Çankaya Belediyesi', 39.9115, 32.8634, 3, '16:35:00', 3.2),

-- ============================================
-- SEFER 8: İTÜ -> Maslak
-- ============================================
(8, 'İTÜ Ayazağa Kampüsü', 41.1063, 29.0228, 1, '18:30:00', NULL),
(8, 'Maslak Meydanı', 41.1082, 29.0189, 2, '19:00:00', 4.5),

-- ============================================
-- SEFER 9: TOBB -> Ulus
-- ============================================
(9, 'TOBB ETÜ Ana Kapı', 39.9210, 32.7975, 1, '15:00:00', NULL),
(9, 'Kızılay', 39.9208, 32.8541, 2, '15:20:00', 10.2),
(9, 'Ulus Meydanı', 39.9450, 32.8597, 3, '15:40:00', 3.8),

-- ============================================
-- SEFER 10: Koç -> Şişli
-- ============================================
(10, 'Koç Üniversitesi Rumeli Feneri', 41.1950, 29.0805, 1, '17:00:00', NULL),
(10, 'İstinye Park AVM', 41.1120, 29.0285, 2, '17:25:00', 12.5),
(10, 'Şişli Meydanı', 41.0602, 28.9887, 3, '17:50:00', 8.3),

-- ============================================
-- SEFER 11: ODTÜ -> Çayyolu
-- ============================================
(11, 'ODTÜ A1 Kapısı', 39.8910, 32.7750, 1, '16:30:00', NULL),
(11, 'Bilkent Kavşağı', 39.8680, 32.7520, 2, '16:50:00', 5.8),
(11, 'Çayyolu Parkora AVM', 39.8950, 32.6800, 3, '17:10:00', 8.2),

-- ============================================
-- SEFER 12: Bilkent -> Söğütözü
-- ============================================
(12, 'Bilkent Ana Giriş', 39.8650, 32.7492, 1, '14:00:00', NULL),
(12, 'Söğütözü İş Merkezi', 39.9180, 32.8010, 2, '14:30:00', 7.5),

-- ============================================
-- SEFER 13: Ege -> Konak (Ortak Araç)
-- ============================================
(13, 'Ege Üniversitesi Bornova Kampüsü', 38.4620, 27.2160, 1, '18:00:00', NULL),
(13, 'Konak Meydanı', 38.4189, 27.1287, 2, '18:40:00', 11.5),

-- ============================================
-- SEFER 14: TOBB -> Kavaklıdere
-- ============================================
(14, 'TOBB ETÜ Ana Kapı', 39.9210, 32.7975, 1, '17:00:00', NULL),
(14, 'Çankaya', 39.9115, 32.8634, 2, '17:20:00', 8.5),
(14, 'Kavaklıdere', 39.9080, 32.8580, 3, '17:35:00', 2.5),

-- ============================================
-- SEFER 15: Boğaziçi -> Kadıköy
-- ============================================
(15, 'Boğaziçi Güney Kampüsü', 41.0830, 29.0550, 1, '16:00:00', NULL),
(15, 'Beşiktaş İskelesi', 41.0425, 29.0075, 2, '16:20:00', 6.5),
(15, 'Kadıköy İskelesi', 40.9925, 29.0250, 3, '17:00:00', 8.8),

-- ============================================
-- SEFER 16: ODTÜ -> Bilkent
-- ============================================
(16, 'ODTÜ A1 Kapısı', 39.8910, 32.7750, 1, '15:00:00', NULL),
(16, 'Bilkent Ana Giriş', 39.8650, 32.7492, 2, '15:45:00', 6.5),

-- ============================================
-- SEFER 17: Hacettepe -> Kızılay
-- ============================================
(17, 'Hacettepe Sıhhiye Kampüsü', 39.9350, 32.8620, 1, '18:30:00', NULL),
(17, 'Kızılay Meydanı', 39.9208, 32.8541, 2, '19:00:00', 2.5),

-- ============================================
-- SEFER 18: İTÜ -> Beşiktaş
-- ============================================
(18, 'İTÜ Maçka Kampüsü', 41.0420, 28.9900, 1, '17:00:00', NULL),
(18, 'Beşiktaş Meydanı', 41.0425, 29.0075, 2, '17:40:00', 4.2),

-- ============================================
-- SEFER 19: TOBB -> Tunalı
-- ============================================
(19, 'TOBB ETÜ Ana Kapı', 39.9210, 32.7975, 1, '16:30:00', NULL),
(19, 'Kızılay', 39.9208, 32.8541, 2, '16:55:00', 10.2),
(19, 'Tunalı Hilmi Caddesi', 39.9050, 32.8600, 3, '17:15:00', 3.2),

-- ============================================
-- SEFER 20: Bilkent -> ODTÜ
-- ============================================
(20, 'Bilkent Ana Giriş', 39.8650, 32.7492, 1, '14:00:00', NULL),
(20, 'ODTÜ A1 Kapısı', 39.8910, 32.7750, 2, '14:35:00', 6.5),

-- ============================================
-- SEFER 21: Koç -> Bebek
-- ============================================
(21, 'Koç Üniversitesi Sarıyer Kampüsü', 41.1950, 29.0805, 1, '18:00:00', NULL),
(21, 'Bebek Sahil', 41.0800, 29.0450, 2, '18:30:00', 15.2),

-- ============================================
-- SEFER 22: ODTÜ -> Ankamall
-- ============================================
(22, 'ODTÜ A1 Kapısı', 39.8910, 32.7750, 1, '15:00:00', NULL),
(22, 'Bilkent Kavşağı', 39.8680, 32.7520, 2, '15:20:00', 5.8),
(22, 'Ankamall AVM', 39.9580, 32.7381, 3, '15:50:00', 12.5),

-- ============================================
-- SEFER 23: Boğaziçi -> Ortaköy
-- ============================================
(23, 'Boğaziçi Bebek Kampüsü', 41.0863, 29.0431, 1, '19:00:00', NULL),
(23, 'Ortaköy Meydanı', 41.0550, 29.0290, 2, '19:30:00', 4.5),

-- ============================================
-- SEFER 24: Hacettepe -> Tunalı
-- ============================================
(24, 'Hacettepe Beytepe Kampüsü', 39.8680, 32.7350, 1, '17:30:00', NULL),
(24, 'Kızılay', 39.9208, 32.8541, 2, '17:50:00', 15.5),
(24, 'Tunalı Hilmi Caddesi', 39.9050, 32.8600, 3, '18:00:00', 3.2),

-- ============================================
-- SEFER 25: İTÜ -> Levent
-- ============================================
(25, 'İTÜ Ayazağa Kampüsü', 41.1063, 29.0228, 1, '16:00:00', NULL),
(25, '1.Levent Metro', 41.0755, 29.0100, 2, '16:45:00', 7.8),

-- ============================================
-- AKTİF/PLANLANMIŞ SEFERLER (26-45)
-- ============================================

-- SEFER 26: TOBB -> Kızılay (Yarın)
(26, 'TOBB ETÜ Ana Kapı', 39.9210, 32.7975, 1, '17:00:00', NULL),
(26, 'Bahçelievler', 39.9250, 32.8200, 2, '17:20:00', 5.2),
(26, 'Kızılay Meydanı', 39.9208, 32.8541, 3, '17:45:00', 4.8),

-- SEFER 27: ODTÜ -> Çayyolu (Yarın)
(27, 'ODTÜ A1 Kapısı', 39.8910, 32.7750, 1, '16:30:00', NULL),
(27, 'Bilkent Kavşağı', 39.8680, 32.7520, 2, '16:50:00', 5.8),
(27, 'Çayyolu Parkora AVM', 39.8950, 32.6800, 3, '17:15:00', 8.2),

-- SEFER 28: Bilkent -> Ankamall (Yarın)
(28, 'Bilkent Ana Giriş', 39.8650, 32.7492, 1, '15:00:00', NULL),
(28, 'Çayyolu', 39.8950, 32.6800, 2, '15:25:00', 9.5),
(28, 'Ankamall AVM', 39.9580, 32.7381, 3, '15:50:00', 11.2),

-- SEFER 29: Boğaziçi -> Taksim (2 gün sonra)
(29, 'Boğaziçi Bebek Kampüsü', 41.0863, 29.0431, 1, '18:00:00', NULL),
(29, 'Beşiktaş', 41.0425, 29.0075, 2, '18:20:00', 6.3),
(29, 'Taksim Meydanı', 41.0370, 28.9850, 3, '18:45:00', 3.8),

-- SEFER 30: TOBB -> Bahçelievler (2 gün sonra)
(30, 'TOBB ETÜ Ana Kapı', 39.9210, 32.7975, 1, '17:30:00', NULL),
(30, 'Bahçelievler Meydanı', 39.9250, 32.8200, 2, '18:00:00', 5.2),

-- SEFER 31: İTÜ -> Maslak (3 gün sonra)
(31, 'İTÜ Ayazağa Kampüsü', 41.1063, 29.0228, 1, '16:00:00', NULL),
(31, 'Maslak Meydanı', 41.1082, 29.0189, 2, '16:40:00', 4.5),

-- SEFER 32: Hacettepe -> Kızılay (3 gün sonra)
(32, 'Hacettepe Sıhhiye Kampüsü', 39.9350, 32.8620, 1, '17:00:00', NULL),
(32, 'Kızılay Meydanı', 39.9208, 32.8541, 2, '17:30:00', 2.5),

-- SEFER 33: ODTÜ -> Tunalı (4 gün sonra)
(33, 'ODTÜ A1 Kapısı', 39.8910, 32.7750, 1, '16:00:00', NULL),
(33, 'Kızılay', 39.9208, 32.8541, 2, '16:25:00', 8.5),
(33, 'Tunalı Hilmi Caddesi', 39.9050, 32.8600, 3, '16:45:00', 3.2),

-- SEFER 34: Koç -> Etiler (4 gün sonra)
(34, 'Koç Üniversitesi Sarıyer Kampüsü', 41.1950, 29.0805, 1, '18:00:00', NULL),
(34, 'Etiler Meydanı', 41.0690, 29.0210, 2, '18:35:00', 14.8),

-- SEFER 35: Bilkent -> ODTÜ (5 gün sonra)
(35, 'Bilkent Ana Giriş', 39.8650, 32.7492, 1, '14:00:00', NULL),
(35, 'ODTÜ A1 Kapısı', 39.8910, 32.7750, 2, '14:35:00', 6.5),

-- SEFER 36: TOBB -> Ulus (5 gün sonra)
(36, 'TOBB ETÜ Ana Kapı', 39.9210, 32.7975, 1, '15:30:00', NULL),
(36, 'Kızılay', 39.9208, 32.8541, 2, '15:50:00', 10.2),
(36, 'Ulus Meydanı', 39.9450, 32.8597, 3, '16:10:00', 3.8),

-- SEFER 37: Boğaziçi -> Kadıköy (6 gün sonra)
(37, 'Boğaziçi Güney Kampüsü', 41.0830, 29.0550, 1, '16:00:00', NULL),
(37, 'Beşiktaş', 41.0425, 29.0075, 2, '16:25:00', 6.5),
(37, 'Kadıköy İskelesi', 40.9925, 29.0250, 3, '17:00:00', 8.8),

-- SEFER 38: ODTÜ -> Bilkent (7 gün sonra)
(38, 'ODTÜ A1 Kapısı', 39.8910, 32.7750, 1, '15:00:00', NULL),
(38, 'Bilkent Ana Giriş', 39.8650, 32.7492, 2, '15:45:00', 6.5),

-- SEFER 39: İTÜ -> Şişli (7 gün sonra - Ortak Araç)
(39, 'İTÜ Ayazağa Kampüsü', 41.1063, 29.0228, 1, '17:00:00', NULL),
(39, 'Maslak', 41.1082, 29.0189, 2, '17:20:00', 4.5),
(39, 'Şişli Meydanı', 41.0602, 28.9887, 3, '17:45:00', 7.5),

-- SEFER 40: Hacettepe -> Çankaya (8 gün sonra)
(40, 'Hacettepe Beytepe Kampüsü', 39.8680, 32.7350, 1, '16:30:00', NULL),
(40, 'Kızılay', 39.9208, 32.8541, 2, '16:55:00', 15.5),
(40, 'Çankaya Belediyesi', 39.9115, 32.8634, 3, '17:05:00', 2.2),

-- SEFER 41: TOBB -> Kavaklıdere (9 gün sonra)
(41, 'TOBB ETÜ Ana Kapı', 39.9210, 32.7975, 1, '17:00:00', NULL),
(41, 'Çankaya', 39.9115, 32.8634, 2, '17:20:00', 8.5),
(41, 'Kavaklıdere', 39.9080, 32.8580, 3, '17:35:00', 2.5),

-- SEFER 42: Bilkent -> Kızılay (10 gün sonra)
(42, 'Bilkent Ana Giriş', 39.8650, 32.7492, 1, '16:00:00', NULL),
(42, 'Söğütözü', 39.9180, 32.8010, 2, '16:20:00', 7.5),
(42, 'Kızılay Meydanı', 39.9208, 32.8541, 3, '16:40:00', 5.8),

-- SEFER 43: Boğaziçi -> Ortaköy (10 gün sonra)
(43, 'Boğaziçi Bebek Kampüsü', 41.0863, 29.0431, 1, '18:00:00', NULL),
(43, 'Ortaköy Meydanı', 41.0550, 29.0290, 2, '18:30:00', 4.5),

-- SEFER 44: ODTÜ -> Ulus (11 gün sonra)
(44, 'ODTÜ A1 Kapısı', 39.8910, 32.7750, 1, '14:00:00', NULL),
(44, 'Kızılay', 39.9208, 32.8541, 2, '14:25:00', 8.5),
(44, 'Ulus Meydanı', 39.9450, 32.8597, 3, '14:50:00', 3.8),

-- SEFER 45: İTÜ -> Beşiktaş (12 gün sonra)
(45, 'İTÜ Maçka Kampüsü', 41.0420, 28.9900, 1, '17:00:00', NULL),
(45, 'Beşiktaş Meydanı', 41.0425, 29.0075, 2, '17:40:00', 4.2),

-- ============================================
-- İPTAL EDİLMİŞ SEFERLER İÇİN NOKTALAR (46-60)
-- ============================================

-- İptal edilmiş seferler için de rota noktaları (tutarlılık için)
(46, 'TOBB ETÜ Ana Kapı', 39.9210, 32.7975, 1, '16:00:00', NULL),
(46, 'Tunalı Hilmi Caddesi', 39.9050, 32.8600, 2, '16:45:00', 10.2),

(47, 'TOBB ETÜ Ana Kapı', 39.9210, 32.7975, 1, '17:00:00', NULL),
(47, 'Çayyolu Parkora AVM', 39.8950, 32.6800, 2, '17:40:00', 14.5),

(48, 'TOBB ETÜ Ana Kapı', 39.9210, 32.7975, 1, '15:00:00', NULL),
(48, 'Kızılay Meydanı', 39.9208, 32.8541, 2, '15:45:00', 10.2),

(49, 'TOBB ETÜ Ana Kapı', 39.9210, 32.7975, 1, '16:30:00', NULL),
(49, 'Bahçelievler Meydanı', 39.9250, 32.8200, 2, '17:15:00', 5.2),

(50, 'TOBB ETÜ Ana Kapı', 39.9210, 32.7975, 1, '17:00:00', NULL),
(50, 'Tunalı Hilmi Caddesi', 39.9050, 32.8600, 2, '17:50:00', 10.2),

(51, 'TOBB ETÜ Ana Kapı', 39.9210, 32.7975, 1, '16:00:00', NULL),
(51, 'Kızılay Meydanı', 39.9208, 32.8541, 2, '16:40:00', 10.2),

(52, 'TOBB ETÜ Ana Kapı', 39.9210, 32.7975, 1, '18:00:00', NULL),
(52, 'Çankaya Belediyesi', 39.9115, 32.8634, 2, '18:45:00', 8.5),

(53, 'ODTÜ A1 Kapısı', 39.8910, 32.7750, 1, '15:00:00', NULL),
(53, 'Ankamall AVM', 39.9580, 32.7381, 2, '15:50:00', 18.5),

(54, 'ODTÜ A1 Kapısı', 39.8910, 32.7750, 1, '17:30:00', NULL),
(54, 'Tunalı Hilmi Caddesi', 39.9050, 32.8600, 2, '18:10:00', 12.5),

(55, 'ODTÜ A1 Kapısı', 39.8910, 32.7750, 1, '16:00:00', NULL),
(55, 'Bilkent Ana Giriş', 39.8650, 32.7492, 2, '16:45:00', 6.5),

(56, 'ODTÜ A1 Kapısı', 39.8910, 32.7750, 1, '14:00:00', NULL),
(56, 'Çayyolu Parkora AVM', 39.8950, 32.6800, 2, '14:50:00', 12.5),

(57, 'ODTÜ A1 Kapısı', 39.8910, 32.7750, 1, '17:00:00', NULL),
(57, 'Kızılay Meydanı', 39.9208, 32.8541, 2, '17:40:00', 8.5),

(58, 'ODTÜ A1 Kapısı', 39.8910, 32.7750, 1, '16:30:00', NULL),
(58, 'Tunalı Hilmi Caddesi', 39.9050, 32.8600, 2, '17:15:00', 12.5),

(59, 'ODTÜ A1 Kapısı', 39.8910, 32.7750, 1, '15:00:00', NULL),
(59, 'Bilkent Ana Giriş', 39.8650, 32.7492, 2, '15:45:00', 6.5),

(60, 'Bilkent Ana Giriş', 39.8650, 32.7492, 1, '17:00:00', NULL),
(60, 'Çankaya Belediyesi', 39.9115, 32.8634, 2, '17:50:00', 15.5);


-- ============================================
-- UNIRING - TEST VERİSİ: REZERVASYONLAR
-- ADIM 7/10 - Yolcu rezervasyonları
-- ============================================

-- Rezervasyon dağılımı:
-- 50 Tamamlanmış (geçmiş seferler için)
-- 20 Onaylandı (aktif seferler için)
-- 10 Beklemede, Reddedildi, İptal Edildi

INSERT INTO Rezervasyonlar (seferID, yolcuID, binisNoktaID, inisNoktaID, yolcuSayisi, hesaplananUcret, indirimMiktari, odenecekTutar, durum, olusturulmaTarihi, onaylanmaTarihi, iptalNedeni, yolcuDegerlendirdiMi, organizatorDegerlendirdiMi) VALUES

-- ============================================
-- TAMAMLANMIŞ REZERVASYONLAR (50 adet)
-- ============================================

-- Sefer 1 rezervasyonları (2 yolcu)
(1, 3, 1, 2, 1, 50.00, 0.00, 50.00, 'Tamamlandı', '2025-10-14 12:00:00', '2025-10-14 13:30:00', NULL, TRUE, TRUE),
(1, 4, 2, 3, 1, 50.00, 0.00, 50.00, 'Tamamlandı', '2025-10-14 14:20:00', '2025-10-14 15:00:00', NULL, TRUE, TRUE),

-- Sefer 2 rezervasyonları (3 yolcu - dolu)
(2, 18, 1, 2, 1, 45.00, 0.00, 45.00, 'Tamamlandı', '2025-10-17 16:00:00', '2025-10-17 17:00:00', NULL, TRUE, TRUE),
(2, 19, 1, 3, 1, 45.00, 5.00, 40.00, 'Tamamlandı', '2025-10-17 17:30:00', '2025-10-17 18:00:00', NULL, TRUE, TRUE),
(2, 20, 2, 3, 1, 45.00, 0.00, 45.00, 'Tamamlandı', '2025-10-17 18:20:00', '2025-10-17 19:00:00', NULL, TRUE, TRUE),

-- Sefer 3 rezervasyonları (2 yolcu)
(3, 35, 1, 2, 1, 60.00, 0.00, 60.00, 'Tamamlandı', '2025-10-19 11:00:00', '2025-10-19 12:00:00', NULL, TRUE, TRUE),
(3, 37, 1, 2, 1, 60.00, 10.00, 50.00, 'Tamamlandı', '2025-10-19 13:15:00', '2025-10-19 14:00:00', NULL, TRUE, TRUE),

-- Sefer 4 rezervasyonları (1 yolcu)
(4, 5, 1, 2, 1, 40.00, 0.00, 40.00, 'Tamamlandı', '2025-10-21 18:00:00', '2025-10-21 19:00:00', NULL, TRUE, TRUE),

-- Sefer 5 rezervasyonları (2 yolcu)
(5, 55, 1, 2, 1, 70.00, 0.00, 70.00, 'Tamamlandı', '2025-10-24 13:30:00', '2025-10-24 14:30:00', NULL, TRUE, TRUE),
(5, 57, 2, 3, 1, 70.00, 0.00, 70.00, 'Tamamlandı', '2025-10-24 15:00:00', '2025-10-24 16:00:00', NULL, TRUE, TRUE),

-- Sefer 6 rezervasyonları (3 yolcu - dolu)
(6, 20, 1, 2, 1, 55.00, 0.00, 55.00, 'Tamamlandı', '2025-10-27 15:00:00', '2025-10-27 16:00:00', NULL, TRUE, TRUE),
(6, 23, 1, 3, 1, 55.00, 5.00, 50.00, 'Tamamlandı', '2025-10-27 16:30:00', '2025-10-27 17:00:00', NULL, TRUE, TRUE),
(6, 25, 2, 3, 1, 55.00, 0.00, 55.00, 'Tamamlandı', '2025-10-27 17:45:00', '2025-10-27 18:30:00', NULL, TRUE, TRUE),

-- Sefer 7 rezervasyonları (1 yolcu)
(7, 45, 1, 3, 1, 45.00, 0.00, 45.00, 'Tamamlandı', '2025-10-31 12:00:00', '2025-10-31 13:00:00', NULL, TRUE, TRUE),

-- Sefer 8 rezervasyonları (2 yolcu)
(8, 67, 1, 2, 1, 50.00, 0.00, 50.00, 'Tamamlandı', '2025-11-02 17:00:00', '2025-11-02 18:00:00', NULL, TRUE, TRUE),
(8, 69, 1, 2, 1, 50.00, 0.00, 50.00, 'Tamamlandı', '2025-11-02 18:30:00', '2025-11-02 19:00:00', NULL, TRUE, TRUE),

-- Sefer 9 rezervasyonları (2 yolcu)
(9, 7, 1, 3, 1, 40.00, 0.00, 40.00, 'Tamamlandı', '2025-11-04 14:00:00', '2025-11-04 15:00:00', NULL, TRUE, TRUE),
(9, 9, 2, 3, 1, 40.00, 0.00, 40.00, 'Tamamlandı', '2025-11-04 15:30:00', '2025-11-04 16:00:00', NULL, TRUE, TRUE),

-- Sefer 10 rezervasyonları (3 yolcu - dolu)
(10, 77, 1, 2, 1, 80.00, 0.00, 80.00, 'Tamamlandı', '2025-11-06 11:00:00', '2025-11-06 12:00:00', NULL, TRUE, TRUE),
(10, 79, 1, 3, 1, 80.00, 10.00, 70.00, 'Tamamlandı', '2025-11-06 12:30:00', '2025-11-06 13:00:00', NULL, TRUE, TRUE),
(10, 81, 2, 3, 1, 80.00, 0.00, 80.00, 'Tamamlandı', '2025-11-06 13:45:00', '2025-11-06 14:30:00', NULL, TRUE, TRUE),

-- Sefer 11 rezervasyonları (2 yolcu)
(11, 23, 1, 3, 1, 50.00, 0.00, 50.00, 'Tamamlandı', '2025-11-07 16:00:00', '2025-11-07 17:00:00', NULL, TRUE, TRUE),
(11, 25, 2, 3, 1, 50.00, 0.00, 50.00, 'Tamamlandı', '2025-11-07 17:30:00', '2025-11-07 18:00:00', NULL, TRUE, TRUE),

-- Sefer 12 rezervasyonları (1 yolcu)
(12, 35, 1, 2, 1, 45.00, 0.00, 45.00, 'Tamamlandı', '2025-11-09 13:00:00', '2025-11-09 14:00:00', NULL, TRUE, TRUE),

-- Sefer 13 rezervasyonları (3 yolcu - Ortak Araç)
(13, 85, 1, 2, 1, 30.00, 0.00, 30.00, 'Tamamlandı', '2025-11-11 18:00:00', '2025-11-11 19:00:00', NULL, TRUE, TRUE),
(13, 87, 1, 2, 1, 30.00, 0.00, 30.00, 'Tamamlandı', '2025-11-11 18:30:00', '2025-11-11 19:15:00', NULL, TRUE, TRUE),
(13, 88, 1, 2, 1, 30.00, 5.00, 25.00, 'Tamamlandı', '2025-11-11 19:00:00', '2025-11-11 19:30:00', NULL, TRUE, TRUE),

-- Sefer 14 rezervasyonları (3 yolcu - dolu)
(14, 9, 1, 3, 1, 50.00, 0.00, 50.00, 'Tamamlandı', '2025-11-13 12:00:00', '2025-11-13 13:00:00', NULL, TRUE, TRUE),
(14, 11, 1, 2, 1, 50.00, 0.00, 50.00, 'Tamamlandı', '2025-11-13 13:30:00', '2025-11-13 14:00:00', NULL, TRUE, TRUE),
(14, 13, 2, 3, 1, 50.00, 0.00, 50.00, 'Tamamlandı', '2025-11-13 14:30:00', '2025-11-13 15:00:00', NULL, TRUE, TRUE),

-- Sefer 15 rezervasyonları (2 yolcu)
(15, 57, 1, 3, 1, 65.00, 0.00, 65.00, 'Tamamlandı', '2025-11-14 15:00:00', '2025-11-14 16:00:00', NULL, TRUE, TRUE),
(15, 59, 2, 3, 1, 65.00, 0.00, 65.00, 'Tamamlandı', '2025-11-14 16:30:00', '2025-11-14 17:00:00', NULL, TRUE, TRUE),

-- Sefer 16 rezervasyonları (2 yolcu)
(16, 31, 1, 2, 1, 40.00, 0.00, 40.00, 'Tamamlandı', '2025-11-16 11:00:00', '2025-11-16 12:00:00', NULL, TRUE, TRUE),
(16, 35, 1, 2, 1, 40.00, 5.00, 35.00, 'Tamamlandı', '2025-11-16 12:30:00', '2025-11-16 13:00:00', NULL, TRUE, TRUE),

-- Sefer 17 rezervasyonları (1 yolcu)
(17, 47, 1, 2, 1, 35.00, 0.00, 35.00, 'Tamamlandı', '2025-11-17 17:00:00', '2025-11-17 18:00:00', NULL, TRUE, TRUE),

-- Sefer 18 rezervasyonları (2 yolcu)
(18, 69, 1, 2, 1, 55.00, 0.00, 55.00, 'Tamamlandı', '2025-11-18 14:00:00', '2025-11-18 15:00:00', NULL, TRUE, TRUE),
(18, 71, 1, 2, 1, 55.00, 0.00, 55.00, 'Tamamlandı', '2025-11-18 15:30:00', '2025-11-18 16:00:00', NULL, TRUE, TRUE),

-- Sefer 19 rezervasyonları (3 yolcu - dolu)
(19, 11, 1, 3, 1, 55.00, 0.00, 55.00, 'Tamamlandı', '2025-11-19 16:00:00', '2025-11-19 17:00:00', NULL, TRUE, TRUE),
(19, 13, 2, 3, 1, 55.00, 0.00, 55.00, 'Tamamlandı', '2025-11-19 17:30:00', '2025-11-19 18:00:00', NULL, TRUE, TRUE),
(19, 15, 1, 2, 1, 55.00, 5.00, 50.00, 'Tamamlandı', '2025-11-19 18:15:00', '2025-11-19 18:45:00', NULL, TRUE, TRUE),

-- Sefer 20 rezervasyonları (2 yolcu)
(20, 16, 1, 2, 1, 40.00, 0.00, 40.00, 'Tamamlandı', '2025-11-20 12:00:00', '2025-11-20 13:00:00', NULL, TRUE, TRUE),
(20, 18, 1, 2, 1, 40.00, 0.00, 40.00, 'Tamamlandı', '2025-11-20 13:30:00', '2025-11-20 14:00:00', NULL, TRUE, TRUE),

-- Sefer 21 rezervasyonları (2 yolcu)
(21, 79, 1, 2, 1, 50.00, 0.00, 50.00, 'Tamamlandı', '2025-11-21 18:00:00', '2025-11-21 19:00:00', NULL, TRUE, TRUE),
(21, 81, 1, 2, 1, 50.00, 0.00, 50.00, 'Tamamlandı', '2025-11-21 19:15:00', '2025-11-21 19:45:00', NULL, TRUE, TRUE),

-- Sefer 22 rezervasyonları (3 yolcu - dolu)
(22, 27, 1, 3, 1, 50.00, 0.00, 50.00, 'Tamamlandı', '2025-11-22 13:00:00', '2025-11-22 14:00:00', NULL, TRUE, TRUE),
(22, 29, 2, 3, 1, 50.00, 0.00, 50.00, 'Tamamlandı', '2025-11-22 14:30:00', '2025-11-22 15:00:00', NULL, TRUE, TRUE),
(22, 30, 1, 2, 1, 50.00, 5.00, 45.00, 'Tamamlandı', '2025-11-22 15:30:00', '2025-11-22 16:00:00', NULL, TRUE, TRUE),

-- Sefer 23 rezervasyonları (2 yolcu)
(23, 59, 1, 2, 1, 60.00, 0.00, 60.00, 'Tamamlandı', '2025-11-23 15:00:00', '2025-11-23 16:00:00', NULL, TRUE, TRUE),
(23, 61, 1, 2, 1, 60.00, 0.00, 60.00, 'Tamamlandı', '2025-11-23 16:30:00', '2025-11-23 17:00:00', NULL, TRUE, TRUE),

-- Sefer 24 rezervasyonları (2 yolcu)
(24, 49, 1, 3, 1, 60.00, 0.00, 60.00, 'Tamamlandı', '2025-11-24 17:00:00', '2025-11-24 18:00:00', NULL, TRUE, TRUE),
(24, 51, 2, 3, 1, 60.00, 0.00, 60.00, 'Tamamlandı', '2025-11-24 18:30:00', '2025-11-24 19:00:00', NULL, TRUE, TRUE),

-- Sefer 25 rezervasyonları (1 yolcu)
(25, 71, 1, 2, 1, 55.00, 0.00, 55.00, 'Tamamlandı', '2025-11-25 14:00:00', '2025-11-25 15:00:00', NULL, TRUE, TRUE),

-- ============================================
-- AKTİF SEFERLER İÇİN ONAYLANMIŞ REZERVASYONLAR (20 adet)
-- ============================================

-- Sefer 26 rezervasyonları (2 yolcu - Yarın)
(26, 3, 1, 3, 1, 50.00, 0.00, 50.00, 'Onaylandı', '2025-11-30 12:00:00', '2025-11-30 13:00:00', NULL, FALSE, FALSE),
(26, 5, 2, 3, 1, 50.00, 0.00, 50.00, 'Onaylandı', '2025-11-30 14:30:00', '2025-11-30 15:00:00', NULL, FALSE, FALSE),

-- Sefer 27 rezervasyonları (1 yolcu - Yarın)
(27, 20, 1, 3, 1, 55.00, 0.00, 55.00, 'Onaylandı', '2025-11-30 16:00:00', '2025-11-30 17:00:00', NULL, FALSE, FALSE),

-- Sefer 29 rezervasyonları (1 yolcu - 2 gün sonra)
(29, 55, 1, 3, 1, 70.00, 0.00, 70.00, 'Onaylandı', '2025-12-01 13:00:00', '2025-12-01 14:00:00', NULL, FALSE, FALSE),

-- Sefer 32 rezervasyonları (1 yolcu - 3 gün sonra)
(32, 45, 1, 2, 1, 40.00, 0.00, 40.00, 'Onaylandı', '2025-12-01 18:00:00', '2025-12-01 19:00:00', NULL, FALSE, FALSE),

-- Sefer 35 rezervasyonları (1 yolcu - 5 gün sonra)
(35, 16, 1, 2, 1, 40.00, 5.00, 35.00, 'Onaylandı', '2025-12-01 16:00:00', '2025-12-01 17:00:00', NULL, FALSE, FALSE),

-- Sefer 37 rezervasyonları (0 yolcu - 6 gün sonra - Henüz kimse yok)

-- Sefer 39 rezervasyonları (2 yolcu - 7 gün sonra - Ortak Araç)
(39, 67, 1, 3, 1, 35.00, 0.00, 35.00, 'Onaylandı', '2025-12-01 17:00:00', '2025-12-01 18:00:00', NULL, FALSE, FALSE),
(39, 69, 1, 2, 1, 35.00, 0.00, 35.00, 'Onaylandı', '2025-12-01 18:30:00', '2025-12-01 19:00:00', NULL, FALSE, FALSE),

-- Sefer 41 rezervasyonları (1 yolcu - 9 gün sonra)
(41, 3, 1, 3, 1, 55.00, 0.00, 55.00, 'Onaylandı', '2025-12-01 11:00:00', '2025-12-01 12:00:00', NULL, FALSE, FALSE),

-- ============================================
-- BEKLEMEDE, REDDEDİLDİ, İPTAL EDİLDİ (10 adet)
-- ============================================

-- Beklemede (henüz onaylanmamış - 5 adet)
(28, 32, 1, 3, 1, 60.00, 0.00, 60.00, 'Beklemede', '2025-12-01 10:00:00', NULL, NULL, FALSE, FALSE),
(30, 7, 1, 2, 1, 45.00, 0.00, 45.00, 'Beklemede', '2025-12-01 12:00:00', NULL, NULL, FALSE, FALSE),
(31, 67, 1, 2, 1, 50.00, 0.00, 50.00, 'Beklemede', '2025-12-01 14:00:00', NULL, NULL, FALSE, FALSE),
(34, 75, 1, 2, 1, 65.00, 0.00, 65.00, 'Beklemede', '2025-12-01 15:30:00', NULL, NULL, FALSE, FALSE),
(36, 9, 1, 3, 1, 45.00, 0.00, 45.00, 'Beklemede', '2025-12-01 17:00:00', NULL, NULL, FALSE, FALSE),

-- Reddedildi (organizatör tarafından - 3 adet)
(33, 25, 1, 3, 1, 50.00, 0.00, 50.00, 'Reddedildi', '2025-12-01 09:00:00', '2025-12-01 10:30:00', 'Kapasite doldu, üzgünüm.', FALSE, FALSE),
(38, 23, 1, 2, 1, 40.00, 0.00, 40.00, 'Reddedildi', '2025-12-01 11:00:00', '2025-12-01 12:00:00', 'Güzergah uymuyor.', FALSE, FALSE),
(40, 43, 1, 3, 1, 50.00, 0.00, 50.00, 'Reddedildi', '2025-12-01 13:00:00', '2025-12-01 14:00:00', 'Bu sefer sadece yakın arkadaşlarıma.', FALSE, FALSE),

-- İptal Edildi (yolcu tarafından - 2 adet)
(42, 37, 1, 3, 1, 50.00, 0.00, 50.00, 'İptal Edildi', '2025-12-01 08:00:00', '2025-12-01 09:00:00', 'Planım değişti, gidemiyorum.', FALSE, FALSE),
(43, 61, 1, 2, 1, 60.00, 0.00, 60.00, 'İptal Edildi', '2025-12-01 10:00:00', '2025-12-01 11:00:00', 'Başka araç buldum, teşekkürler.', FALSE, FALSE);


-- ============================================
-- UNIRING - TEST VERİSİ: ÖDEMELER
-- ADIM 8/10 - Ödeme işlemleri
-- ============================================

-- Ödeme dağılımı:
-- 50 Ödendi (tamamlanmış rezervasyonlar)
-- 10 Ödenmedi (yeni onaylanmış rezervasyonlar)
-- Platform komisyonu: %10

INSERT INTO Odemeler (rezervasyonID, seferID, borcluID, alacakliID, tutar, platformKomisyonu, netTutar, odemeTipi, odemeDurumu, islemTarihi, onayTarihi, faturaURL) VALUES

-- ============================================
-- ÖDENMİŞ ÖDEMELER (50 adet - Tamamlanmış rezervasyonlar)
-- ============================================

-- Sefer 1 ödemeleri
(1, 1, 3, 1, 50.00, 5.00, 45.00, 'Cüzdan', 'Ödendi', '2025-10-15 17:30:00', '2025-10-15 17:30:00', 'https://invoices.uniring.com/inv_001.pdf'),
(2, 1, 4, 1, 50.00, 5.00, 45.00, 'Cüzdan', 'Ödendi', '2025-10-15 17:30:00', '2025-10-15 17:30:00', 'https://invoices.uniring.com/inv_002.pdf'),

-- Sefer 2 ödemeleri
(3, 2, 18, 16, 45.00, 4.50, 40.50, 'Cüzdan', 'Ödendi', '2025-10-18 16:00:00', '2025-10-18 16:00:00', 'https://invoices.uniring.com/inv_003.pdf'),
(4, 2, 19, 16, 40.00, 4.00, 36.00, 'Kredi Kartı', 'Ödendi', '2025-10-18 16:00:00', '2025-10-18 16:05:00', 'https://invoices.uniring.com/inv_004.pdf'),
(5, 2, 20, 16, 45.00, 4.50, 40.50, 'Cüzdan', 'Ödendi', '2025-10-18 16:00:00', '2025-10-18 16:00:00', 'https://invoices.uniring.com/inv_005.pdf'),

-- Sefer 3 ödemeleri
(6, 3, 35, 31, 60.00, 6.00, 54.00, 'Cüzdan', 'Ödendi', '2025-10-20 14:00:00', '2025-10-20 14:00:00', 'https://invoices.uniring.com/inv_006.pdf'),
(7, 3, 37, 31, 50.00, 5.00, 45.00, 'Cüzdan', 'Ödendi', '2025-10-20 14:00:00', '2025-10-20 14:00:00', 'https://invoices.uniring.com/inv_007.pdf'),

-- Sefer 4 ödemeleri
(8, 4, 5, 2, 40.00, 4.00, 36.00, 'Cüzdan', 'Ödendi', '2025-10-22 18:00:00', '2025-10-22 18:00:00', 'https://invoices.uniring.com/inv_008.pdf'),

-- Sefer 5 ödemeleri
(9, 5, 55, 53, 70.00, 7.00, 63.00, 'Kredi Kartı', 'Ödendi', '2025-10-25 19:00:00', '2025-10-25 19:05:00', 'https://invoices.uniring.com/inv_009.pdf'),
(10, 5, 57, 53, 70.00, 7.00, 63.00, 'Cüzdan', 'Ödendi', '2025-10-25 19:00:00', '2025-10-25 19:00:00', 'https://invoices.uniring.com/inv_010.pdf'),

-- Sefer 6 ödemeleri
(11, 6, 20, 17, 55.00, 5.50, 49.50, 'Cüzdan', 'Ödendi', '2025-10-28 17:30:00', '2025-10-28 17:30:00', 'https://invoices.uniring.com/inv_011.pdf'),
(12, 6, 23, 17, 50.00, 5.00, 45.00, 'Cüzdan', 'Ödendi', '2025-10-28 17:30:00', '2025-10-28 17:30:00', 'https://invoices.uniring.com/inv_012.pdf'),
(13, 6, 25, 17, 55.00, 5.50, 49.50, 'Kredi Kartı', 'Ödendi', '2025-10-28 17:30:00', '2025-10-28 17:35:00', 'https://invoices.uniring.com/inv_013.pdf'),

-- Sefer 7 ödemeleri
(14, 7, 45, 43, 45.00, 4.50, 40.50, 'Cüzdan', 'Ödendi', '2025-11-01 16:00:00', '2025-11-01 16:00:00', 'https://invoices.uniring.com/inv_014.pdf'),

-- Sefer 8 ödemeleri
(15, 8, 67, 65, 50.00, 5.00, 45.00, 'Cüzdan', 'Ödendi', '2025-11-03 18:30:00', '2025-11-03 18:30:00', 'https://invoices.uniring.com/inv_015.pdf'),
(16, 8, 69, 65, 50.00, 5.00, 45.00, 'Cüzdan', 'Ödendi', '2025-11-03 18:30:00', '2025-11-03 18:30:00', 'https://invoices.uniring.com/inv_016.pdf'),

-- Sefer 9 ödemeleri
(17, 9, 7, 5, 40.00, 4.00, 36.00, 'Cüzdan', 'Ödendi', '2025-11-05 15:00:00', '2025-11-05 15:00:00', 'https://invoices.uniring.com/inv_017.pdf'),
(18, 9, 9, 5, 40.00, 4.00, 36.00, 'Cüzdan', 'Ödendi', '2025-11-05 15:00:00', '2025-11-05 15:00:00', 'https://invoices.uniring.com/inv_018.pdf'),

-- Sefer 10 ödemeleri
(19, 10, 77, 75, 80.00, 8.00, 72.00, 'Kredi Kartı', 'Ödendi', '2025-11-07 17:00:00', '2025-11-07 17:05:00', 'https://invoices.uniring.com/inv_019.pdf'),
(20, 10, 79, 75, 70.00, 7.00, 63.00, 'Cüzdan', 'Ödendi', '2025-11-07 17:00:00', '2025-11-07 17:00:00', 'https://invoices.uniring.com/inv_020.pdf'),
(21, 10, 81, 75, 80.00, 8.00, 72.00, 'Cüzdan', 'Ödendi', '2025-11-07 17:00:00', '2025-11-07 17:00:00', 'https://invoices.uniring.com/inv_021.pdf'),

-- Sefer 11 ödemeleri
(22, 11, 23, 20, 50.00, 5.00, 45.00, 'Cüzdan', 'Ödendi', '2025-11-08 16:30:00', '2025-11-08 16:30:00', 'https://invoices.uniring.com/inv_022.pdf'),
(23, 11, 25, 20, 50.00, 5.00, 45.00, 'Cüzdan', 'Ödendi', '2025-11-08 16:30:00', '2025-11-08 16:30:00', 'https://invoices.uniring.com/inv_023.pdf'),

-- Sefer 12 ödemeleri
(24, 12, 35, 32, 45.00, 4.50, 40.50, 'Cüzdan', 'Ödendi', '2025-11-10 14:00:00', '2025-11-10 14:00:00', 'https://invoices.uniring.com/inv_024.pdf'),

-- Sefer 13 ödemeleri (Ortak Araç)
(25, 13, 85, 83, 30.00, 3.00, 27.00, 'Nakit', 'Ödendi', '2025-11-12 18:00:00', '2025-11-12 18:40:00', NULL),
(26, 13, 87, 83, 30.00, 3.00, 27.00, 'Nakit', 'Ödendi', '2025-11-12 18:00:00', '2025-11-12 18:40:00', NULL),
(27, 13, 88, 83, 25.00, 2.50, 22.50, 'Nakit', 'Ödendi', '2025-11-12 18:00:00', '2025-11-12 18:40:00', NULL),

-- Sefer 14 ödemeleri
(28, 14, 9, 7, 50.00, 5.00, 45.00, 'Cüzdan', 'Ödendi', '2025-11-14 17:00:00', '2025-11-14 17:00:00', 'https://invoices.uniring.com/inv_028.pdf'),
(29, 14, 11, 7, 50.00, 5.00, 45.00, 'Cüzdan', 'Ödendi', '2025-11-14 17:00:00', '2025-11-14 17:00:00', 'https://invoices.uniring.com/inv_029.pdf'),
(30, 14, 13, 7, 50.00, 5.00, 45.00, 'Kredi Kartı', 'Ödendi', '2025-11-14 17:00:00', '2025-11-14 17:05:00', 'https://invoices.uniring.com/inv_030.pdf'),

-- Sefer 15 ödemeleri
(31, 15, 57, 55, 65.00, 6.50, 58.50, 'Cüzdan', 'Ödendi', '2025-11-15 16:00:00', '2025-11-15 16:00:00', 'https://invoices.uniring.com/inv_031.pdf'),
(32, 15, 59, 55, 65.00, 6.50, 58.50, 'Cüzdan', 'Ödendi', '2025-11-15 16:00:00', '2025-11-15 16:00:00', 'https://invoices.uniring.com/inv_032.pdf'),

-- Sefer 16 ödemeleri
(33, 16, 31, 23, 40.00, 4.00, 36.00, 'Cüzdan', 'Ödendi', '2025-11-17 15:00:00', '2025-11-17 15:00:00', 'https://invoices.uniring.com/inv_033.pdf'),
(34, 16, 35, 23, 35.00, 3.50, 31.50, 'Cüzdan', 'Ödendi', '2025-11-17 15:00:00', '2025-11-17 15:00:00', 'https://invoices.uniring.com/inv_034.pdf'),

-- Sefer 17 ödemeleri
(35, 17, 47, 45, 35.00, 3.50, 31.50, 'Cüzdan', 'Ödendi', '2025-11-18 18:30:00', '2025-11-18 18:30:00', 'https://invoices.uniring.com/inv_035.pdf'),

-- Sefer 18 ödemeleri
(36, 18, 69, 67, 55.00, 5.50, 49.50, 'Cüzdan', 'Ödendi', '2025-11-19 17:00:00', '2025-11-19 17:00:00', 'https://invoices.uniring.com/inv_036.pdf'),
(37, 18, 71, 67, 55.00, 5.50, 49.50, 'Kredi Kartı', 'Ödendi', '2025-11-19 17:00:00', '2025-11-19 17:05:00', 'https://invoices.uniring.com/inv_037.pdf'),

-- Sefer 19 ödemeleri
(38, 19, 11, 9, 55.00, 5.50, 49.50, 'Cüzdan', 'Ödendi', '2025-11-20 16:30:00', '2025-11-20 16:30:00', 'https://invoices.uniring.com/inv_038.pdf'),
(39, 19, 13, 9, 55.00, 5.50, 49.50, 'Cüzdan', 'Ödendi', '2025-11-20 16:30:00', '2025-11-20 16:30:00', 'https://invoices.uniring.com/inv_039.pdf'),
(40, 19, 15, 9, 50.00, 5.00, 45.00, 'Cüzdan', 'Ödendi', '2025-11-20 16:30:00', '2025-11-20 16:30:00', 'https://invoices.uniring.com/inv_040.pdf'),

-- Sefer 20 ödemeleri
(41, 20, 16, 35, 40.00, 4.00, 36.00, 'Cüzdan', 'Ödendi', '2025-11-21 14:00:00', '2025-11-21 14:00:00', 'https://invoices.uniring.com/inv_041.pdf'),
(42, 20, 18, 35, 40.00, 4.00, 36.00, 'Cüzdan', 'Ödendi', '2025-11-21 14:00:00', '2025-11-21 14:00:00', 'https://invoices.uniring.com/inv_042.pdf'),

-- Sefer 21 ödemeleri
(43, 21, 79, 77, 50.00, 5.00, 45.00, 'Kredi Kartı', 'Ödendi', '2025-11-22 18:00:00', '2025-11-22 18:05:00', 'https://invoices.uniring.com/inv_043.pdf'),
(44, 21, 81, 77, 50.00, 5.00, 45.00, 'Cüzdan', 'Ödendi', '2025-11-22 18:00:00', '2025-11-22 18:00:00', 'https://invoices.uniring.com/inv_044.pdf'),

-- Sefer 22 ödemeleri
(45, 22, 27, 25, 50.00, 5.00, 45.00, 'Cüzdan', 'Ödendi', '2025-11-23 15:00:00', '2025-11-23 15:00:00', 'https://invoices.uniring.com/inv_045.pdf'),
(46, 22, 29, 25, 50.00, 5.00, 45.00, 'Cüzdan', 'Ödendi', '2025-11-23 15:00:00', '2025-11-23 15:00:00', 'https://invoices.uniring.com/inv_046.pdf'),
(47, 22, 30, 25, 45.00, 4.50, 40.50, 'Cüzdan', 'Ödendi', '2025-11-23 15:00:00', '2025-11-23 15:00:00', 'https://invoices.uniring.com/inv_047.pdf'),

-- Sefer 23 ödemeleri
(48, 23, 59, 57, 60.00, 6.00, 54.00, 'Cüzdan', 'Ödendi', '2025-11-24 19:00:00', '2025-11-24 19:00:00', 'https://invoices.uniring.com/inv_048.pdf'),
(49, 23, 61, 57, 60.00, 6.00, 54.00, 'Cüzdan', 'Ödendi', '2025-11-24 19:00:00', '2025-11-24 19:00:00', 'https://invoices.uniring.com/inv_049.pdf'),

-- Sefer 24 ödemeleri
(50, 24, 49, 47, 60.00, 6.00, 54.00, 'Cüzdan', 'Ödendi', '2025-11-25 17:30:00', '2025-11-25 17:30:00', 'https://invoices.uniring.com/inv_050.pdf'),
(51, 24, 51, 47, 60.00, 6.00, 54.00, 'Kredi Kartı', 'Ödendi', '2025-11-25 17:30:00', '2025-11-25 17:35:00', 'https://invoices.uniring.com/inv_051.pdf'),

-- Sefer 25 ödemeleri
(52, 25, 71, 69, 55.00, 5.50, 49.50, 'Cüzdan', 'Ödendi', '2025-11-26 16:00:00', '2025-11-26 16:00:00', 'https://invoices.uniring.com/inv_052.pdf'),

-- ============================================
-- ÖDENMEDİ (10 adet - Yeni onaylanmış rezervasyonlar)
-- ============================================

-- Sefer 26 ödemeleri (Yarın - henüz ödenmedi)
(53, 26, 3, 11, 50.00, 5.00, 45.00, 'Cüzdan', 'Ödenmedi', '2025-11-30 13:00:00', NULL, NULL),
(54, 26, 5, 11, 50.00, 5.00, 45.00, 'Cüzdan', 'Ödenmedi', '2025-11-30 15:00:00', NULL, NULL),

-- Sefer 27 ödemeleri (Yarın)
(55, 27, 20, 27, 55.00, 5.50, 49.50, 'Cüzdan', 'Ödenmedi', '2025-11-30 17:00:00', NULL, NULL),

-- Sefer 29 ödemeleri
(56, 29, 55, 59, 70.00, 7.00, 63.00, 'Kredi Kartı', 'Ödenmedi', '2025-12-01 14:00:00', NULL, NULL),

-- Sefer 32 ödemeleri
(57, 32, 45, 49, 40.00, 4.00, 36.00, 'Cüzdan', 'Ödenmedi', '2025-12-01 19:00:00', NULL, NULL),

-- Sefer 35 ödemeleri
(58, 35, 16, 39, 35.00, 3.50, 31.50, 'Cüzdan', 'Ödenmedi', '2025-12-01 17:00:00', NULL, NULL),

-- Sefer 39 ödemeleri (Ortak Araç)
(59, 39, 67, 65, 35.00, 3.50, 31.50, 'Nakit', 'Ödenmedi', '2025-12-01 18:00:00', NULL, NULL),
(60, 39, 69, 65, 35.00, 3.50, 31.50, 'Nakit', 'Ödenmedi', '2025-12-01 19:00:00', NULL, NULL),

-- Sefer 41 ödemeleri
(61, 41, 3, 1, 55.00, 5.50, 49.50, 'Cüzdan', 'Ödenmedi', '2025-12-01 12:00:00', NULL, NULL);


-- ============================================
-- UNIRING - TEST VERİSİ: YORUMLAR
-- ADIM 9/10 - Kullanıcı değerlendirmeleri
-- ============================================

-- Yorum dağılımı:
-- 40 yorum (tamamlanmış rezervasyonlar için çift yönlü değerlendirmeler)
-- Yolcu → Organizatör yorumları
-- Organizatör → Yolcu yorumları

INSERT INTO Yorumlar (rezervasyonID, degerlendirenKullaniciID, degerlendirilenKullaniciID, seferID, puan, yorum, kategoriler, yorumTarihi, gorunurluk) VALUES

-- ============================================
-- SEFER 1 YORUMLARI
-- ============================================
-- Yolcu 3 → Organizatör 1
(1, 3, 1, 1, 5, 'Çok keyifli bir yolculuktu, Ahmet çok dakik ve güler yüzlü. Arabası temizdi.', '{"zamaninda": 5, "temizlik": 5, "iletisim": 5}', '2025-10-15 19:00:00', 'Genel'),
-- Organizatör 1 → Yolcu 3
(1, 1, 3, 1, 5, 'Mehmet çok kibar ve saygılı bir yolcuydu. Tekrar yolculuk yapmak isterim.', '{"saygi": 5, "zamaninda": 5}', '2025-10-15 19:30:00', 'Genel'),

-- Yolcu 4 → Organizatör 1
(2, 4, 1, 1, 4, 'İyi bir yolculuktu, klima biraz zayıftı ama genel olarak memnunum.', '{"zamaninda": 5, "temizlik": 4, "iletisim": 4}', '2025-10-15 19:15:00', 'Genel'),
-- Organizatör 1 → Yolcu 4
(2, 1, 4, 1, 5, 'Zeynep çok nazik, önerdiği müzikler çok güzeldi. Teşekkürler!', '{"saygi": 5, "zamaninda": 5}', '2025-10-15 19:45:00', 'Genel'),

-- ============================================
-- SEFER 2 YORUMLARI
-- ============================================
-- Yolcu 18 → Organizatör 16
(3, 18, 16, 2, 5, 'Ali bey çok profesyonel, güvenli sürüş yapıyor. Kesinlikle tavsiye ederim.', '{"zamaninda": 5, "guvenli_surus": 5, "iletisim": 5}', '2025-10-18 17:30:00', 'Genel'),
-- Organizatör 16 → Yolcu 18
(3, 16, 18, 2, 5, 'Barış çok konuşkan ve eğlenceli bir arkadaş, yol çok çabuk geçti.', '{"saygi": 5, "zamaninda": 5}', '2025-10-18 18:00:00', 'Genel'),

-- Yolcu 19 → Organizatör 16
(4, 19, 16, 2, 4, 'Güzel bir deneyimdi, sadece biraz geç kaldık ama sorun değil.', '{"zamaninda": 3, "temizlik": 5, "iletisim": 4}', '2025-10-18 17:45:00', 'Genel'),
-- Organizatör 16 → Yolcu 19
(4, 16, 19, 2, 4, 'Ezgi hanım sessizce yolculuk etti, saygılıydı.', '{"saygi": 5, "zamaninda": 4}', '2025-10-18 18:15:00', 'Genel'),

-- Yolcu 20 → Organizatör 16
(5, 20, 16, 2, 5, 'Harika bir yolculuk! Ali bey çok yardımсever ve güvenilir.', '{"zamaninda": 5, "guvenli_surus": 5, "iletisim": 5}', '2025-10-18 18:00:00', 'Genel'),
-- Organizatör 16 → Yolcu 20
(5, 16, 20, 2, 5, 'Murat çok kibar ve zamanında hazırdı. Süper yolcu!', '{"saygi": 5, "zamaninda": 5}', '2025-10-18 18:30:00', 'Genel'),

-- ============================================
-- SEFER 5 YORUMLARI
-- ============================================
-- Yolcu 55 → Organizatör 53
(9, 55, 53, 5, 5, 'Taylan abi çok tecrübeli bir sürücü, kendimi çok güvende hissettim.', '{"zamaninda": 5, "guvenli_surus": 5, "temizlik": 5}', '2025-10-25 20:00:00', 'Genel'),
-- Organizatör 53 → Yolcu 55
(9, 53, 55, 5, 5, 'Doruk çok düzgün bir genç, araba kullanma konusunda tavsiyelerde bulundu.', '{"saygi": 5, "zamaninda": 5}', '2025-10-25 20:30:00', 'Genel'),

-- Yolcu 57 → Organizatör 53
(10, 57, 53, 5, 4, 'İyi bir yolculuktu, sadece müzik sesi biraz yüksekti.', '{"zamaninda": 5, "temizlik": 4, "iletisim": 4}', '2025-10-25 20:15:00', 'Genel'),
-- Organizatör 53 → Yolcu 57
(10, 53, 57, 5, 4, 'Kıvanç sessiz yolculuk etti, müziği kapatmamı istedi.', '{"saygi": 4, "zamaninda": 5}', '2025-10-25 20:45:00', 'Genel'),

-- ============================================
-- SEFER 6 YORUMLARI
-- ============================================
-- Yolcu 20 → Organizatör 17
(11, 20, 17, 6, 5, 'Merve abla çok nazik ve yardımsever, çok teşekkür ederim!', '{"zamaninda": 5, "temizlik": 5, "iletisim": 5}', '2025-10-28 19:00:00', 'Genel'),
-- Organizatör 17 → Yolcu 20
(11, 17, 20, 6, 5, 'Murat çok kibar ve saygılı, bagajına dikkat etti.', '{"saygi": 5, "zamaninda": 5}', '2025-10-28 19:30:00', 'Genel'),

-- Yolcu 23 → Organizatör 17
(12, 23, 17, 6, 5, 'Harika bir deneyim! Merve hanım çok güvenli sürüyor.', '{"zamaninda": 5, "guvenli_surus": 5, "iletisim": 5}', '2025-10-28 19:15:00', 'Genel'),
-- Organizatör 17 → Yolcu 23
(12, 17, 23, 6, 5, 'Ceren çok eğlenceli, yolculuk çok keyifli geçti.', '{"saygi": 5, "zamaninda": 5}', '2025-10-28 19:45:00', 'Genel'),

-- Yolcu 25 → Organizatör 17
(13, 25, 17, 6, 4, 'Güzel bir yolculuk, sadece trafik biraz yoğundu.', '{"zamaninda": 4, "temizlik": 5, "iletisim": 4}', '2025-10-28 19:30:00', 'Genel'),
-- Organizatör 17 → Yolcu 25
(13, 17, 25, 6, 5, 'Kerem çok düzgün ve zamanında hazırdı.', '{"saygi": 5, "zamaninda": 5}', '2025-10-28 20:00:00', 'Genel'),

-- ============================================
-- SEFER 10 YORUMLARI
-- ============================================
-- Yolcu 77 → Organizatör 75
(19, 77, 75, 10, 5, 'Boranın arabası çok konforlu, yolculuk mükemmeldi!', '{"zamaninda": 5, "temizlik": 5, "guvenli_surus": 5}', '2025-11-07 18:30:00', 'Genel'),
-- Organizatör 75 → Yolcu 77
(19, 75, 77, 10, 5, 'Alp çok kibar ve saygılı bir arkadaş. Teşekkürler!', '{"saygi": 5, "zamaninda": 5}', '2025-11-07 19:00:00', 'Genel'),

-- Yolcu 79 → Organizatör 75
(20, 79, 75, 10, 5, 'Çok güzel bir sohbet ettik, Bora çok cana yakın biri.', '{"zamaninda": 5, "iletisim": 5}', '2025-11-07 18:45:00', 'Genel'),
-- Organizatör 75 → Yolcu 79
(20, 75, 79, 10, 5, 'Barış çok eğlenceli, yol hiç sıkıcı geçmedi.', '{"saygi": 5, "zamaninda": 5}', '2025-11-07 19:15:00', 'Genel'),

-- Yolcu 81 → Organizatör 75
(21, 81, 75, 10, 4, 'Güzel bir deneyimdi, müzik seçimi harikaydı!', '{"zamaninda": 5, "temizlik": 4, "iletisim": 5}', '2025-11-07 19:00:00', 'Genel'),
-- Organizatör 75 → Yolcu 81
(21, 75, 81, 10, 5, 'Koray çok sessiz ve saygılıydı, süper yolcu.', '{"saygi": 5, "zamaninda": 5}', '2025-11-07 19:30:00', 'Genel'),

-- ============================================
-- SEFER 14 YORUMLARI
-- ============================================
-- Yolcu 9 → Organizatör 7
(28, 9, 7, 14, 5, 'Burak abi çok güvenilir ve dakik, kesinlikle tavsiye ederim.', '{"zamaninda": 5, "guvenli_surus": 5, "iletisim": 5}', '2025-11-14 18:00:00', 'Genel'),
-- Organizatör 7 → Yolcu 9
(28, 7, 9, 14, 5, 'Emre çok düzgün bir genç, yolculuk çok keyifli geçti.', '{"saygi": 5, "zamaninda": 5}', '2025-11-14 18:30:00', 'Genel'),

-- Yolcu 11 → Organizatör 7
(29, 11, 7, 14, 5, 'Harika bir deneyim! Burak bey çok profesyonel.', '{"zamaninda": 5, "temizlik": 5, "guvenli_surus": 5}', '2025-11-14 18:15:00', 'Genel'),
-- Organizatör 7 → Yolcu 11
(29, 7, 11, 14, 5, 'Cem çok konuşkan ve eğlenceli, yol çok çabuk geçti.', '{"saygi": 5, "zamaninda": 5}', '2025-11-14 18:45:00', 'Genel'),

-- Yolcu 13 → Organizatör 7
(30, 13, 7, 14, 4, 'İyi bir yolculuktu, sadece biraz geç vardık.', '{"zamaninda": 3, "temizlik": 5, "iletisim": 4}', '2025-11-14 18:30:00', 'Genel'),
-- Organizatör 7 → Yolcu 13
(30, 7, 13, 14, 4, 'Kaan sessizce yolculuk etti, saygılıydı.', '{"saygi": 5, "zamaninda": 4}', '2025-11-14 19:00:00', 'Genel'),

-- ============================================
-- SEFER 19 YORUMLARI
-- ============================================
-- Yolcu 11 → Organizatör 9
(38, 11, 9, 19, 5, 'Emre abi çok güler yüzlü, arabası çok temizdi.', '{"zamaninda": 5, "temizlik": 5, "iletisim": 5}', '2025-11-20 18:00:00', 'Genel'),
-- Organizatör 9 → Yolcu 11
(38, 9, 11, 19, 5, 'Cem çok kibar ve zamanındaydı. Süper yolcu!', '{"saygi": 5, "zamaninda": 5}', '2025-11-20 18:30:00', 'Genel'),

-- Yolcu 13 → Organizatör 9
(39, 13, 9, 19, 5, 'Mükemmel bir yolculuk! Emre bey çok güvenli sürüyor.', '{"zamaninda": 5, "guvenli_surus": 5, "iletisim": 5}', '2025-11-20 18:15:00', 'Genel'),
-- Organizatör 9 → Yolcu 13
(39, 9, 13, 19, 5, 'Kaan çok eğlenceli, müzik zevki harika.', '{"saygi": 5, "zamaninda": 5}', '2025-11-20 18:45:00', 'Genel'),

-- Yolcu 15 → Organizatör 9
(40, 15, 9, 19, 5, 'Çok güzel bir deneyim, teşekkürler Emre abi!', '{"zamaninda": 5, "temizlik": 5, "iletisim": 5}', '2025-11-20 18:30:00', 'Genel'),
-- Organizatör 9 → Yolcu 15
(40, 9, 15, 19, 5, 'Onur çok sessiz ve saygılı bir yolcuydu.', '{"saygi": 5, "zamaninda": 5}', '2025-11-20 19:00:00', 'Genel'),

-- ============================================
-- DİĞER SEFER YORUMLARI (Daha kısa)
-- ============================================

-- Sefer 22
(45, 27, 25, 22, 4, 'Güzel bir yolculuktu, AVM çok kalabalıktı ama.', '{"zamaninda": 4, "iletisim": 4}', '2025-11-23 16:30:00', 'Genel'),
(45, 25, 27, 22, 5, 'Oğuz çok düzgün bir arkadaş, teşekkürler.', '{"saygi": 5, "zamaninda": 5}', '2025-11-23 17:00:00', 'Genel'),

(46, 29, 25, 22, 5, 'Serkan abi çok güvenli sürüyor, teşekkürler!', '{"guvenli_surus": 5, "zamaninda": 5}', '2025-11-23 16:45:00', 'Genel'),
(46, 25, 29, 22, 5, 'Serkan çok kibar, bagajına yardım etti.', '{"saygi": 5, "zamaninda": 5}', '2025-11-23 17:15:00', 'Genel');


-- ============================================
-- UNIRING - TEST VERİSİ: MESAJLAR
-- ADIM 10/10 - Sefer bazlı mesajlaşma
-- ============================================

-- Mesaj dağılımı:
-- Tamamlanmış seferler için geçmiş mesajlar
-- Aktif seferler için güncel mesajlar
-- Organizatör ve yolcular arası iletişim

INSERT INTO Mesajlar (seferID, gonderenID, mesajMetni, gonderimZamani, okunduMu, mesajTipi, dosyaURL) VALUES

-- ============================================
-- SEFER 1 MESAJLARI (TOBB -> Kızılay)
-- ============================================
(1, 3, 'Selam Ahmet abi, tam ana kapıda bekliyorum.', '2025-10-15 17:25:00', TRUE, 'Metin', NULL),
(1, 1, 'Tamam Mehmet, 2 dakikaya oradayım. Beyaz Fiat Egea.', '2025-10-15 17:26:00', TRUE, 'Metin', NULL),
(1, 4, 'Ben de katıldım, Bahçelievlerde iniyorum.', '2025-10-15 17:27:00', TRUE, 'Metin', NULL),
(1, 1, 'Süper, herkesi aldım yola çıkıyoruz. İyi yolculuklar!', '2025-10-15 17:31:00', TRUE, 'Metin', NULL),

-- ============================================
-- SEFER 2 MESAJLARI (ODTÜ -> Tunalı)
-- ============================================
(2, 18, 'Ali bey, A1 kapısında mısınız?', '2025-10-18 15:55:00', TRUE, 'Metin', NULL),
(2, 16, 'Evet Barış, yoldayım 5 dakikaya oradayım.', '2025-10-18 15:56:00', TRUE, 'Metin', NULL),
(2, 19, 'Ben de hazırım, bekledeyim.', '2025-10-18 15:57:00', TRUE, 'Metin', NULL),
(2, 20, 'Konum atabilir misiniz tam neredesiniz?', '2025-10-18 15:58:00', TRUE, 'Metin', NULL),
(2, 16, 'Şimdi A1 önündeyim, kırmızı Clio.', '2025-10-18 15:59:00', TRUE, 'Konum', NULL),
(2, 16, 'Herkesi aldım, yola çıkıyoruz!', '2025-10-18 16:02:00', TRUE, 'Metin', NULL),

-- ============================================
-- SEFER 5 MESAJLARI (Boğaziçi -> Taksim)
-- ============================================
(5, 55, 'Taylan abi, Bebek kampüsü hangi kapıda bekliyim?', '2025-10-25 18:50:00', TRUE, 'Metin', NULL),
(5, 53, 'Ana giriş Doruk, siyah BMW geliyorum.', '2025-10-25 18:52:00', TRUE, 'Metin', NULL),
(5, 57, 'Ben de katılacağım, müsait mi?', '2025-10-25 18:53:00', TRUE, 'Metin', NULL),
(5, 53, 'Tabii Kıvanç, seni de alıyoruz.', '2025-10-25 18:54:00', TRUE, 'Metin', NULL),
(5, 53, 'Geldim kampüs önündeyim, görebiliyor musunuz?', '2025-10-25 18:58:00', TRUE, 'Metin', NULL),
(5, 55, 'Görüyoruz, geliyoruz.', '2025-10-25 18:59:00', TRUE, 'Metin', NULL),

-- ============================================
-- SEFER 6 MESAJLARI (ODTÜ -> Kızılay)
-- ============================================
(6, 20, 'Merve abla, kaçta çıkıyorsunuz?', '2025-10-28 17:15:00', TRUE, 'Metin', NULL),
(6, 17, 'Murat, 17:30\'da A1\'den hareket ediyoruz.', '2025-10-28 17:16:00', TRUE, 'Metin', NULL),
(6, 23, 'Süper, ben de hazırım!', '2025-10-28 17:17:00', TRUE, 'Metin', NULL),
(6, 25, 'Biraz geç kalabilirim, beni bekler misiniz?', '2025-10-28 17:20:00', TRUE, 'Metin', NULL),
(6, 17, 'Kerem, 5 dakika bekleyebiliriz ama çok geç kalma lütfen.', '2025-10-28 17:21:00', TRUE, 'Metin', NULL),
(6, 25, 'Tamam hemen yetişiyorum, teşekkürler!', '2025-10-28 17:22:00', TRUE, 'Metin', NULL),
(6, 17, 'Herkesi aldık, hareket ediyoruz. Trafik az bugün.', '2025-10-28 17:32:00', TRUE, 'Metin', NULL),

-- ============================================
-- SEFER 10 MESAJLARI (Koç -> Şişli)
-- ============================================
(10, 77, 'Bora, hangi arabayla geliyorsun?', '2025-11-07 16:45:00', TRUE, 'Metin', NULL),
(10, 75, 'Alp, beyaz BMW X3. Kampüs önünde olacağım.', '2025-11-07 16:46:00', TRUE, 'Metin', NULL),
(10, 79, 'Ben de katıldım arkadaşlar, müzik açar mısınız?', '2025-11-07 16:48:00', TRUE, 'Metin', NULL),
(10, 75, 'Tabii Barış, ne tarz seversin?', '2025-11-07 16:49:00', TRUE, 'Metin', NULL),
(10, 79, 'Rock/Alternative olabilir mi?', '2025-11-07 16:50:00', TRUE, 'Metin', NULL),
(10, 81, 'Bana da uyar, harika seçim!', '2025-11-07 16:51:00', TRUE, 'Metin', NULL),
(10, 75, 'Geldim kampüs önündeyim, hazır mısınız?', '2025-10-07 16:58:00', TRUE, 'Metin', NULL),
(10, 77, 'Geliyoruz!', '2025-11-07 16:59:00', TRUE, 'Metin', NULL),

-- ============================================
-- SEFER 14 MESAJLARI (TOBB -> Kavaklıdere)
-- ============================================
(14, 9, 'Burak abi, bagaj alanı var mı? Alışveriş torbalarım var.', '2025-11-14 16:45:00', TRUE, 'Metin', NULL),
(14, 7, 'Emre, evet var merak etme. Bol yer var.', '2025-11-14 16:46:00', TRUE, 'Metin', NULL),
(14, 11, 'Ben de Kavaklıderede iniyorum, aynı yerde mi inelim?', '2025-11-14 16:47:00', TRUE, 'Metin', NULL),
(14, 13, 'Bence hep beraber alalım, daha kolay olur.', '2025-11-14 16:48:00', TRUE, 'Metin', NULL),
(14, 7, 'Tamam çocuklar, herkes hazırsa çıkalım.', '2025-11-14 16:55:00', TRUE, 'Metin', NULL),

-- ============================================
-- SEFER 19 MESAJLARI (TOBB -> Tunalı)
-- ============================================
(19, 11, 'Emre abi, hava soğuk klima açar mısınız?', '2025-11-20 16:25:00', TRUE, 'Metin', NULL),
(19, 9, 'Tabii Cem, açıyorum hemen.', '2025-11-20 16:26:00', TRUE, 'Metin', NULL),
(19, 13, 'Teşekkürler! Tunalıda nerede ineceğiz?', '2025-11-20 16:27:00', TRUE, 'Metin', NULL),
(19, 9, 'Meydanın başında ineriz, herkese uygun mudur?', '2025-11-20 16:28:00', TRUE, 'Metin', NULL),
(19, 15, 'Bana uyar, teşekkürler.', '2025-11-20 16:29:00', TRUE, 'Metin', NULL),
(19, 11, 'Süper, herkese kolay gelsin!', '2025-11-20 16:35:00', TRUE, 'Metin', NULL),

-- ============================================
-- AKTİF SEFER MESAJLARI (Gelecek seferler)
-- ============================================

-- SEFER 26 MESAJLARI (Yarın - TOBB -> Kızılay)
(26, 3, 'Ahmet abi yarın yine mi gidiyorsunuz Kızılaya?', '2025-11-30 14:00:00', TRUE, 'Metin', NULL),
(26, 11, 'Evet Mehmet, her zamanki saatte. Sen de gelecek misin?', '2025-11-30 14:05:00', TRUE, 'Metin', NULL),
(26, 3, 'Evet katılıyorum, rezervasyon yaptım.', '2025-11-30 14:10:00', TRUE, 'Metin', NULL),
(26, 5, 'Ben de katıldım arkadaşlar!', '2025-11-30 16:00:00', TRUE, 'Metin', NULL),
(26, 11, 'Harika, yarın görüşürüz o zaman!', '2025-11-30 16:30:00', FALSE, 'Metin', NULL),

-- SEFER 27 MESAJLARI (Yarın - ODTÜ -> Çayyolu)
(27, 20, 'Oğuz abi, Parkoraya mı gidiyoruz?', '2025-11-30 18:00:00', TRUE, 'Metin', NULL),
(27, 27, 'Evet Murat, alışveriş yapacağım.', '2025-11-30 18:05:00', TRUE, 'Metin', NULL),
(27, 20, 'Süper, ben de oradayım yarın.', '2025-11-30 18:10:00', FALSE, 'Metin', NULL),

-- SEFER 29 MESAJLARI (2 gün sonra - Boğaziçi -> Taksim)
(29, 55, 'Kıvanç abi, akşam Taksime gidiyoruz değil mi?', '2025-12-01 15:00:00', TRUE, 'Metin', NULL),
(29, 59, 'Evet Doruk, 18:00 de hareket.', '2025-12-01 15:30:00', FALSE, 'Metin', NULL),
(29, 55, 'Tamam, hazır olacağım!', '2025-12-01 16:00:00', FALSE, 'Metin', NULL),

-- SEFER 35 MESAJLARI (5 gün sonra - Bilkent -> ODTÜ)
(35, 16, 'Alp abi, ODTÜ de konferans var mı?', '2025-12-01 18:00:00', FALSE, 'Metin', NULL),
(35, 39, 'Evet Barış, yapay zeka konferansı.', '2025-12-01 18:30:00', FALSE, 'Metin', NULL),
(35, 16, 'Harika, ben de ilgileniyorum!', '2025-12-01 19:00:00', FALSE, 'Metin', NULL),

-- SEFER 41 MESAJLARI (9 gün sonra - TOBB -> Kavaklıdere)
(41, 3, 'Ahmet abi, Kavaklıderede nerede inelim?', '2025-12-01 14:00:00', FALSE, 'Metin', NULL),
(41, 1, 'Mehmet, meydanda uygun mu?', '2025-12-01 14:30:00', FALSE, 'Metin', NULL),
(41, 3, 'Evet uyar, teşekkürler!', '2025-12-01 15:00:00', FALSE, 'Metin', NULL);


