import React, { useState, useEffect } from 'react';
import { View, StyleSheet, ScrollView, Alert, Platform } from 'react-native';
import { TextInput, Button, Text, Title, HelperText, Snackbar, Surface, Chip } from 'react-native-paper';
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
  const [selectedVehicle, setSelectedVehicle] = useState(null);

  useEffect(() => {
    loadVehicles();
  }, []);

  useEffect(() => {
    // Navigation focus olduğunda araçları yeniden yükle
    const unsubscribe = navigation.addListener('focus', () => {
      loadVehicles();
    });
    return unsubscribe;
  }, [navigation]);

  const loadVehicles = async () => {
    try {
      const userId = getUserId();
      console.log('🔍 Araç yükleniyor, kullanıcı ID:', userId);
      
      if (!userId) {
        console.error('❌ Kullanıcı ID bulunamadı');
        Alert.alert('Hata', 'Kullanıcı bilgisi alınamadı. Lütfen tekrar giriş yapın.');
        return;
      }

      const response = await vehicleService.getMyVehicles(userId);
      console.log('📦 Tam araç yanıtı:', JSON.stringify(response, null, 2));
      
      if (response && response.success) {
        const allVehicles = response.araclar || [];
        console.log('📋 Tüm araçlar:', allVehicles.length, allVehicles);
        
        // Tüm araçları göster (onay durumundan bağımsız)
        setVehicles(allVehicles);
        console.log('✅ Yüklenen araçlar:', allVehicles.length);
        
        if (allVehicles.length > 0) {
          setSelectedVehicle(allVehicles[0]);
          setFormData(prev => ({ ...prev, vehicleId: allVehicles[0].aracID.toString() }));
          console.log('🚗 İlk araç otomatik seçildi:', allVehicles[0].plaka);
        } else {
          console.warn('⚠️ Hiç araç bulunamadı');
        }
      } else {
        console.error('❌ API yanıtı başarısız:', response);
      }
    } catch (error) {
      console.error('❌ Araç yükleme hatası:', error);
      console.error('❌ Hata detayı:', error.response?.data || error.message);
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
    <View style={styles.container}>
      {/* Floating Action Button - Sağ üst köşe */}
      <Button
        mode="contained"
        onPress={handleCreateRide}
        loading={loading}
        disabled={loading}
        style={styles.fab}
        buttonColor={COLORS.primary}
        icon="check"
        contentStyle={styles.fabContent}
      />

      <ScrollView style={styles.scrollView} contentContainerStyle={styles.scrollContent}>
        <View style={styles.content}>
          <Title style={styles.title}>Yeni Yolculuk</Title>

          {!!errorMessage && (
            <HelperText type="error" style={styles.helperText}>
              {errorMessage}
            </HelperText>
          )}

          <Surface style={styles.formCard} elevation={2}>
          {/* Araç Seçimi */}
          <Text style={styles.sectionLabel}>🚗 Araç Seçimi *</Text>
          
          {vehicles.length === 0 ? (
            <View style={styles.noVehicleContainer}>
              <Text style={styles.noVehicleText}>Henüz araç eklemediniz</Text>
              <Button
                mode="contained"
                onPress={() => navigation.navigate('Profile', { screen: 'AddVehicle' })}
                style={styles.addVehicleButton}
                icon="plus-circle"
                buttonColor={COLORS.primary}
              >
                İlk Aracınızı Ekleyin
              </Button>
            </View>
          ) : (
            <>
              <ScrollView horizontal showsHorizontalScrollIndicator={false} style={styles.vehiclesScroll}>
                {vehicles.map((vehicle) => (
                  <Chip
                    key={vehicle.aracID}
                    selected={selectedVehicle?.aracID === vehicle.aracID}
                    onPress={() => {
                      setSelectedVehicle(vehicle);
                      setFormData(prev => ({ ...prev, vehicleId: vehicle.aracID.toString() }));
                      console.log('✅ Araç seçildi:', vehicle.plaka);
                    }}
                    style={[
                      styles.vehicleChip,
                      selectedVehicle?.aracID === vehicle.aracID && styles.vehicleChipSelected
                    ]}
                    selectedColor={COLORS.primary}
                    icon="car"
                  >
                    {vehicle.marka} {vehicle.model} ({vehicle.plaka})
                  </Chip>
                ))}
                <Chip
                  icon="plus"
                  onPress={() => navigation.navigate('Profile', { screen: 'AddVehicle' })}
                  style={styles.addVehicleChip}
                  textStyle={styles.addVehicleText}
                >
                  Yeni Ekle
                </Chip>
              </ScrollView>
              {selectedVehicle && (
                <View style={styles.selectedVehicleInfo}>
                  <Text style={styles.selectedVehicleText}>
                    ✓ Seçilen: {selectedVehicle.marka} {selectedVehicle.model} - {selectedVehicle.plaka}
                  </Text>
                </View>
              )}
            </>
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

          <Text style={styles.sectionLabel}>📅 Kalkış Tarihi *</Text>
          <View style={styles.dateTimeRow}>
            <View style={styles.dateInputWrapper}>
              <TextInput
                label="Tarih"
                value={formData.departureTime.split(' ')[0] || ''}
                onChangeText={(text) => {
                  const time = formData.departureTime.split(' ')[1] || '00:00';
                  setFormData({ ...formData, departureTime: `${text} ${time}` });
                }}
                mode="outlined"
                style={styles.dateInput}
                placeholder="YYYY-MM-DD"
                textColor={COLORS.text || '#1F2933'}
                contentStyle={styles.inputContent}
                theme={INPUT_THEME}
              />
            </View>
            <View style={styles.timeInputWrapper}>
              <TextInput
                label="Saat"
                value={formData.departureTime.split(' ')[1] || ''}
                onChangeText={(text) => {
                  const date = formData.departureTime.split(' ')[0] || '';
                  setFormData({ ...formData, departureTime: `${date} ${text}` });
                }}
                mode="outlined"
                style={styles.timeInput}
                placeholder="HH:MM"
                textColor={COLORS.text || '#1F2933'}
                contentStyle={styles.inputContent}
                theme={INPUT_THEME}
              />
            </View>
          </View>
          <HelperText type="info" style={styles.dateHelper}>
            Örnek: 2025-12-05 15:30
          </HelperText>

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
      </View>
      </ScrollView>

      <Snackbar
        visible={snackbar.visible}
        onDismiss={() => setSnackbar({ visible: false, message: '', action: undefined })}
        duration={2000}
        style={styles.snackbar}
        action={snackbar.action}
      >
        {snackbar.message}
      </Snackbar>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: COLORS.background,
  },
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    paddingBottom: 80,
  },
  content: {
    padding: 16,
    paddingTop: 16,
  },
  formCard: {
    borderRadius: 16,
    padding: 12,
    backgroundColor: '#fff',
    marginBottom: 10,
  },
  title: {
    fontSize: 22,
    fontWeight: 'bold',
    textAlign: 'center',
    marginBottom: 20,
    color: COLORS.primary,
  },
  helperText: {
    marginBottom: 12,
  },
  sectionLabel: {
    fontSize: 14,
    fontWeight: '600',
    color: COLORS.text,
    marginBottom: 8,
    marginTop: 5,
  },
  noVehicleContainer: {
    backgroundColor: '#FFF3E0',
    padding: 16,
    borderRadius: 12,
    alignItems: 'center',
    marginBottom: 12,
  },
  noVehicleText: {
    fontSize: 13,
    color: '#E65100',
    marginBottom: 12,
    textAlign: 'center',
  },
  addVehicleButton: {
    marginTop: 5,
  },
  vehiclesScroll: {
    marginBottom: 8,
  },
  vehicleChip: {
    marginRight: 8,
    marginBottom: 6,
    backgroundColor: '#F5F5F5',
  },
  vehicleChipSelected: {
    backgroundColor: COLORS.primary + '20',
    borderColor: COLORS.primary,
    borderWidth: 1.5,
  },
  addVehicleChip: {
    marginRight: 8,
    marginBottom: 6,
    backgroundColor: '#E3F2FD',
    borderColor: COLORS.primary,
    borderWidth: 1,
    borderStyle: 'dashed',
  },
  addVehicleText: {
    color: COLORS.primary,
    fontWeight: '600',
  },
  selectedVehicleInfo: {
    backgroundColor: '#E8F5E9',
    padding: 8,
    borderRadius: 8,
    marginBottom: 8,
  },
  selectedVehicleText: {
    color: '#2E7D32',
    fontSize: 12,
    fontWeight: '600',
  },
  dateTimeRow: {
    flexDirection: 'row',
    gap: 10,
    marginBottom: 5,
  },
  dateInputWrapper: {
    flex: 2,
  },
  dateInput: {
    flex: 1,
  },
  timeInputWrapper: {
    flex: 1,
  },
  timeInput: {
    flex: 1,
  },
  dateHelper: {
    marginTop: 0,
    marginBottom: 8,
    fontSize: 11,
  },
  input: {
    marginBottom: 12,
  },
  inputContent: {
    backgroundColor: '#f9fafb',
  },
  textAreaContent: {
    minHeight: 80,
    textAlignVertical: 'top',
  },
  fab: {
    position: 'absolute',
    right: 20,
    top: 20,
    borderRadius: 30,
    elevation: 6,
    zIndex: 1000,
  },
  fabContent: {
    height: 56,
    width: 56,
  },
  snackbar: {
    marginHorizontal: 20,
    marginBottom: 30,
    borderRadius: 12,
    backgroundColor: COLORS.primary,
  },
});
