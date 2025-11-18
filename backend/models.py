"""
UNIRING Database Models
SQLAlchemy ORM Models
"""

from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from werkzeug.security import generate_password_hash, check_password_hash

db = SQLAlchemy()

class Universiteler(db.Model):
    __tablename__ = 'Universiteler'
    
    universiteID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    universiteAdi = db.Column(db.String(150), nullable=False)
    emailDomain = db.Column(db.String(100), nullable=False, unique=True)
    sehir = db.Column(db.String(50), nullable=False)
    logoURL = db.Column(db.String(255))
    
    # Relationships
    kullanicilar = db.relationship('Kullanicilar', backref='universite', lazy=True)
    
    def to_dict(self):
        return {
            'universiteID': self.universiteID,
            'universiteAdi': self.universiteAdi,
            'emailDomain': self.emailDomain,
            'sehir': self.sehir,
            'logoURL': self.logoURL
        }

class Kullanicilar(db.Model):
    __tablename__ = 'Kullanicilar'
    
    kullaniciID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    universiteID = db.Column(db.Integer, db.ForeignKey('Universiteler.universiteID'), nullable=False)
    ad = db.Column(db.String(150), nullable=False)
    soyad = db.Column(db.String(150), nullable=False)
    email = db.Column(db.String(100), nullable=False, unique=True)
    emailDogrulandi = db.Column(db.Boolean, default=False)
    sifreHash = db.Column(db.String(255), nullable=False)
    telefonNo = db.Column(db.String(15))
    telefonDogrulandi = db.Column(db.Boolean, default=False)
    cinsiyet = db.Column(db.Enum('Erkek', 'Kadın', 'Belirtmek İstemiyorum'), nullable=False)
    dogumTarihi = db.Column(db.Date, nullable=False)
    profilFotoURL = db.Column(db.String(255))
    biyografi = db.Column(db.Text)
    cinsiyetTercihi = db.Column(db.Enum('Fark Etmez', 'Sadece Kadın', 'Sadece Erkek'), default='Fark Etmez')
    sigaraIciyorMu = db.Column(db.Boolean, default=False)
    muzikTercihi = db.Column(db.String(100))
    guvenlikSkoru = db.Column(db.Numeric(5, 2), default=50.00)
    ogrenciBelgesiURL = db.Column(db.String(255), nullable=False)
    ogrenciBelgesiOnaylandi = db.Column(db.Boolean, default=False)
    surusBelgesiNo = db.Column(db.String(20))
    surusBelgesiOnaylandi = db.Column(db.Boolean, default=False)
    kayitTarihi = db.Column(db.DateTime, default=datetime.utcnow)
    sonGirisTarihi = db.Column(db.DateTime)
    hesapDurumu = db.Column(db.Enum('Aktif', 'Askıda', 'Yasaklı'), default='Aktif')
    
    # Relationships
    araclar = db.relationship('Araclar', backref='sahip', lazy=True)
    seferler = db.relationship('Seferler', backref='organizator', lazy=True)
    rezervasyonlar = db.relationship('Rezervasyonlar', backref='yolcu', lazy=True)
    cuzdan = db.relationship('Cuzdanlar', backref='kullanici', uselist=False, lazy=True)
    
    def set_password(self, password):
        self.sifreHash = generate_password_hash(password)
    
    def check_password(self, password):
        return check_password_hash(self.sifreHash, password)
    
    def to_dict(self):
        return {
            'kullaniciID': self.kullaniciID,
            'universiteID': self.universiteID,
            'ad': self.ad,
            'soyad': self.soyad,
            'email': self.email,
            'telefonNo': self.telefonNo,
            'cinsiyet': self.cinsiyet,
            'dogumTarihi': self.dogumTarihi.isoformat() if self.dogumTarihi else None,
            'profilFotoURL': self.profilFotoURL,
            'biyografi': self.biyografi,
            'guvenlikSkoru': float(self.guvenlikSkoru) if self.guvenlikSkoru else 0,
            'hesapDurumu': self.hesapDurumu,
            'kayitTarihi': self.kayitTarihi.isoformat() if self.kayitTarihi else None
        }

class Araclar(db.Model):
    __tablename__ = 'Araclar'
    
    aracID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    sahipID = db.Column(db.Integer, db.ForeignKey('Kullanicilar.kullaniciID'), nullable=False)
    plaka = db.Column(db.String(10), nullable=False, unique=True)
    marka = db.Column(db.String(50), nullable=False)
    model = db.Column(db.String(50), nullable=False)
    renk = db.Column(db.String(30))
    yil = db.Column(db.Integer)
    yolcuKapasitesi = db.Column(db.SmallInteger, nullable=False)
    sigortaBitisTarihi = db.Column(db.Date)
    ruhsatFotoURL = db.Column(db.String(255))
    onayDurumu = db.Column(db.Enum('Beklemede', 'Onaylandı', 'Reddedildi'), default='Beklemede')
    eklenmeTarihi = db.Column(db.DateTime, default=datetime.utcnow)
    
    # Relationships
    seferler = db.relationship('Seferler', backref='arac', lazy=True)
    
    def to_dict(self):
        return {
            'aracID': self.aracID,
            'sahipID': self.sahipID,
            'plaka': self.plaka,
            'marka': self.marka,
            'model': self.model,
            'renk': self.renk,
            'yil': self.yil,
            'yolcuKapasitesi': self.yolcuKapasitesi,
            'onayDurumu': self.onayDurumu
        }

class Seferler(db.Model):
    __tablename__ = 'Seferler'
    
    seferID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    olusturanKullaniciID = db.Column(db.Integer, db.ForeignKey('Kullanicilar.kullaniciID'), nullable=False)
    aracID = db.Column(db.Integer, db.ForeignKey('Araclar.aracID'))
    seferTipi = db.Column(db.Enum('Araç Paylaşımı', 'Ortak Araç Kullanımı'), nullable=False)
    katilimKapsami = db.Column(db.Enum('Sadece Kendi Üniversitesi', 'Tüm Üniversiteler'), default='Tüm Üniversiteler')
    seferTarihi = db.Column(db.Date, nullable=False)
    kalkisZamani = db.Column(db.DateTime, nullable=False)
    tahminiVarisZamani = db.Column(db.DateTime)
    maxKapasite = db.Column(db.SmallInteger, nullable=False)
    mevcutDoluluk = db.Column(db.SmallInteger, default=0)
    seferDurumu = db.Column(db.Enum('Planlanıyor', 'Aktif', 'Devam Ediyor', 'Tamamlandı', 'İptal Edildi'), default='Planlanıyor')
    bagajAlaniVar = db.Column(db.Boolean, default=True)
    klimaVar = db.Column(db.Boolean, default=True)
    aciklama = db.Column(db.Text)
    fiyatlandirmaTipi = db.Column(db.Enum('Sabit', 'Dinamik'), default='Sabit')
    temelFiyat = db.Column(db.Numeric(10, 2), nullable=False)
    olusturulmaTarihi = db.Column(db.DateTime, default=datetime.utcnow)
    iptalNedeni = db.Column(db.Text)
    
    # Relationships
    guzergah_noktalari = db.relationship('SeferGuzergahNoktalari', backref='sefer', lazy=True, cascade='all, delete-orphan')
    rezervasyonlar = db.relationship('Rezervasyonlar', backref='sefer', lazy=True)
    mesajlar = db.relationship('Mesajlar', backref='sefer', lazy=True)
    
    def to_dict(self):
        return {
            'seferID': self.seferID,
            'olusturanKullaniciID': self.olusturanKullaniciID,
            'aracID': self.aracID,
            'seferTipi': self.seferTipi,
            'katilimKapsami': self.katilimKapsami,
            'seferTarihi': self.seferTarihi.isoformat() if self.seferTarihi else None,
            'kalkisZamani': self.kalkisZamani.isoformat() if self.kalkisZamani else None,
            'tahminiVarisZamani': self.tahminiVarisZamani.isoformat() if self.tahminiVarisZamani else None,
            'maxKapasite': self.maxKapasite,
            'mevcutDoluluk': self.mevcutDoluluk,
            'seferDurumu': self.seferDurumu,
            'bagajAlaniVar': self.bagajAlaniVar,
            'klimaVar': self.klimaVar,
            'aciklama': self.aciklama,
            'temelFiyat': float(self.temelFiyat) if self.temelFiyat else 0,
            'olusturulmaTarihi': self.olusturulmaTarihi.isoformat() if self.olusturulmaTarihi else None
        }

class SeferGuzergahNoktalari(db.Model):
    __tablename__ = 'SeferGuzergahNoktalari'
    
    noktaID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    seferID = db.Column(db.Integer, db.ForeignKey('Seferler.seferID'), nullable=False)
    konumAdi = db.Column(db.String(255), nullable=False)
    latitude = db.Column(db.Numeric(10, 8))
    longitude = db.Column(db.Numeric(11, 8))
    siraNo = db.Column(db.SmallInteger, nullable=False)
    planlananVarisZamani = db.Column(db.Time)
    gercekVarisZamani = db.Column(db.DateTime)
    mesafeOncekiNoktaya = db.Column(db.Numeric(6, 2))
    
    def to_dict(self):
        return {
            'noktaID': self.noktaID,
            'seferID': self.seferID,
            'konumAdi': self.konumAdi,
            'latitude': float(self.latitude) if self.latitude else None,
            'longitude': float(self.longitude) if self.longitude else None,
            'siraNo': self.siraNo,
            'mesafeOncekiNoktaya': float(self.mesafeOncekiNoktaya) if self.mesafeOncekiNoktaya else None
        }

class Rezervasyonlar(db.Model):
    __tablename__ = 'Rezervasyonlar'
    
    rezervasyonID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    seferID = db.Column(db.Integer, db.ForeignKey('Seferler.seferID'), nullable=False)
    yolcuID = db.Column(db.Integer, db.ForeignKey('Kullanicilar.kullaniciID'), nullable=False)
    binisNoktaID = db.Column(db.Integer, db.ForeignKey('SeferGuzergahNoktalari.noktaID'), nullable=False)
    inisNoktaID = db.Column(db.Integer, db.ForeignKey('SeferGuzergahNoktalari.noktaID'), nullable=False)
    yolcuSayisi = db.Column(db.SmallInteger, default=1)
    hesaplananUcret = db.Column(db.Numeric(10, 2), nullable=False)
    indirimMiktari = db.Column(db.Numeric(10, 2), default=0.00)
    odenecekTutar = db.Column(db.Numeric(10, 2), nullable=False)
    durum = db.Column(db.Enum('Beklemede', 'Onaylandı', 'Reddedildi', 'İptal Edildi', 'Tamamlandı'), default='Beklemede')
    olusturulmaTarihi = db.Column(db.DateTime, default=datetime.utcnow)
    onaylanmaTarihi = db.Column(db.DateTime)
    iptalNedeni = db.Column(db.Text)
    yolcuDegerlendirdiMi = db.Column(db.Boolean, default=False)
    organizatorDegerlendirdiMi = db.Column(db.Boolean, default=False)
    
    # Relationships
    binis_noktasi = db.relationship('SeferGuzergahNoktalari', foreign_keys=[binisNoktaID])
    inis_noktasi = db.relationship('SeferGuzergahNoktalari', foreign_keys=[inisNoktaID])
    
    def to_dict(self):
        return {
            'rezervasyonID': self.rezervasyonID,
            'seferID': self.seferID,
            'yolcuID': self.yolcuID,
            'binisNoktaID': self.binisNoktaID,
            'inisNoktaID': self.inisNoktaID,
            'yolcuSayisi': self.yolcuSayisi,
            'hesaplananUcret': float(self.hesaplananUcret) if self.hesaplananUcret else 0,
            'odenecekTutar': float(self.odenecekTutar) if self.odenecekTutar else 0,
            'durum': self.durum,
            'olusturulmaTarihi': self.olusturulmaTarihi.isoformat() if self.olusturulmaTarihi else None,
            'onaylanmaTarihi': self.onaylanmaTarihi.isoformat() if self.onaylanmaTarihi else None
        }

class Cuzdanlar(db.Model):
    __tablename__ = 'Cuzdanlar'
    
    cuzdanID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    kullaniciID = db.Column(db.Integer, db.ForeignKey('Kullanicilar.kullaniciID'), nullable=False, unique=True)
    bakiye = db.Column(db.Numeric(10, 2), default=0.00)
    sonGuncelleme = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    def to_dict(self):
        return {
            'cuzdanID': self.cuzdanID,
            'kullaniciID': self.kullaniciID,
            'bakiye': float(self.bakiye) if self.bakiye else 0,
            'sonGuncelleme': self.sonGuncelleme.isoformat() if self.sonGuncelleme else None
        }

class Odemeler(db.Model):
    __tablename__ = 'Odemeler'
    
    odemeID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    rezervasyonID = db.Column(db.Integer, db.ForeignKey('Rezervasyonlar.rezervasyonID'))
    seferID = db.Column(db.Integer, db.ForeignKey('Seferler.seferID'), nullable=False)
    borcluID = db.Column(db.Integer, db.ForeignKey('Kullanicilar.kullaniciID'), nullable=False)
    alacakliID = db.Column(db.Integer, db.ForeignKey('Kullanicilar.kullaniciID'), nullable=False)
    tutar = db.Column(db.Numeric(10, 2), nullable=False)
    platformKomisyonu = db.Column(db.Numeric(10, 2), default=0.00)
    netTutar = db.Column(db.Numeric(10, 2), nullable=False)
    odemeTipi = db.Column(db.Enum('Cüzdan', 'Kredi Kartı', 'IBAN', 'Nakit'), default='Cüzdan')
    odemeDurumu = db.Column(db.Enum('Ödenmedi', 'Onay Bekliyor', 'Ödendi', 'İade Edildi'), default='Ödenmedi')
    islemTarihi = db.Column(db.DateTime, default=datetime.utcnow)
    onayTarihi = db.Column(db.DateTime)
    faturaURL = db.Column(db.String(255))
    
    def to_dict(self):
        return {
            'odemeID': self.odemeID,
            'rezervasyonID': self.rezervasyonID,
            'seferID': self.seferID,
            'tutar': float(self.tutar) if self.tutar else 0,
            'netTutar': float(self.netTutar) if self.netTutar else 0,
            'odemeTipi': self.odemeTipi,
            'odemeDurumu': self.odemeDurumu,
            'islemTarihi': self.islemTarihi.isoformat() if self.islemTarihi else None
        }

class Yorumlar(db.Model):
    __tablename__ = 'Yorumlar'
    
    yorumID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    rezervasyonID = db.Column(db.Integer, db.ForeignKey('Rezervasyonlar.rezervasyonID'), nullable=False)
    degerlendiren KullaniciID = db.Column(db.Integer, db.ForeignKey('Kullanicilar.kullaniciID'), nullable=False)
    degerlendirilenKullaniciID = db.Column(db.Integer, db.ForeignKey('Kullanicilar.kullaniciID'), nullable=False)
    seferID = db.Column(db.Integer, db.ForeignKey('Seferler.seferID'), nullable=False)
    puan = db.Column(db.SmallInteger, nullable=False)
    yorum = db.Column(db.Text)
    kategoriler = db.Column(db.JSON)
    yorumTarihi = db.Column(db.DateTime, default=datetime.utcnow)
    gorunurluk = db.Column(db.Enum('Genel', 'Sadece Kullanıcı', 'Gizli'), default='Genel')
    
    def to_dict(self):
        return {
            'yorumID': self.yorumID,
            'rezervasyonID': self.rezervasyonID,
            'degerlendiren KullaniciID': self.degerlendiren KullaniciID,
            'degerlendirilenKullaniciID': self.degerlendirilenKullaniciID,
            'puan': self.puan,
            'yorum': self.yorum,
            'yorumTarihi': self.yorumTarihi.isoformat() if self.yorumTarihi else None
        }

class Mesajlar(db.Model):
    __tablename__ = 'Mesajlar'
    
    mesajID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    seferID = db.Column(db.Integer, db.ForeignKey('Seferler.seferID'), nullable=False)
    gonderenID = db.Column(db.Integer, db.ForeignKey('Kullanicilar.kullaniciID'), nullable=False)
    mesajMetni = db.Column(db.Text, nullable=False)
    gonderimZamani = db.Column(db.DateTime, default=datetime.utcnow)
    okunduMu = db.Column(db.Boolean, default=False)
    mesajTipi = db.Column(db.Enum('Metin', 'Konum', 'Dosya'), default='Metin')
    dosyaURL = db.Column(db.String(255))
    
    # Relationships
    gonderen = db.relationship('Kullanicilar', foreign_keys=[gonderenID])
    
    def to_dict(self):
        return {
            'mesajID': self.mesajID,
            'seferID': self.seferID,
            'gonderenID': self.gonderenID,
            'mesajMetni': self.mesajMetni,
            'gonderimZamani': self.gonderimZamani.isoformat() if self.gonderimZamani else None,
            'okunduMu': self.okunduMu,
            'mesajTipi': self.mesajTipi
        }
