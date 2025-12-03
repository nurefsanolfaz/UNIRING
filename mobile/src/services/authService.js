import api from './api';
import AsyncStorage from '@react-native-async-storage/async-storage';

// Kullanıcı Kayıt
export const register = async (userData) => {
  try {
    const response = await api.post('/api/auth/register', userData);
    return response.data;
  } catch (error) {
    throw error.response?.data || { message: 'Kayıt başarısız' };
  }
};

// Kullanıcı Giriş
export const login = async (email, password) => {
  try {
    const response = await api.post('/api/auth/login', { email, sifre: password });
    const data = response.data || {};

    // Backend tarafı kullanıcı objesini "kullanici" anahtarı ile döndürüyor
    const user = data.user || data.kullanici;
    if (!user) {
      throw { message: 'Kullanıcı bilgisi alınamadı' };
    }

    // Henüz JWT olmadığı için kullanıcı ID'sini pseudo token olarak tutuyoruz
    const token = data.token || String(user.kullaniciID);

    await AsyncStorage.setItem('userData', JSON.stringify(user));
    await AsyncStorage.setItem('userToken', token);

    return { ...data, user, token };
  } catch (error) {
    throw error.response?.data || { message: 'Giriş başarısız' };
  }
};

// Çıkış
export const logout = async () => {
  await AsyncStorage.removeItem('userToken');
  await AsyncStorage.removeItem('userData');
};

// Kullanıcı bilgilerini al
export const getUserData = async () => {
  try {
    const userData = await AsyncStorage.getItem('userData');
    return userData ? JSON.parse(userData) : null;
  } catch (error) {
    return null;
  }
};

// Token kontrol
export const checkAuth = async () => {
  const [token, userData] = await Promise.all([
    AsyncStorage.getItem('userToken'),
    AsyncStorage.getItem('userData')
  ]);
  return Boolean(token && userData);
};
