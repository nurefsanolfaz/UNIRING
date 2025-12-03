// API Yapılandırması
// Backend Flask sunucunuzun adresi
// Web'de test: http://localhost:5000
// Telefonda test: http://BILGISAYAR_IP_ADRESI:5000

// Web tarayıcısında test için localhost kullan
export const API_BASE_URL = 'http://localhost:5001';

// Renk Paleti - Modern Mavi Tema
export const COLORS = {
  primary: '#1976D2',        // Mavi - Ana renk (butonlar, linkler)
  secondary: '#42A5F5',      // Açık Mavi - İkincil vurgular
  background: '#F5F9FC',     // Çok açık mavi - Sayfa arka planı
  surface: '#FFFFFF',        // Beyaz - Kart arka planı
  error: '#D32F2F',          // Kırmızı - Hata mesajları
  text: '#212121',           // Koyu gri - Ana metin
  textSecondary: '#757575',  // Gri - İkincil metin
  border: '#E3F2FD',         // Açık mavi - Kenarlıklar
};

// Tipografi - Modern Font Sistemi
export const FONTS = {
  // iOS: San Francisco, Android: Roboto
  regular: {
    fontFamily: 'System',
    fontWeight: '400',
  },
  medium: {
    fontFamily: 'System',
    fontWeight: '500',
  },
  semiBold: {
    fontFamily: 'System',
    fontWeight: '600',
  },
  bold: {
    fontFamily: 'System',
    fontWeight: '700',
  },
};

// Uygulama Sabitleri
export const APP_NAME = 'UNIRING';
export const APP_VERSION = '1.0.0';
