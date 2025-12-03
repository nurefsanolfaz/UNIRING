import React, { useState, useEffect } from 'react';
import { View, StyleSheet, ScrollView, Alert } from 'react-native';
import { TextInput, Button, Text, Title, HelperText, Snackbar, Surface, Menu, Divider } from 'react-native-paper';
import { createRide } from '../../services/rideService';
import vehicleService from '../../services/vehicleService';
import { COLORS } from '../../constants/config';
import { useAuth } from '../../context/AuthContext';
import { MaterialCommunityIcons as Icon } from '@expo/vector-icons';

const INITIAL_FORM_STATE = {
  startLocation: '',
  endLocation: '',
  departureTime: '',
  availableSeats: '3',
  pricePerSeat: '',
  vehicleId: '1',
  description: '',
  hasLuggage: true,
  hasAC: true,
};

const INPUT_THEME = {
  colors: {
    primary: COLORS.primary,
    outline: '#dfe3eb',
    surfaceVariant: '#fff',
    background: '#fff',
    onSurfaceVariant: COLORS.text,
  },
};

export default function CreateRideScreen({ navigation }) {
  const [formData, setFormData] = useState(INITIAL_FORM_STATE);
  const [loading, setLoading] = useState(false);
  const [errorMessage, setErrorMessage] = useState('');
  const [snackbar, setSnackbar] = useState({ visible: false, message: '', action: undefined });
  const { user } = useAuth();
  const [vehicles, setVehicles] = useState([]);
  const [vehicleMenuVisible, setVehicleMenuVisible] = useState(false);
  const [selectedVehicle, setSelectedVehicle] = useState(null);

  useEffect(() => {
    loadVehicles();
  }, []);

  const loadVehicles = async () => {
    try {
      const userId = getUserId();
      if (!userId) return;

      const response = await vehicleService.getMyVehicles(userId);
      if (response.success) {
        // Sadece onaylanmış araçları göster
        const approvedVehicles = response.araclar.filter(v => v.onayDurumu === 'Onaylandı');
        setVehicles(approvedVehicles);
        
        if (approvedVehicles.length > 0) {
          setSelectedVehicle(approvedVehicles[0]);
          setFormData({ ...formData, vehicleId: approvedVehicles[0].aracID.toString() });
        }
      }
    } catch (error) {
      console.error('Araç yükleme hatası:', error);
    }
  };

  const getUserId = () => {
    if (!user) return null;
    return (
      user.kullaniciID ||
      user.id ||
      user.ID ||
      user.userId ||
      user?.kullanici?.kullaniciID ||
      null
    );
  };

  const showSnackbar = (message, action) => {
    setSnackbar({ visible: true, message, action });
  };

  const navigateToMyRides = () => {
    const tabNavigator = navigation.getParent?.();
    if (tabNavigator?.navigate) {
      tabNavigator.navigate('MyRidesTab', {
        screen: 'MyRidesMain',
      });
    } else if (navigation.canGoBack()) {
      navigation.navigate('MyRidesMain');
    }
  };

  const handleCreateRide = async () => {
    setErrorMessage('');

    if (!formData.startLocation || !formData.endLocation) {
      setErrorMessage('Başlangıç ve varış noktaları zorunludur.');
      return;
    }

    if (!formData.departureTime) {
      setErrorMessage('Lütfen kalkış zamanı belirtin.');
      return;
    }

    const userId = getUserId();
    if (!userId) {
      Alert.alert('Hata', 'Kullanıcı bilgisine ulaşılamadı. Tekrar giriş yapmayı deneyin.');
      return;
    }

    // Araç kontrolü
    if (!selectedVehicle) {
      Alert.alert(
        'Araç Seçiniz',
        'Sefer oluşturmak için önce bir araç seçmelisiniz.',
        [
          { text: 'İptal', style: 'cancel' },
          { 
            text: 'Araç Ekle', 
            onPress: () => navigation.navigate('Profile', { screen: 'AddVehicle' })
          }
        ]
      );
      return;
    }

    const departure = new Date(formData.departureTime);
    if (Number.isNaN(departure.getTime())) {
      setErrorMessage('Kalkış zamanı formatı geçersiz. Örn: 2025-12-05 15:30');
      return;
    }

    const seats = parseInt(formData.availableSeats, 10);
    if (!Number.isInteger(seats) || seats <= 0) {
      setErrorMessage('Boş koltuk sayısı pozitif bir sayı olmalı.');
      return;
    }

    const price = parseFloat(formData.pricePerSeat);
    if (Number.isNaN(price) || price <= 0) {
      setErrorMessage('Koltuk fiyatı pozitif bir değer olmalı.');
      return;
    }

    const payload = {
      olusturanKullaniciID: userId,
      aracID: selectedVehicle.aracID,
      seferTipi: 'Araç Paylaşımı',
      katilimKapsami: 'Tüm Üniversiteler',
      seferTarihi: departure.toISOString().split('T')[0],
      kalkisZamani: departure.toISOString(),
      maxKapasite: seats,
      temelFiyat: price,
      bagajAlaniVar: formData.hasLuggage,
      klimaVar: formData.hasAC,
      aciklama: formData.description,
      guzergahNoktalari: [
        {
          konumAdi: formData.startLocation,
          latitude: null,
          longitude: null,
          siraNo: 1,
        },
        {
          konumAdi: formData.endLocation,
          latitude: null,
          longitude: null,
          siraNo: 2,
        },
      ],
    };

    setLoading(true);
    console.log('Sefer oluşturma isteği gönderiliyor:', payload);
    try {
      await createRide(payload);
      setFormData(INITIAL_FORM_STATE);
      showSnackbar('Sefer başarıyla oluşturuldu!', {
        label: 'Seferlerim',
        onPress: navigateToMyRides,
      });
    } catch (error) {
      console.error('Sefer oluşturma hatası:', error);
      const message = error?.error || error?.message || 'Sefer oluşturulamadı';
      setErrorMessage(message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <ScrollView style={styles.container}>
      <View style={styles.content}>
        <Title style={styles.title}>Yeni Yolculuk</Title>

        {!!errorMessage && (
          <HelperText type="error" style={styles.helperText}>
            {errorMessage}
          </HelperText>
        )}

        <Surface style={styles.formCard} elevation={2}>
          {/* Araç Seçimi */}
          {vehicles.length > 0 ? (
            <Menu
              visible={vehicleMenuVisible}
              onDismiss={() => setVehicleMenuVisible(false)}
              anchor={
                <Button
                  mode="outlined"
                  onPress={() => setVehicleMenuVisible(true)}
                  style={styles.vehicleButton}
                  icon="car"
                  contentStyle={styles.vehicleButtonContent}
                >
                  {selectedVehicle 
                    ? `${selectedVehicle.marka} ${selectedVehicle.model} - ${selectedVehicle.plaka}`
                    : 'Araç Seçin'}
                </Button>
              }
            >
              {vehicles.map((vehicle) => (
                <Menu.Item
                  key={vehicle.aracID}
                  onPress={() => {
                    setSelectedVehicle(vehicle);
                    setFormData({ ...formData, vehicleId: vehicle.aracID.toString() });
                    setVehicleMenuVisible(false);
                  }}
                  title={`${vehicle.marka} ${vehicle.model}`}
                  leadingIcon="car"
                />
              ))}
              <Divider />
              <Menu.Item
                onPress={() => {
                  setVehicleMenuVisible(false);
                  navigation.navigate('Profile', { screen: 'AddVehicle' });
                }}
                title="Yeni Araç Ekle"
                leadingIcon="plus"
              />
            </Menu>
          ) : (
            <Button
              mode="outlined"
              onPress={() => navigation.navigate('Profile', { screen: 'AddVehicle' })}
              style={styles.vehicleButton}
              icon="plus-circle"
              textColor="#F44336"
            >
              Önce Araç Ekleyin
            </Button>
          )}

          <TextInput
            label="Başlangıç Noktası *"
            value={formData.startLocation}
            onChangeText={(text) => setFormData({ ...formData, startLocation: text })}
            mode="outlined"
            style={styles.input}
            placeholder="Örn: Ankara"
            textColor={COLORS.text || '#1F2933'}
            contentStyle={styles.inputContent}
            theme={INPUT_THEME}
          />

          <TextInput
            label="Varış Noktası *"
            value={formData.endLocation}
            onChangeText={(text) => setFormData({ ...formData, endLocation: text })}
            mode="outlined"
            style={styles.input}
            placeholder="Örn: İstanbul"
            textColor={COLORS.text || '#1F2933'}
            contentStyle={styles.inputContent}
            theme={INPUT_THEME}
          />

          <TextInput
            label="Kalkış Zamanı * (YYYY-MM-DD HH:MM)"
            value={formData.departureTime}
            onChangeText={(text) => setFormData({ ...formData, departureTime: text })}
            mode="outlined"
            style={styles.input}
            placeholder="2025-12-05 15:30"
            textColor={COLORS.text || '#1F2933'}
            contentStyle={styles.inputContent}
            theme={INPUT_THEME}
            keyboardType="default"
          />

          <TextInput
            label="Boş Koltuk Sayısı *"
            value={formData.availableSeats}
            onChangeText={(text) => setFormData({ ...formData, availableSeats: text })}
            mode="outlined"
            keyboardType="number-pad"
            style={styles.input}
            textColor={COLORS.text || '#1F2933'}
            contentStyle={styles.inputContent}
            theme={INPUT_THEME}
          />

          <TextInput
            label="Koltuk Başı Fiyat (TL) *"
            value={formData.pricePerSeat}
            onChangeText={(text) => setFormData({ ...formData, pricePerSeat: text })}
            mode="outlined"
            keyboardType="decimal-pad"
            style={styles.input}
            placeholder="150.00"
            textColor={COLORS.text || '#1F2933'}
            contentStyle={styles.inputContent}
            theme={INPUT_THEME}
          />

          <TextInput
            label="Açıklama"
            value={formData.description}
            onChangeText={(text) => setFormData({ ...formData, description: text })}
            mode="outlined"
            multiline
            numberOfLines={3}
            style={styles.input}
            placeholder="Yolculuk hakkında ek bilgiler..."
            textColor={COLORS.text || '#1F2933'}
            contentStyle={[styles.inputContent, styles.textAreaContent]}
            theme={INPUT_THEME}
          />
        </Surface>

        <Button
          mode="contained"
          onPress={handleCreateRide}
          loading={loading}
          disabled={loading}
          style={styles.button}
          buttonColor={COLORS.primary}
        >
          Yolculuk Oluştur
        </Button>

        <Button
          mode="outlined"
          onPress={() => navigation.goBack()}
          style={styles.cancelButton}
        >
          İptal
        </Button>
      </View>
      <Snackbar
        visible={snackbar.visible}
        onDismiss={() => setSnackbar({ visible: false, message: '', action: undefined })}
        duration={2000}
        style={styles.snackbar}
        action={snackbar.action}
      >
        {snackbar.message}
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
    paddingTop: 20,
  },
  formCard: {
    borderRadius: 16,
    padding: 12,
    backgroundColor: '#fff',
    marginBottom: 10,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    textAlign: 'center',
    marginBottom: 30,
    color: COLORS.primary,
  },
  helperText: {
    marginBottom: 16,
  },
  vehicleButton: {
    marginBottom: 15,
    borderColor: COLORS.primary,
    borderWidth: 1.5,
  },
  vehicleButtonContent: {
    height: 50,
  },
  input: {
    marginBottom: 15,
  },
  inputContent: {
    backgroundColor: '#f9fafb',
  },
  textAreaContent: {
    minHeight: 90,
    textAlignVertical: 'top',
  },
  button: {
    marginTop: 10,
    paddingVertical: 8,
  },
  cancelButton: {
    marginTop: 10,
    paddingVertical: 8,
  },
  snackbar: {
    marginHorizontal: 20,
    marginBottom: 30,
    borderRadius: 12,
    backgroundColor: COLORS.primary,
  },
});
