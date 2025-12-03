import api from './api';

const vehicleService = {
  // Kullanıcının araçlarını listele
  getMyVehicles: async (userId) => {
    try {
      const response = await api.get(`/api/araclar?kullaniciID=${userId}`);
      return response.data;
    } catch (error) {
      console.error('Araçlar getirme hatası:', error);
      throw error;
    }
  },

  // Araç detayı getir
  getVehicleById: async (vehicleId) => {
    try {
      const response = await api.get(`/api/araclar/${vehicleId}`);
      return response.data;
    } catch (error) {
      console.error('Araç detayı getirme hatası:', error);
      throw error;
    }
  },

  // Yeni araç ekle
  addVehicle: async (vehicleData) => {
    try {
      const response = await api.post('/api/araclar', vehicleData);
      return response.data;
    } catch (error) {
      console.error('Araç ekleme hatası:', error);
      throw error;
    }
  },

  // Araç güncelle
  updateVehicle: async (vehicleId, vehicleData) => {
    try {
      const response = await api.put(`/api/araclar/${vehicleId}`, vehicleData);
      return response.data;
    } catch (error) {
      console.error('Araç güncelleme hatası:', error);
      throw error;
    }
  },

  // Araç sil
  deleteVehicle: async (vehicleId) => {
    try {
      const response = await api.delete(`/api/araclar/${vehicleId}`);
      return response.data;
    } catch (error) {
      console.error('Araç silme hatası:', error);
      throw error;
    }
  },
};

export default vehicleService;
