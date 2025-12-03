-- UNIRING - Database Views
-- 6 Complex Views

-- VIEW 1: Aktif Seferler Özeti
-- Aktif ve planlanmış tüm seferlerin detaylı bilgilerini gösterir
CREATE OR REPLACE VIEW AktifSeferlerView AS
SELECT 
    s.seferID,
    s.seferTipi,
    s.katilimKapsami,
    s.seferTarihi,
    s.kalkisZamani,
    s.tahminiVarisZamani,
    s.maxKapasite,
    s.mevcutDoluluk,
    (s.maxKapasite - s.mevcutDoluluk) AS kalanKapasite,
    s.temelFiyat,
    s.seferDurumu,
    -- Organizatör bilgileri
    k.kullaniciID AS organizatorID,
    CONCAT(k.ad, ' ', k.soyad) AS organizatorAdSoyad,
    k.guvenlikSkoru AS organizatorGuvenlikSkoru,
    uni.universiteAdi AS organizatorUniversitesi,
    -- Araç bilgileri (varsa)
    a.marka AS aracMarka,
    a.model AS aracModel,
    a.renk AS aracRenk,
    a.plaka AS aracPlaka,
    -- Güzergah bilgileri
    (SELECT konumAdi FROM SeferGuzergahNoktalari WHERE seferID = s.seferID AND siraNo = 1) AS kalkisNoktasi,
    (SELECT konumAdi FROM SeferGuzergahNoktalari WHERE seferID = s.seferID 
     ORDER BY siraNo DESC LIMIT 1) AS varisNoktasi
FROM Seferler s
INNER JOIN Kullanicilar k ON s.olusturanKullaniciID = k.kullaniciID
INNER JOIN Universiteler uni ON k.universiteID = uni.universiteID
LEFT JOIN Araclar a ON s.aracID = a.aracID
WHERE s.seferDurumu IN ('Planlanıyor', 'Aktif')
ORDER BY s.kalkisZamani ASC;

-- VIEW 2: Kullanıcı İstatistikleri
-- Her kullanıcının detaylı aktivite istatistiklerini gösterir
CREATE OR REPLACE VIEW KullaniciIstatistikleriView AS
SELECT 
    k.kullaniciID,
    CONCAT(k.ad, ' ', k.soyad) AS adSoyad,
    k.email,
    uni.universiteAdi,
    k.guvenlikSkoru,
    k.hesapDurumu,
    -- Organizatör olarak
    COUNT(DISTINCT s.seferID) AS organizatorOlarakSeferSayisi,
    COUNT(DISTINCT CASE WHEN s.seferDurumu = 'Tamamlandı' THEN s.seferID END) AS tamamlananSeferSayisi,
    -- Yolcu olarak
    COUNT(DISTINCT r.rezervasyonID) AS yolcuOlarakRezervasyonSayisi,
    COUNT(DISTINCT CASE WHEN r.durum = 'Tamamlandı' THEN r.rezervasyonID END) AS tamamlananRezervasyonSayisi,
    -- Finansal
    COALESCE(c.bakiye, 0) AS cuzdanBakiyesi,
    COALESCE(SUM(CASE WHEN o.alacakliID = k.kullaniciID THEN o.netTutar ELSE 0 END), 0) AS toplamKazanc,
    COALESCE(SUM(CASE WHEN o.borcluID = k.kullaniciID THEN o.tutar ELSE 0 END), 0) AS toplamHarcama,
    -- Değerlendirmeler
    COUNT(DISTINCT y.yorumID) AS alinanYorumSayisi,
    AVG(y.puan) AS ortalamaPuan,
    -- Tarihler
    k.kayitTarihi,
    k.sonGirisTarihi
FROM Kullanicilar k
INNER JOIN Universiteler uni ON k.universiteID = uni.universiteID
LEFT JOIN Seferler s ON k.kullaniciID = s.olusturanKullaniciID
LEFT JOIN Rezervasyonlar r ON k.kullaniciID = r.yolcuID
LEFT JOIN Cuzdanlar c ON k.kullaniciID = c.kullaniciID
LEFT JOIN Odemeler o ON k.kullaniciID = o.alacakliID OR k.kullaniciID = o.borcluID
LEFT JOIN Yorumlar y ON k.kullaniciID = y.degerlendirilenKullaniciID
GROUP BY k.kullaniciID;

-- VIEW 3: Popüler Güzergahlar
-- En çok kullanılan güzergahları gösterir
CREATE OR REPLACE VIEW PopulerGuzergahlarView AS
SELECT 
    kalkis.konumAdi AS kalkisNoktasi,
    varis.konumAdi AS varisNoktasi,
    COUNT(DISTINCT s.seferID) AS seferSayisi,
    COUNT(DISTINCT r.rezervasyonID) AS rezervasyonSayisi,
    AVG(s.temelFiyat) AS ortalamaMaliyet,
    MIN(s.temelFiyat) AS enDusukMaliyet,
    MAX(s.temelFiyat) AS enYuksekMaliyet,
    AVG(TIMESTAMPDIFF(MINUTE, s.kalkisZamani, s.tahminiVarisZamani)) AS ortalamaSureDakika
FROM Seferler s
INNER JOIN SeferGuzergahNoktalari kalkis ON s.seferID = kalkis.seferID AND kalkis.siraNo = 1
INNER JOIN SeferGuzergahNoktalari varis ON s.seferID = varis.seferID 
    AND varis.siraNo = (SELECT MAX(siraNo) FROM SeferGuzergahNoktalari WHERE seferID = s.seferID)
LEFT JOIN Rezervasyonlar r ON s.seferID = r.seferID AND r.durum NOT IN ('Reddedildi', 'İptal Edildi')
WHERE s.seferDurumu IN ('Tamamlandı', 'Aktif', 'Planlanıyor')
GROUP BY kalkis.konumAdi, varis.konumAdi
HAVING seferSayisi >= 2
ORDER BY seferSayisi DESC, rezervasyonSayisi DESC;

-- VIEW 4: Finansal Özet Raporu
-- Platform genelindeki finansal durumu gösterir
CREATE OR REPLACE VIEW FinansalOzetView AS
SELECT 
    DATE_FORMAT(o.islemTarihi, '%Y-%m') AS donem,
    COUNT(DISTINCT o.odemeID) AS toplamIslemSayisi,
    SUM(o.tutar) AS toplamIslemHacmi,
    SUM(o.platformKomisyonu) AS toplamPlatformKomisyonu,
    SUM(o.netTutar) AS toplamNetOdeme,
    AVG(o.tutar) AS ortalamaIslemTutari,
    COUNT(DISTINCT CASE WHEN o.odemeDurumu = 'Ödendi' THEN o.odemeID END) AS tamamlananIslemSayisi,
    COUNT(DISTINCT CASE WHEN o.odemeDurumu = 'Ödenmedi' THEN o.odemeID END) AS bekleyenIslemSayisi,
    COUNT(DISTINCT o.borcluID) AS aktifOdemeYapanKullaniciSayisi,
    COUNT(DISTINCT o.alacakliID) AS aktifGelirEldenKullaniciSayisi
FROM Odemeler o
WHERE o.islemTarihi >= DATE_SUB(CURRENT_DATE, INTERVAL 12 MONTH)
GROUP BY DATE_FORMAT(o.islemTarihi, '%Y-%m')
ORDER BY donem DESC;

-- VIEW 5: Güvenlik ve Değerlendirme Raporu
-- Kullanıcıların güvenlik skorları ve değerlendirmelerini analiz eder
CREATE OR REPLACE VIEW GuvenlikDegerlendirmeView AS
SELECT 
    k.kullaniciID,
    CONCAT(k.ad, ' ', k.soyad) AS kullaniciAdSoyad,
    uni.universiteAdi,
    k.guvenlikSkoru AS sistemGuvenlikSkoru,
    -- Aldığı değerlendirmeler
    COUNT(DISTINCT y.yorumID) AS toplamDegerlendirmeSayisi,
    AVG(y.puan) AS ortalamaDegerlendirmePuani,
    COUNT(DISTINCT CASE WHEN y.puan >= 4 THEN y.yorumID END) AS olumluDegerlendirmeSayisi,
    COUNT(DISTINCT CASE WHEN y.puan <= 2 THEN y.yorumID END) AS olumsuzDegerlendirmeSayisi,
    -- Son 30 gündeki aktivite
    COUNT(DISTINCT CASE 
        WHEN s.olusturulmaTarihi >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY) 
        THEN s.seferID 
    END) AS son30GunSeferSayisi,
    COUNT(DISTINCT CASE 
        WHEN r.olusturulmaTarihi >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY) 
        THEN r.rezervasyonID 
    END) AS son30GunRezervasyonSayisi,
    -- Tamamlanma oranları
    CASE 
        WHEN COUNT(DISTINCT s.seferID) > 0 
        THEN ROUND(100.0 * COUNT(DISTINCT CASE WHEN s.seferDurumu = 'Tamamlandı' THEN s.seferID END) / COUNT(DISTINCT s.seferID), 2)
        ELSE 0 
    END AS seferTamamlanmaYuzdesi,
    CASE 
        WHEN COUNT(DISTINCT r.rezervasyonID) > 0 
        THEN ROUND(100.0 * COUNT(DISTINCT CASE WHEN r.durum = 'Tamamlandı' THEN r.rezervasyonID END) / COUNT(DISTINCT r.rezervasyonID), 2)
        ELSE 0 
    END AS rezervasyonTamamlanmaYuzdesi,
    k.hesapDurumu
FROM Kullanicilar k
INNER JOIN Universiteler uni ON k.universiteID = uni.universiteID
LEFT JOIN Yorumlar y ON k.kullaniciID = y.degerlendirilenKullaniciID
LEFT JOIN Seferler s ON k.kullaniciID = s.olusturanKullaniciID
LEFT JOIN Rezervasyonlar r ON k.kullaniciID = r.yolcuID
GROUP BY k.kullaniciID
ORDER BY sistemGuvenlikSkoru DESC, ortalamaDegerlendirmePuani DESC;

-- VIEW 6: Sefer Detay Raporu
-- Her sefer için detaylı bilgi ve istatistikler
CREATE OR REPLACE VIEW SeferDetayRaporuView AS
SELECT 
    s.seferID,
    s.seferTipi,
    s.katilimKapsami,
    s.seferTarihi,
    s.seferDurumu,
    -- Organizatör
    CONCAT(k.ad, ' ', k.soyad) AS organizatorAdSoyad,
    k.guvenlikSkoru AS organizatorGuvenlikSkoru,
    uni.universiteAdi AS organizatorUniversitesi,
    -- Kapasite
    s.maxKapasite,
    s.mevcutDoluluk,
    ROUND(100.0 * s.mevcutDoluluk / s.maxKapasite, 2) AS dolulukYuzdesi,
    -- Rezervasyonlar
    COUNT(DISTINCT r.rezervasyonID) AS toplamRezervasyonSayisi,
    COUNT(DISTINCT CASE WHEN r.durum = 'Onaylandı' THEN r.rezervasyonID END) AS onaylananRezervasyonSayisi,
    COUNT(DISTINCT CASE WHEN r.durum = 'Beklemede' THEN r.rezervasyonID END) AS bekleyenRezervasyonSayisi,
    -- Finansal
    s.temelFiyat,
    SUM(r.odenecekTutar) AS toplamBeklenenGelir,
    SUM(CASE WHEN r.durum = 'Tamamlandı' THEN r.odenecekTutar ELSE 0 END) AS gerceklesenGelir,
    -- Mesajlaşma
    COUNT(DISTINCT m.mesajID) AS toplamMesajSayisi,
    -- Güzergah
    (SELECT konumAdi FROM SeferGuzergahNoktalari WHERE seferID = s.seferID AND siraNo = 1) AS kalkisNoktasi,
    (SELECT konumAdi FROM SeferGuzergahNoktalari WHERE seferID = s.seferID 
     ORDER BY siraNo DESC LIMIT 1) AS varisNoktasi,
    (SELECT SUM(mesafeOncekiNoktaya) FROM SeferGuzergahNoktalari WHERE seferID = s.seferID) AS toplamMesafeKm
FROM Seferler s
INNER JOIN Kullanicilar k ON s.olusturanKullaniciID = k.kullaniciID
INNER JOIN Universiteler uni ON k.universiteID = uni.universiteID
LEFT JOIN Rezervasyonlar r ON s.seferID = r.seferID
LEFT JOIN Mesajlar m ON s.seferID = m.seferID
GROUP BY s.seferID
ORDER BY s.olusturulmaTarihi DESC;

-- END OF VIEWS
