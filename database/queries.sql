-- UNIRING - Non-Trivial SQL Queries

-- QUERY 1: En Popüler Organizatörler
-- Tamamlanmış sefer düzenleyen kullanıcılar
-- JOIN, GROUP BY, HAVING, Subquery kullanımı
SELECT
    k.kullaniciID,
    CONCAT(k.ad, ' ', k.soyad) AS organizatorAdi,
    uni.universiteAdi,
    k.guvenlikSkoru,
    COUNT(DISTINCT s.seferID) AS toplamSeferSayisi,
    COUNT(DISTINCT CASE WHEN s.seferDurumu = 'Tamamlandı' THEN s.seferID END) AS tamamlananSeferSayisi,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN s.seferDurumu = 'Tamamlandı' THEN s.seferID END) /
          NULLIF(COUNT(DISTINCT s.seferID), 0), 2) AS basariYuzdesi,
    COUNT(DISTINCT r.rezervasyonID) AS tasinanYolcuSayisi,
    ROUND(COALESCE(SUM(o.netTutar), 0), 2) AS toplamKazanc,
    ROUND(AVG(y.puan), 2) AS ortalamaYolcuPuani
FROM Kullanicilar k
INNER JOIN Universiteler uni ON k.universiteID = uni.universiteID
INNER JOIN Seferler s ON k.kullaniciID = s.olusturanKullaniciID
LEFT JOIN Rezervasyonlar r ON s.seferID = r.seferID AND r.durum = 'Tamamlandı'
LEFT JOIN Odemeler o ON s.seferID = o.seferID AND o.alacakliID = k.kullaniciID AND o.odemeDurumu = 'Ödendi'
LEFT JOIN Yorumlar y ON k.kullaniciID = y.degerlendirilenKullaniciID
WHERE s.seferDurumu = 'Tamamlandı'  -- Sadece tamamlanmış seferler
GROUP BY k.kullaniciID
HAVING toplamSeferSayisi >= 1  -- En az 1 tamamlanmış sefer
ORDER BY tamamlananSeferSayisi DESC, ortalamaYolcuPuani DESC, toplamKazanc DESC
LIMIT 10;

-- QUERY 2: Üniversiteler Arası Sefer Analizi
-- Popüler güzergahlar analizi
-- SELF JOIN, Multiple JOINs, Aggregate Functions
SELECT 
    uni1.universiteAdi AS organizatorUniversitesi,
    uni1.sehir AS organizatorSehir,
    kalkis.konumAdi AS kalkisNoktasi,
    varis.konumAdi AS varisNoktasi,
    COUNT(DISTINCT s.seferID) AS seferSayisi,
    COUNT(DISTINCT r.rezervasyonID) AS rezervasyonSayisi,
    ROUND(AVG(s.temelFiyat), 2) AS ortalamaMaliyet,
    SUM(CASE WHEN s.seferDurumu = 'Tamamlandı' THEN 1 ELSE 0 END) AS tamamlananSeferler,
    ROUND(AVG(sgn.mesafeOncekiNoktaya), 2) AS ortalamaMesafeKm
FROM Seferler s
INNER JOIN SeferGuzergahNoktalari kalkis ON s.seferID = kalkis.seferID AND kalkis.siraNo = 1
INNER JOIN SeferGuzergahNoktalari varis ON s.seferID = varis.seferID 
    AND varis.siraNo = (SELECT MAX(siraNo) FROM SeferGuzergahNoktalari WHERE seferID = s.seferID)
INNER JOIN Kullanicilar k ON s.olusturanKullaniciID = k.kullaniciID
INNER JOIN Universiteler uni1 ON k.universiteID = uni1.universiteID
INNER JOIN SeferGuzergahNoktalari sgn ON s.seferID = sgn.seferID
LEFT JOIN Rezervasyonlar r ON s.seferID = r.seferID AND r.durum NOT IN ('Reddedildi', 'İptal Edildi')
WHERE s.seferDurumu IN ('Tamamlandı', 'Aktif', 'Planlanıyor')
GROUP BY uni1.universiteID, kalkis.konumAdi, varis.konumAdi
HAVING seferSayisi >= 1
ORDER BY seferSayisi DESC, rezervasyonSayisi DESC
LIMIT 20;

-- QUERY 3: Zaman Bazlı Talep Analizi
-- Hangi gün ve saatlerde en çok sefer var?
-- Window Functions, CASE statements, Date/Time functions
SELECT 
    DAYNAME(s.seferTarihi) AS gun,
    HOUR(s.kalkisZamani) AS saat,
    COUNT(DISTINCT s.seferID) AS seferSayisi,
    COUNT(DISTINCT r.rezervasyonID) AS rezervasyonSayisi,
    ROUND(AVG(s.mevcutDoluluk), 2) AS ortalamaDoluluk,
    ROUND(AVG(s.mevcutDoluluk / NULLIF(s.maxKapasite, 0) * 100), 2) AS dolulukYuzdesi,
    ROUND(SUM(s.temelFiyat * s.mevcutDoluluk), 2) AS tahminiGelir,
    RANK() OVER (ORDER BY COUNT(DISTINCT s.seferID) DESC) AS populerlikSirasi
FROM Seferler s
LEFT JOIN Rezervasyonlar r ON s.seferID = r.seferID AND r.durum IN ('Onaylandı', 'Tamamlandı')
WHERE s.seferDurumu != 'İptal Edildi'
GROUP BY DAYNAME(s.seferTarihi), HOUR(s.kalkisZamani)
HAVING seferSayisi >= 1
ORDER BY seferSayisi DESC, saat ASC
LIMIT 20;

-- QUERY 4: Gelir ve Kazanç Analizi (Correlated Subquery)
-- Kullanıcıların gelir performansını karşılaştır
SELECT 
    k.kullaniciID,
    CONCAT(k.ad, ' ', k.soyad) AS kullaniciAdi,
    uni.universiteAdi,
    -- Organizatör geliri (TÜM ZAMANLAR)
    (SELECT COALESCE(SUM(o.netTutar), 0)
     FROM Odemeler o
     WHERE o.alacakliID = k.kullaniciID
       AND o.odemeDurumu = 'Ödendi'
    ) AS toplamKazanc,
    -- Yolcu harcaması (TÜM ZAMANLAR)
    (SELECT COALESCE(SUM(o.tutar), 0)
     FROM Odemeler o
     WHERE o.borcluID = k.kullaniciID
       AND o.odemeDurumu = 'Ödendi'
    ) AS toplamHarcama,
    -- Net bakiye
    ROUND(c.bakiye, 2) AS mevcutBakiye,
    -- Sefer sayıları
    (SELECT COUNT(*)
     FROM Seferler s
     WHERE s.olusturanKullaniciID = k.kullaniciID
       AND s.seferDurumu = 'Tamamlandı'
    ) AS tamamlananSeferSayisi,
    -- Ortalama kazanç per sefer
    CASE 
        WHEN (SELECT COUNT(*) FROM Seferler WHERE olusturanKullaniciID = k.kullaniciID AND seferDurumu = 'Tamamlandı') > 0
        THEN ROUND((SELECT COALESCE(SUM(o.netTutar), 0) FROM Odemeler o WHERE o.alacakliID = k.kullaniciID AND o.odemeDurumu = 'Ödendi') / 
                   (SELECT COUNT(*) FROM Seferler WHERE olusturanKullaniciID = k.kullaniciID AND seferDurumu = 'Tamamlandı'), 2)
        ELSE 0
    END AS seferBasinaOrtalamaKazanc
FROM Kullanicilar k
INNER JOIN Universiteler uni ON k.universiteID = uni.universiteID
LEFT JOIN Cuzdanlar c ON k.kullaniciID = c.kullaniciID
WHERE k.hesapDurumu = 'Aktif'
  AND EXISTS (
      SELECT 1 FROM Seferler s 
      WHERE s.olusturanKullaniciID = k.kullaniciID 
        AND s.seferDurumu = 'Tamamlandı'
  )
ORDER BY toplamKazanc DESC
LIMIT 15;

-- QUERY 5: Rezervasyon Onaylama Performansı
-- Organizatörlerin rezervasyonları ne kadar hızlı onayladığı
-- DATEDIFF, AVG, Complex JOIN
SELECT 
    k.kullaniciID,
    CONCAT(k.ad, ' ', k.soyad) AS organizatorAdi,
    uni.universiteAdi,
    COUNT(DISTINCT r.rezervasyonID) AS toplamRezervasyonTalebi,
    COUNT(DISTINCT CASE WHEN r.durum = 'Onaylandı' THEN r.rezervasyonID END) AS onaylananSayisi,
    COUNT(DISTINCT CASE WHEN r.durum = 'Reddedildi' THEN r.rezervasyonID END) AS rededilenSayisi,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN r.durum = 'Onaylandı' THEN r.rezervasyonID END) / 
          NULLIF(COUNT(DISTINCT r.rezervasyonID), 0), 2) AS onaylamaYuzdesi,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, r.olusturulmaTarihi, r.onaylanmaTarihi)), 2) AS ortalamaOnaylamaSuresiDakika,
    MIN(TIMESTAMPDIFF(MINUTE, r.olusturulmaTarihi, r.onaylanmaTarihi)) AS enHizliOnayDakika,
    MAX(TIMESTAMPDIFF(MINUTE, r.olusturulmaTarihi, r.onaylanmaTarihi)) AS enYavasOnayDakika,
    ROUND(k.guvenlikSkoru, 2) AS guvenlikSkoru
FROM Kullanicilar k
INNER JOIN Universiteler uni ON k.universiteID = uni.universiteID
INNER JOIN Seferler s ON k.kullaniciID = s.olusturanKullaniciID
INNER JOIN Rezervasyonlar r ON s.seferID = r.seferID
WHERE r.onaylanmaTarihi IS NOT NULL
GROUP BY k.kullaniciID
HAVING toplamRezervasyonTalebi >= 2
ORDER BY onaylamaYuzdesi DESC, ortalamaOnaylamaSuresiDakika ASC
LIMIT 20;

-- QUERY 6: Çapraz Satış Fırsatları (Cross-Selling)
-- Hangi kullanıcılar hem organizatör hem yolcu?
-- UNION, Multiple aggregates
SELECT 
    k.kullaniciID,
    CONCAT(k.ad, ' ', k.soyad) AS kullaniciAdi,
    uni.universiteAdi,
    k.email,
    -- Organizatör metrikleri
    COUNT(DISTINCT s.seferID) AS organizatorOlarakSeferSayisi,
    SUM(CASE WHEN s.seferDurumu = 'Tamamlandı' THEN 1 ELSE 0 END) AS tamamlananOrganizasyonlar,
    -- Yolcu metrikleri
    COUNT(DISTINCT r.rezervasyonID) AS yolcuOlarakSeferSayisi,
    SUM(CASE WHEN r.durum = 'Tamamlandı' THEN 1 ELSE 0 END) AS tamamlananYolculuklar,
    -- Aktivite dengesi
    CASE 
        WHEN COUNT(DISTINCT s.seferID) > COUNT(DISTINCT r.rezervasyonID) * 2 THEN 'Ağırlıklı Organizatör'
        WHEN COUNT(DISTINCT r.rezervasyonID) > COUNT(DISTINCT s.seferID) * 2 THEN 'Ağırlıklı Yolcu'
        ELSE 'Dengeli Kullanıcı'
    END AS kullaniciProfili,
    -- Toplam aktivite
    (COUNT(DISTINCT s.seferID) + COUNT(DISTINCT r.rezervasyonID)) AS toplamAktivite,
    k.guvenlikSkoru,
    AVG(y.puan) AS ortalamaDegerlendirme
FROM Kullanicilar k
INNER JOIN Universiteler uni ON k.universiteID = uni.universiteID
LEFT JOIN Seferler s ON k.kullaniciID = s.olusturanKullaniciID
LEFT JOIN Rezervasyonlar r ON k.kullaniciID = r.yolcuID
LEFT JOIN Yorumlar y ON k.kullaniciID = y.degerlendirilenKullaniciID
WHERE k.hesapDurumu = 'Aktif'
GROUP BY k.kullaniciID
HAVING organizatorOlarakSeferSayisi > 0 
   AND yolcuOlarakSeferSayisi > 0
ORDER BY toplamAktivite DESC
LIMIT 25;

-- QUERY 7: Güzergah Optimizasyon Analizi
-- Çok duraklı seferler analizi
-- Complex aggregation, Multiple JOINs
SELECT 
    s.seferID,
    CONCAT(k.ad, ' ', k.soyad) AS organizatorAdi,
    s.seferTarihi,
    COUNT(DISTINCT sgn.noktaID) AS toplamDurakSayisi,
    (SELECT konumAdi FROM SeferGuzergahNoktalari WHERE seferID = s.seferID AND siraNo = 1) AS baslangicNoktasi,
    (SELECT konumAdi FROM SeferGuzergahNoktalari WHERE seferID = s.seferID ORDER BY siraNo DESC LIMIT 1) AS bitisNoktasi,
    SUM(sgn.mesafeOncekiNoktaya) AS toplamMesafeKm,
    TIMESTAMPDIFF(MINUTE, s.kalkisZamani, s.tahminiVarisZamani) AS toplamSureDakika,
    ROUND(SUM(sgn.mesafeOncekiNoktaya) / (TIMESTAMPDIFF(MINUTE, s.kalkisZamani, s.tahminiVarisZamani) / 60.0), 2) AS ortalamaHizKmH,
    COUNT(DISTINCT r.rezervasyonID) AS rezervasyonSayisi,
    s.mevcutDoluluk,
    s.maxKapasite,
    ROUND(s.temelFiyat / SUM(sgn.mesafeOncekiNoktaya), 2) AS kmBasinaFiyat,
    GROUP_CONCAT(DISTINCT sgn.konumAdi ORDER BY sgn.siraNo SEPARATOR ' → ') AS tamGuzergah
FROM Seferler s
INNER JOIN Kullanicilar k ON s.olusturanKullaniciID = k.kullaniciID
INNER JOIN SeferGuzergahNoktalari sgn ON s.seferID = sgn.seferID
LEFT JOIN Rezervasyonlar r ON s.seferID = r.seferID AND r.durum IN ('Onaylandı', 'Tamamlandı')
WHERE s.seferDurumu IN ('Aktif', 'Tamamlandı', 'Devam Ediyor')
GROUP BY s.seferID
HAVING toplamDurakSayisi >= 3
ORDER BY toplamMesafeKm DESC, rezervasyonSayisi DESC
LIMIT 15;

-- QUERY 8: Güvenlik Skoru Analizi
-- Güvenlik skoru ile diğer metrikler arasındaki ilişki
-- Statistical analysis, CASE WHEN, Window functions
SELECT 
    CASE 
        WHEN k.guvenlikSkoru >= 80 THEN 'Çok Yüksek (80+)'
        WHEN k.guvenlikSkoru >= 60 THEN 'Yüksek (60-79)'
        WHEN k.guvenlikSkoru >= 40 THEN 'Orta (40-59)'
        ELSE 'Düşük (<40)'
    END AS guvenlikSeviyesi,
    COUNT(DISTINCT k.kullaniciID) AS kullaniciSayisi,
    AVG(k.guvenlikSkoru) AS ortalamaGuvenlikSkoru,
    -- Sefer metrikleri
    AVG(sefer_sayisi.sayi) AS ortalamaKisiBasiSefer,
    -- Rezervasyon onaylama oranı
    ROUND(AVG(onay_orani.oran), 2) AS ortalamaOnaylamaYuzdesi,
    -- Değerlendirme puanı
    ROUND(AVG(yorum_puan.puan), 2) AS ortalamaYolcuPuani,
    -- İptal oranı
    ROUND(AVG(iptal_orani.oran), 2) AS ortalamaIptalYuzdesi,
    -- Gelir
    ROUND(AVG(gelir.tutar), 2) AS ortalamaKisiBasiGelir
FROM Kullanicilar k
LEFT JOIN (
    SELECT olusturanKullaniciID, COUNT(*) as sayi 
    FROM Seferler 
    WHERE seferDurumu = 'Tamamlandı'
    GROUP BY olusturanKullaniciID
) sefer_sayisi ON k.kullaniciID = sefer_sayisi.olusturanKullaniciID
LEFT JOIN (
    SELECT s.olusturanKullaniciID, 
           100.0 * SUM(CASE WHEN r.durum = 'Onaylandı' THEN 1 ELSE 0 END) / COUNT(*) as oran
    FROM Seferler s
    JOIN Rezervasyonlar r ON s.seferID = r.seferID
    GROUP BY s.olusturanKullaniciID
) onay_orani ON k.kullaniciID = onay_orani.olusturanKullaniciID
LEFT JOIN (
    SELECT degerlendirilenKullaniciID, AVG(puan) as puan
    FROM Yorumlar
    GROUP BY degerlendirilenKullaniciID
) yorum_puan ON k.kullaniciID = yorum_puan.degerlendirilenKullaniciID
LEFT JOIN (
    SELECT s.olusturanKullaniciID,
           100.0 * SUM(CASE WHEN s.seferDurumu = 'İptal Edildi' THEN 1 ELSE 0 END) / COUNT(*) as oran
    FROM Seferler s
    GROUP BY s.olusturanKullaniciID
) iptal_orani ON k.kullaniciID = iptal_orani.olusturanKullaniciID
LEFT JOIN (
    SELECT alacakliID, SUM(netTutar) as tutar
    FROM Odemeler
    WHERE odemeDurumu = 'Ödendi'
    GROUP BY alacakliID
) gelir ON k.kullaniciID = gelir.alacakliID
WHERE k.hesapDurumu = 'Aktif'
GROUP BY guvenlikSeviyesi
ORDER BY AVG(k.guvenlikSkoru) DESC;

-- QUERY 9: Zaman Serisi Trend Analizi
-- Aylık büyüme ve trend analizi
-- Window functions, LAG, Growth calculation
WITH AylikIstatistikler AS (
    SELECT 
        DATE_FORMAT(s.olusturulmaTarihi, '%Y-%m') AS donem,
        COUNT(DISTINCT s.seferID) AS seferSayisi,
        COUNT(DISTINCT r.rezervasyonID) AS rezervasyonSayisi,
        COUNT(DISTINCT s.olusturanKullaniciID) AS aktifOrganizatorSayisi,
        COUNT(DISTINCT r.yolcuID) AS aktifYolcuSayisi,
        COALESCE(SUM(r.odenecekTutar), 0) AS toplamIslemHacmi,
        ROUND(AVG(s.mevcutDoluluk / NULLIF(s.maxKapasite, 0) * 100), 2) AS ortalamaDolulukYuzdesi
    FROM Seferler s
    LEFT JOIN Rezervasyonlar r ON s.seferID = r.seferID AND r.durum NOT IN ('Reddedildi', 'İptal Edildi')
    GROUP BY DATE_FORMAT(s.olusturulmaTarihi, '%Y-%m')
)
SELECT 
    donem,
    seferSayisi,
    rezervasyonSayisi,
    aktifOrganizatorSayisi,
    aktifYolcuSayisi,
    ROUND(toplamIslemHacmi, 2) AS toplamIslemHacmi,
    ortalamaDolulukYuzdesi,
    -- Bir önceki aya göre değişim
    LAG(seferSayisi, 1) OVER (ORDER BY donem) AS oncekiAySeferSayisi,
    ROUND(100.0 * (seferSayisi - LAG(seferSayisi, 1) OVER (ORDER BY donem)) / 
          NULLIF(LAG(seferSayisi, 1) OVER (ORDER BY donem), 0), 2) AS seferBuyumeYuzdesi,
    -- 3 aylık hareketli ortalama
    ROUND(AVG(seferSayisi) OVER (ORDER BY donem ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS ucAylikOrtSeferSayisi,
    -- Kümülatif toplam
    SUM(toplamIslemHacmi) OVER (ORDER BY donem) AS kumulatifIslemHacmi
FROM AylikIstatistikler
ORDER BY donem DESC;

-- QUERY 10: En Değerli Müşteriler
-- Recency, Frequency, Monetary analizi
-- Complex scoring, Multiple CTEs
WITH KullaniciMetrikleri AS (
    SELECT 
        k.kullaniciID,
        CONCAT(k.ad, ' ', k.soyad) AS kullaniciAdi,
        uni.universiteAdi,
        -- Recency (Son aktivite)
        DATEDIFF(CURRENT_DATE, GREATEST(
            COALESCE(MAX(s.olusturulmaTarihi), '1900-01-01'),
            COALESCE(MAX(r.olusturulmaTarihi), '1900-01-01')
        )) AS sonAktiviteGunOnce,
        -- Frequency (Toplam işlem)
        COUNT(DISTINCT s.seferID) + COUNT(DISTINCT r.rezervasyonID) AS toplamIslemSayisi,
        -- Monetary (Toplam değer)
        COALESCE(SUM(o_gelir.netTutar), 0) + COALESCE(SUM(o_harcama.tutar), 0) AS toplamIslemDegeri,
        -- Ek metrikler
        k.guvenlikSkoru,
        AVG(y.puan) AS ortalamaPuan
    FROM Kullanicilar k
    INNER JOIN Universiteler uni ON k.universiteID = uni.universiteID
    LEFT JOIN Seferler s ON k.kullaniciID = s.olusturanKullaniciID
    LEFT JOIN Rezervasyonlar r ON k.kullaniciID = r.yolcuID
    LEFT JOIN Odemeler o_gelir ON k.kullaniciID = o_gelir.alacakliID AND o_gelir.odemeDurumu = 'Ödendi'
    LEFT JOIN Odemeler o_harcama ON k.kullaniciID = o_harcama.borcluID AND o_harcama.odemeDurumu = 'Ödendi'
    LEFT JOIN Yorumlar y ON k.kullaniciID = y.degerlendirilenKullaniciID
    WHERE k.hesapDurumu = 'Aktif'
    GROUP BY k.kullaniciID
),
RFMSkorlari AS (
    SELECT 
        *,
        -- RFM skorları (1-5 arası)
        CASE 
            WHEN sonAktiviteGunOnce <= 7 THEN 5
            WHEN sonAktiviteGunOnce <= 30 THEN 4
            WHEN sonAktiviteGunOnce <= 90 THEN 3
            WHEN sonAktiviteGunOnce <= 180 THEN 2
            ELSE 1
        END AS recencySkoru,
        NTILE(5) OVER (ORDER BY toplamIslemSayisi) AS frequencySkoru,
        NTILE(5) OVER (ORDER BY toplamIslemDegeri) AS monetarySkoru
    FROM KullaniciMetrikleri
)
SELECT 
    kullaniciID,
    kullaniciAdi,
    universiteAdi,
    sonAktiviteGunOnce,
    toplamIslemSayisi,
    ROUND(toplamIslemDegeri, 2) AS toplamIslemDegeri,
    guvenlikSkoru,
    ROUND(ortalamaPuan, 2) AS ortalamaPuan,
    recencySkoru,
    frequencySkoru,
    monetarySkoru,
    (recencySkoru + frequencySkoru + monetarySkoru) AS toplamRFMSkoru,
    CASE 
        WHEN (recencySkoru + frequencySkoru + monetarySkoru) >= 13 THEN 'VIP Müşteri'
        WHEN (recencySkoru + frequencySkoru + monetarySkoru) >= 10 THEN 'Değerli Müşteri'
        WHEN (recencySkoru + frequencySkoru + monetarySkoru) >= 7 THEN 'Orta Seviye Müşteri'
        ELSE 'Potansiyel Kayıp Riski'
    END AS musteriSegmenti
FROM RFMSkorlari
WHERE toplamIslemSayisi > 0
ORDER BY toplamRFMSkoru DESC, toplamIslemDegeri DESC
LIMIT 50;

-- END OF QUERIES
