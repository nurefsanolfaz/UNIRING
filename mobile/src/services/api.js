import axios from 'axios';
import { API_BASE_URL } from '../constants/config';
import AsyncStorage from '@react-native-async-storage/async-storage';

// Axios örneği oluştur
const api = axios.create({
  baseURL: API_BASE_URL,
  timeout: 10000,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Her istekte token'ı ekle (giriş yaptıysa)
api.interceptors.request.use(
  async (config) => {
    const token = await AsyncStorage.getItem('userToken');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    
    // Kullanıcı ID'sini header'a ekle (backend için)
    const userData = await AsyncStorage.getItem('userData');
    if (userData) {
      try {
        const user = JSON.parse(userData);
        config.headers['X-User-ID'] = user.kullaniciID || user.id;
      } catch (e) {
        console.error('User data parse error:', e);
      }
    }
    
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Hata yönetimi
api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response) {
      // Sunucu hata döndü
      console.error('API Error:', error.response.data);
    } else if (error.request) {
      // İstek gönderildi ama cevap yok
      console.error('Network Error:', error.request);
    } else {
      console.error('Error:', error.message);
    }
    return Promise.reject(error);
  }
);

export default api;
