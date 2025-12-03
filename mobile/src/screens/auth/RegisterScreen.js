import React, { useState } from 'react';
import { View, StyleSheet, Alert, ScrollView } from 'react-native';
import { TextInput, Button, Text, Title, Snackbar } from 'react-native-paper';
import { register } from '../../services/authService';
import { COLORS, FONTS } from '../../constants/config';

export default function RegisterScreen({ navigation }) {
  const [formData, setFormData] = useState({
    firstName: '',
    lastName: '',
    email: '',
    password: '',
    confirmPassword: '',
    phoneNumber: '',
    universityId: '1', // Şimdilik sabit, sonra dropdown yapılacak
  });
  const [loading, setLoading] = useState(false);
  const [snackbarVisible, setSnackbarVisible] = useState(false);
  const [snackbarMessage, setSnackbarMessage] = useState('');

  const handleRegister = async () => {
    console.log('Kayıt Ol butonuna basıldı!', formData);
    
    // Validasyon
    if (!formData.firstName || !formData.lastName || !formData.email || !formData.password) {
      setSnackbarMessage('⚠️ Lütfen tüm zorunlu alanları doldurun');
      setSnackbarVisible(true);
      return;
    }

    if (formData.password !== formData.confirmPassword) {
      setSnackbarMessage('⚠️ Şifreler eşleşmiyor');
      setSnackbarVisible(true);
      return;
    }

    if (formData.password.length < 6) {
      setSnackbarMessage('⚠️ Şifre en az 6 karakter olmalı');
      setSnackbarVisible(true);
      return;
    }

    setLoading(true);
    try {
      const userData = {
        ad: formData.firstName,
        soyad: formData.lastName,
        email: formData.email,
        sifre: formData.password,
        telefonNo: formData.phoneNumber,
        universiteID: parseInt(formData.universityId),
        cinsiyet: 'Belirtmek İstemiyorum', // Varsayılan değer
        dogumTarihi: '2000-01-01', // Varsayılan değer (daha sonra form'a eklenebilir)
        ogrenciBelgesiURL: 'placeholder.jpg' // Varsayılan değer
      };

      console.log('Backend\'e gönderiliyor:', userData);
      const response = await register(userData);
      console.log('Backend yanıtı:', response);
      
      setSnackbarMessage('✅ Kayıt başarılı! Giriş yapabilirsiniz.');
      setSnackbarVisible(true);
      setTimeout(() => {
        navigation.navigate('Login');
      }, 1500);
    } catch (error) {
      console.error('Kayıt hatası:', error);
      setSnackbarMessage('❌ ' + (error.message || 'Kayıt başarısız'));
      setSnackbarVisible(true);
    } finally {
      setLoading(false);
    }
  };

  return (
    <ScrollView style={styles.container}>
      <View style={styles.content}>
        <Title style={styles.title}>Kayıt Ol</Title>

        <TextInput
          label="Ad *"
          value={formData.firstName}
          onChangeText={(text) => setFormData({ ...formData, firstName: text })}
          mode="outlined"
          style={styles.input}
          textColor="#000000"
          theme={{ colors: { primary: COLORS.primary, text: '#000000' } }}
        />

        <TextInput
          label="Soyad *"
          value={formData.lastName}
          onChangeText={(text) => setFormData({ ...formData, lastName: text })}
          mode="outlined"
          style={styles.input}
          textColor="#000000"
          theme={{ colors: { primary: COLORS.primary, text: '#000000' } }}
        />

        <TextInput
          label="E-posta *"
          value={formData.email}
          onChangeText={(text) => setFormData({ ...formData, email: text })}
          mode="outlined"
          keyboardType="email-address"
          autoCapitalize="none"
          style={styles.input}
          textColor="#000000"
          theme={{ colors: { primary: COLORS.primary, text: '#000000' } }}
        />

        <TextInput
          label="Telefon"
          value={formData.phoneNumber}
          onChangeText={(text) => setFormData({ ...formData, phoneNumber: text })}
          mode="outlined"
          keyboardType="phone-pad"
          style={styles.input}
          textColor="#000000"
          theme={{ colors: { primary: COLORS.primary, text: '#000000' } }}
        />

        <TextInput
          label="Şifre *"
          value={formData.password}
          onChangeText={(text) => setFormData({ ...formData, password: text })}
          mode="outlined"
          secureTextEntry
          style={styles.input}
          textColor="#000000"
          theme={{ colors: { primary: COLORS.primary, text: '#000000' } }}
        />

        <TextInput
          label="Şifre Tekrar *"
          value={formData.confirmPassword}
          onChangeText={(text) => setFormData({ ...formData, confirmPassword: text })}
          mode="outlined"
          secureTextEntry
          style={styles.input}
          textColor="#000000"
          theme={{ colors: { primary: COLORS.primary, text: '#000000' } }}
        />

        <Button
          mode="contained"
          onPress={handleRegister}
          loading={loading}
          disabled={loading}
          style={styles.button}
          buttonColor={COLORS.primary}
        >
          Kayıt Ol
        </Button>

        <Button
          mode="text"
          onPress={() => navigation.goBack()}
          style={styles.backButton}
        >
          Zaten hesabın var mı? Giriş Yap
        </Button>
      </View>
      
      <Snackbar
        visible={snackbarVisible}
        onDismiss={() => setSnackbarVisible(false)}
        duration={3000}
        style={styles.snackbar}
        action={{
          label: 'Tamam',
          onPress: () => setSnackbarVisible(false),
        }}
      >
        {snackbarMessage}
      </Snackbar>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: COLORS.background,
  },
  content: {
    padding: 20,
    paddingTop: 40,
  },
  title: {
    fontSize: 28,
    ...FONTS.bold,
    textAlign: 'center',
    marginBottom: 30,
    color: COLORS.primary,
  },
  input: {
    marginBottom: 15,
    backgroundColor: '#FFFFFF',
  },
  inputText: {
    color: '#000000',
  },
  button: {
    marginTop: 10,
    paddingVertical: 8,
  },
  backButton: {
    marginTop: 10,
  },
  snackbar: {
    backgroundColor: '#D32F2F',
    marginBottom: 20,
  },
});
