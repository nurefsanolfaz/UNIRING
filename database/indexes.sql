-- Performance Optimization Indexes

-- NOT: Bazı index'ler zaten CREATE TABLE sırasında oluşturuldu.
-- Bu dosya, ek performans optimizasyonları için composite index'ler içerir.

-- COMPOSITE INDEXES - Sıkça birlikte sorgulanan kolonlar

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

-- FULL-TEXT INDEXES - Metin araması için

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

-- COVERING INDEXES - SELECT sorgularını hızlandırmak için

-- Aktif seferler için tüm gerekli kolonları içeren index
CREATE INDEX idx_aktif_sefer_cover 
ON Seferler(seferDurumu, seferTarihi, maxKapasite, mevcutDoluluk, temelFiyat);

-- Kullanıcı listesi için
CREATE INDEX idx_kullanici_liste_cover 
ON Kullanicilar(hesapDurumu, guvenlikSkoru, universiteID, kayitTarihi);

-- Rezervasyon listesi için
CREATE INDEX idx_rezervasyon_liste_cover 
ON Rezervasyonlar(durum, seferID, yolcuID, olusturulmaTarihi, odenecekTutar);

-- END OF INDEXES
