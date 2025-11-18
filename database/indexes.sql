-- ============================================
-- UNIRING - Database Indexes
-- Performance Optimization Indexes
-- ============================================

-- NOT: Bazı index'ler zaten CREATE TABLE sırasında oluşturuldu.
-- Bu dosya, ek performans optimizasyonları için composite index'ler içerir.

-- ============================================
-- COMPOSITE INDEXES - Sıkça birlikte sorgulanan kolonlar
-- ============================================

-- Sefer arama için composite index
-- Kullanıcılar genelde tarih + durum + kapsam ile arar
CREATE INDEX idx_sefer_arama 
ON Seferler(seferTarihi, seferDurumu, katilimKapsami);

-- Organizatör + tarih bazlı sefer listesi için
CREATE INDEX idx_organizator_tarih 
ON Seferler(olusturanKullaniciID, seferTarihi, seferDurumu);

-- Rezervasyon arama optimizasyonu (yolcu + durum)
CREATE INDEX idx_rezervasyon_yolcu_durum 
ON Rezervasyonlar(yolcuID, durum, olusturulmaTarihi);

-- Sefer + rezervasyon durumu için
CREATE INDEX idx_rezervasyon_sefer_durum 
ON Rezervasyonlar(seferID, durum);

-- Ödeme raporları için
CREATE INDEX idx_odeme_tarih_durum 
ON Odemeler(islemTarihi, odemeDurumu);

-- Kullanıcı bazlı ödeme geçmişi
CREATE INDEX idx_odeme_borclu_tarih 
ON Odemeler(borcluID, islemTarihi);

CREATE INDEX idx_odeme_alacakli_tarih 
ON Odemeler(alacakliID, islemTarihi);

-- Yorum sorgulama optimizasyonu
CREATE INDEX idx_yorum_kullanici_tarih 
ON Yorumlar(degerlendirilenKullaniciID, yorumTarihi, puan);

-- Mesaj sıralama için
CREATE INDEX idx_mesaj_sefer_tarih 
ON Mesajlar(seferID, gonderimZamani);

-- Güzergah noktaları için
CREATE INDEX idx_guzergah_konum 
ON SeferGuzergahNoktalari(konumAdi, siraNo);

-- ============================================
-- FULL-TEXT INDEXES - Metin araması için
-- ============================================

-- Kullanıcı adı araması için
CREATE FULLTEXT INDEX idx_kullanici_ad_soyad 
ON Kullanicilar(ad, soyad);

-- Üniversite adı araması için
CREATE FULLTEXT INDEX idx_universite_adi 
ON Universiteler(universiteAdi);

-- Konum adı araması için
CREATE FULLTEXT INDEX idx_konum_adi 
ON SeferGuzergahNoktalari(konumAdi);

-- Sefer açıklaması araması için
CREATE FULLTEXT INDEX idx_sefer_aciklama 
ON Seferler(aciklama);

-- Yorum metni araması için
CREATE FULLTEXT INDEX idx_yorum_metin 
ON Yorumlar(yorum);

-- ============================================
-- COVERING INDEXES - SELECT sorgularını hızlandırmak için
-- ============================================

-- Aktif seferler için tüm gerekli kolonları içeren index
CREATE INDEX idx_aktif_sefer_cover 
ON Seferler(seferDurumu, seferTarihi, maxKapasite, mevcutDoluluk, temelFiyat);

-- Kullanıcı listesi için
CREATE INDEX idx_kullanici_liste_cover 
ON Kullanicilar(hesapDurumu, guvenlikSkoru, universiteID, kayitTarihi);

-- Rezervasyon listesi için
CREATE INDEX idx_rezervasyon_liste_cover 
ON Rezervasyonlar(durum, seferID, yolcuID, olusturulmaTarihi, odenecekTutar);

-- ============================================
-- INDEX KULLANIM AÇIKLAMALARI
-- ============================================

/*
INDEX SEÇİM PRENSİPLERİ:

1. YÜKSEK KARDİNALİTE: 
   - Email, plaka gibi benzersiz değerler için index
   - Düşük kardinalite (cinsiyet gibi) için index gereksiz

2. WHERE CLAUSE'DA SIK KULLANILAN:
   - seferDurumu, hesapDurumu, odemeDurumu
   - Tarih alanları (seferTarihi, islemTarihi)

3. JOIN KOLONLARI:
   - Foreign key'ler otomatik index'lendi
   - Ek composite index'ler join performansı için

4. ORDER BY VE GROUP BY:
   - Sıralama yapılan kolonlar için index
   - Gruplama kolonları için composite index

5. COVERING INDEX:
   - SELECT'teki tüm kolonları içeren index
   - Tablo erişimini ortadan kaldırır

PERFORMANS KAZANCI:
- Basit SELECT: 10-100x daha hızlı
- JOIN işlemleri: 5-50x daha hızlı
- FULL-TEXT SEARCH: 100-1000x daha hızlı

TRADE-OFF:
- Avantaj: Query hızı artar
- Dezavantaj: INSERT/UPDATE/DELETE yavaşlar (minimal)
- Disk kullanımı: Her index ~10-20% ek alan

UNIRING PROJESİ İÇİN:
- Read-heavy sistem (daha çok arama/listeleme)
- Write operasyonları az (sefer/rezervasyon oluşturma)
- Index'ler net performans kazancı sağlar
*/

-- ============================================
-- INDEX PERFORMANS ANALİZİ SORGUSU
-- ============================================

/*
Index'lerin kullanım istatistiklerini görmek için:

SELECT 
    TABLE_NAME,
    INDEX_NAME,
    SEQ_IN_INDEX,
    COLUMN_NAME,
    CARDINALITY,
    INDEX_TYPE
FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = 'uniring_db'
ORDER BY TABLE_NAME, INDEX_NAME, SEQ_IN_INDEX;
*/

-- ============================================
-- QUERY EXECUTION PLAN TEST
-- ============================================

/*
Index'lerin kullanılıp kullanılmadığını test etmek için:

EXPLAIN SELECT * 
FROM Seferler 
WHERE seferDurumu = 'Aktif' 
  AND seferTarihi >= CURRENT_DATE
  AND katilimKapsami = 'Tüm Üniversiteler';

-- 'type' kolonu 'ref' veya 'range' olmalı (iyi)
-- 'possible_keys' kolonunda index'imiz olmalı
-- 'key' kolonunda kullanılan index görünmeli
*/

-- ============================================
-- END OF INDEXES
-- ============================================
