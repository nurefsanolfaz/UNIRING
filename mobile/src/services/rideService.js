import api from './api';

// ============================================
// Sefer (Ride) İşlemleri - Database Schema'ya Uyumlu
// Backend API Endpoints (Arkadaşın yapıyor):
// GET /api/seferler - Tüm aktif seferler
// GET /api/seferler/:id - Tek sefer detayı
// POST /api/seferler - Yeni sefer oluştur
// GET /api/seferler/benim - Kullanıcının oluşturduğu seferler
// ============================================

// Tüm Aktif Seferleri Listele
export const getAllRides = async () => {
  try {
    const response = await api.get('/api/seferler');
    return response.data;
  } catch (error) {
    throw error.response?.data || { message: 'Seferler yüklenemedi' };
  }
};

// Sefer Detayı Getir
export const getRideById = async (seferID) => {
  try {
    const response = await api.get(`/api/seferler/${seferID}`);
    return response.data;
  } catch (error) {
    throw error.response?.data || { message: 'Sefer detayı yüklenemedi' };
  }
};

// Yeni Sefer Oluştur
export const createRide = async (seferData) => {
  try {
    const response = await api.post('/api/seferler', seferData);
    return response.data;
  } catch (error) {
    throw error.response?.data || { message: 'Sefer oluşturulamadı' };
  }
};

// Kullanıcının Oluşturduğu Seferler
export const getMyCreatedRides = async () => {
  try {
    const response = await api.get('/api/seferler/benim');
    return response.data;
  } catch (error) {
    throw error.response?.data || { message: 'Seferler yüklenemedi' };
  }
};

// ============================================
// Rezervasyon (Booking) İşlemleri
// Backend API Endpoints:
// POST /api/rezervasyonlar - Yeni rezervasyon
// GET /api/rezervasyonlar/benim - Kullanıcının rezervasyonları
// PUT /api/rezervasyonlar/:id/iptal - Rezervasyon iptali
// ============================================

// Rezervasyon Oluştur
export const createBooking = async (rezervasyonData) => {
  try {
    const response = await api.post('/api/rezervasyonlar', rezervasyonData);
    return response.data;
  } catch (error) {
    throw error.response?.data || { message: 'Rezervasyon oluşturulamadı' };
  }
};

// Kullanıcının Rezervasyonları
export const getMyBookings = async () => {
  try {
    const response = await api.get('/api/rezervasyonlar/benim');
    return response.data;
  } catch (error) {
    throw error.response?.data || { message: 'Rezervasyonlar yüklenemedi' };
  }
};

// Rezervasyon İptali
export const cancelBooking = async (rezervasyonID, iptalNedeni) => {
  try {
    const response = await api.put(`/api/rezervasyonlar/${rezervasyonID}/iptal`, { iptalNedeni });
    return response.data;
  } catch (error) {
    throw error.response?.data || { message: 'Rezervasyon iptal edilemedi' };
  }
};

// ============================================
// Sefer Arama & Filtreleme
// Backend API Endpoint:
// POST /api/seferler/ara - Sefer arama
// ============================================

// Sefer Ara
export const searchRides = async (aramaKriterleri) => {
  try {
    const response = await api.post('/api/seferler/ara', aramaKriterleri);
    return response.data;
  } catch (error) {
    throw error.response?.data || { message: 'Arama başarısız' };
  }
};

