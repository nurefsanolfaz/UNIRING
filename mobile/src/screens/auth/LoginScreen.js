import React, { useState } from 'react';
import { View, StyleSheet, Alert, KeyboardAvoidingView, Platform } from 'react-native';
import { TextInput, Button, Text, Title, Snackbar } from 'react-native-paper';
import { login } from '../../services/authService';
import { useAuth } from '../../context/AuthContext';
import { COLORS, FONTS } from '../../constants/config';

export default function LoginScreen({ navigation }) {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [snackbarVisible, setSnackbarVisible] = useState(false);
  const [snackbarMessage, setSnackbarMessage] = useState('');
  const { login: authLogin } = useAuth();

  const handleLogin = async () => {
    if (!email || !password) {
      setSnackbarMessage('⚠️ Lütfen tüm alanları doldurun');
      setSnackbarVisible(true);
      return;
    }

    setLoading(true);
    try {
      const { user, token } = await login(email, password);
      authLogin(user, token);
      setSnackbarMessage('✅ Giriş yapıldı!');
      setSnackbarVisible(true);
    } catch (error) {
      console.error('Login hatası:', error);
      setSnackbarMessage('❌ ' + (error.message || 'Giriş başarısız'));
      setSnackbarVisible(true);
    } finally {
      setLoading(false);
    }
  };

  return (
    <KeyboardAvoidingView 
      behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
      style={styles.container}
    >
      <View style={styles.content}>
        <Title style={styles.title}>UNIRING</Title>
        <Text style={styles.subtitle}>Üniversiteler Arası Carpooling</Text>

        <TextInput
          label="E-posta"
          value={email}
          onChangeText={setEmail}
          mode="outlined"
          keyboardType="email-address"
          autoCapitalize="none"
          style={styles.input}
          textColor="#000000"
          theme={{ colors: { primary: COLORS.primary, text: '#000000' } }}
        />

        <TextInput
          label="Şifre"
          value={password}
          onChangeText={setPassword}
          mode="outlined"
          secureTextEntry
          style={styles.input}
          textColor="#000000"
          theme={{ colors: { primary: COLORS.primary, text: '#000000' } }}
        />

        <Button
          mode="contained"
          onPress={handleLogin}
          loading={loading}
          disabled={loading}
          style={styles.button}
          buttonColor={COLORS.primary}
        >
          Giriş Yap
        </Button>

        <Button
          mode="text"
          onPress={() => navigation.navigate('Register')}
          style={styles.registerButton}
        >
          Hesabın yok mu? Kayıt Ol
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
    </KeyboardAvoidingView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: COLORS.background,
  },
  content: {
    flex: 1,
    justifyContent: 'center',
    padding: 20,
  },
  title: {
    fontSize: 36,
    ...FONTS.bold,
    textAlign: 'center',
    marginBottom: 10,
    color: COLORS.primary,
  },
  subtitle: {
    fontSize: 16,
    ...FONTS.medium,
    textAlign: 'center',
    marginBottom: 40,
    color: COLORS.textSecondary,
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
  registerButton: {
    marginTop: 10,
  },
  snackbar: {
    backgroundColor: '#D32F2F',
    marginBottom: 20,
  },
});
