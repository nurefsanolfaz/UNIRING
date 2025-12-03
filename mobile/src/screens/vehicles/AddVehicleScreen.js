import React, { useState } from 'react';
import { 
  View, 
  StyleSheet, 
  ScrollView, 
  Alert,
  KeyboardAvoidingView,
  Platform,
  ToastAndroid
} from 'react-native';
import { 
  Text, 
  TextInput, 
  Button, 
  Card,
  SegmentedButtons,
  HelperText
} from 'react-native-paper';
import { MaterialCommunityIcons as Icon } from '@expo/vector-icons';
import { useAuth } from '../../context/AuthContext';
import vehicleService from '../../services/vehicleService';
import { COLORS, FONTS } from '../../constants/config';

const CURRENT_YEAR = new Date().getFullYear();
const CAR_BRANDS = [
  'Toyota', 'Honda', 'Volkswagen', 'Ford', 'Renault',
  'Fiat', 'Hyundai', 'Mercedes', 'BMW', 'Audi',
  'Opel', 'Peugeot', 'Nissan', 'Mazda', 'Skoda'
];

export default function AddVehicleScreen({ navigation }) {
  const { user } = useAuth();
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState({
    plaka: '',
    marka: '',
    model: '',
    renk: '',
    yil: '',
    yolcuKapasitesi: '4',
    sigortaBitisTarihi: '',
  });

  const [errors, setErrors] = useState({});

  const validateForm = () => {
    const newErrors = {};

    // Plaka kontrolü (XX YYY ZZ formatı)
    const plakaRegex = /^\d{2}\s?[A-Z]{1,3}\s?\d{1,4}$/i;
    if (!formData.plaka.trim()) {
      newErrors.plaka = 'Plaka zorunludur';
    } else if (!plakaRegex.test(formData.plaka.trim())) {
      newErrors.plaka = 'Geçerli bir plaka giriniz (örn: 34 ABC 123)';
    }

    // Marka kontrolü
    if (!formData.marka.trim()) {
      newErrors.marka = 'Marka zorunludur';
    }

    // Model kontrolü
    if (!formData.model.trim()) {
      newErrors.model = 'Model zorunludur';
    }

    // Yıl kontrolü
    if (formData.yil) {
      const year = parseInt(formData.yil);
      if (isNaN(year) || year < 1990 || year > CURRENT_YEAR + 1) {
        newErrors.yil = `Yıl 1990 ile ${CURRENT_YEAR + 1} arasında olmalı`;
      }
    }

    // Kapasite kontrolü
    const kapasite = parseInt(formData.yolcuKapasitesi);
    if (isNaN(kapasite) || kapasite < 1 || kapasite > 8) {
      newErrors.yolcuKapasitesi = 'Kapasite 1-8 arasında olmalı';
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async () => {
    if (!validateForm()) {
      Alert.alert('Hata', 'Lütfen tüm zorunlu alanları doğru şekilde doldurun');
      return;
    }

    setLoading(true);

    try {
      const vehicleData = {
        sahipID: user.kullaniciID,
        plaka: formData.plaka.trim().toUpperCase(),
        marka: formData.marka.trim(),
        model: formData.model.trim(),
        renk: formData.renk.trim() || null,
        yil: formData.yil ? parseInt(formData.yil) : null,
        yolcuKapasitesi: parseInt(formData.yolcuKapasitesi),
        sigortaBitisTarihi: formData.sigortaBitisTarihi || null,
      };

      const response = await vehicleService.addVehicle(vehicleData);

      if (response.success) {
        // Platform'a göre bildirim göster
        if (Platform.OS === 'android') {
          ToastAndroid.show(
            '✅ Araç başarıyla eklendi!',
            ToastAndroid.LONG
          );
        }
        
        Alert.alert(
          '🎉 Başarılı!',
          'Aracınız başarıyla eklendi!\n\nYönetici onayından sonra sefer oluşturabilirsiniz.',
          [
            {
              text: 'Araçlarımı Görüntüle',
              onPress: () => navigation.goBack(),
              style: 'default'
            },
          ],
          { cancelable: false }
        );
      }
    } catch (error) {
      console.error('Araç ekleme hatası:', error);
      
      const errorMessage = error.response?.data?.message || 'Araç eklenirken bir hata oluştu. Lütfen tekrar deneyin.';
      
      Alert.alert(
        '❌ Hata',
        errorMessage,
        [{ text: 'Tamam', style: 'cancel' }]
      );
    } finally {
      setLoading(false);
    }
  };

  const updateFormData = (field, value) => {
    setFormData({ ...formData, [field]: value });
    // Clear error when user starts typing
    if (errors[field]) {
      setErrors({ ...errors, [field]: null });
    }
  };

  return (
    <KeyboardAvoidingView
      style={styles.container}
      behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
    >
      <ScrollView
        style={styles.scrollView}
        contentContainerStyle={styles.scrollContent}
        keyboardShouldPersistTaps="handled"
      >
        <View style={styles.header}>
          <Icon name="car" size={48} color={COLORS.primary} />
          <Text style={styles.title}>Yeni Araç Ekle</Text>
          <Text style={styles.subtitle}>
            Aracınızın bilgilerini girerek sefer oluşturabilirsiniz
          </Text>
        </View>

        <Card style={styles.card} mode="elevated">
          <Card.Content>
            {/* Plaka */}
            <TextInput
              label="Plaka *"
              value={formData.plaka}
              onChangeText={(text) => updateFormData('plaka', text)}
              mode="outlined"
              style={styles.input}
              placeholder="34 ABC 123"
              autoCapitalize="characters"
              maxLength={11}
              error={!!errors.plaka}
              left={<TextInput.Icon icon="card-account-details" />}
            />
            {errors.plaka && <HelperText type="error">{errors.plaka}</HelperText>}

            {/* Marka */}
            <TextInput
              label="Marka *"
              value={formData.marka}
              onChangeText={(text) => updateFormData('marka', text)}
              mode="outlined"
              style={styles.input}
              placeholder="Toyota"
              error={!!errors.marka}
              left={<TextInput.Icon icon="car" />}
            />
            {errors.marka && <HelperText type="error">{errors.marka}</HelperText>}

            {/* Model */}
            <TextInput
              label="Model *"
              value={formData.model}
              onChangeText={(text) => updateFormData('model', text)}
              mode="outlined"
              style={styles.input}
              placeholder="Corolla"
              error={!!errors.model}
              left={<TextInput.Icon icon="car-info" />}
            />
            {errors.model && <HelperText type="error">{errors.model}</HelperText>}

            {/* Renk */}
            <TextInput
              label="Renk (Opsiyonel)"
              value={formData.renk}
              onChangeText={(text) => updateFormData('renk', text)}
              mode="outlined"
              style={styles.input}
              placeholder="Beyaz"
              left={<TextInput.Icon icon="palette" />}
            />

            {/* Yıl */}
            <TextInput
              label="Yıl (Opsiyonel)"
              value={formData.yil}
              onChangeText={(text) => updateFormData('yil', text)}
              mode="outlined"
              style={styles.input}
              placeholder={CURRENT_YEAR.toString()}
              keyboardType="numeric"
              maxLength={4}
              error={!!errors.yil}
              left={<TextInput.Icon icon="calendar" />}
            />
            {errors.yil && <HelperText type="error">{errors.yil}</HelperText>}

            {/* Yolcu Kapasitesi */}
            <Text style={styles.label}>Yolcu Kapasitesi *</Text>
            <SegmentedButtons
              value={formData.yolcuKapasitesi}
              onValueChange={(value) => updateFormData('yolcuKapasitesi', value)}
              style={styles.segmentedButtons}
              buttons={[
                { value: '2', label: '2', icon: 'seat-passenger' },
                { value: '3', label: '3', icon: 'seat-passenger' },
                { value: '4', label: '4', icon: 'seat-passenger' },
                { value: '5', label: '5', icon: 'seat-passenger' },
                { value: '6', label: '6+', icon: 'seat-passenger' },
              ]}
            />

            {/* Sigorta Bitiş Tarihi */}
            <TextInput
              label="Sigorta Bitiş Tarihi (Opsiyonel)"
              value={formData.sigortaBitisTarihi}
              onChangeText={(text) => updateFormData('sigortaBitisTarihi', text)}
              mode="outlined"
              style={styles.input}
              placeholder="YYYY-MM-DD"
              left={<TextInput.Icon icon="shield-check" />}
            />
            <HelperText type="info">
              Örnek: 2025-12-31
            </HelperText>
          </Card.Content>
        </Card>

        <View style={styles.infoBox}>
          <Icon name="information" size={20} color={COLORS.primary} />
          <Text style={styles.infoText}>
            Aracınız eklendikten sonra yönetici onayı bekleyecektir.
            Onay sonrası sefer oluşturabilirsiniz.
          </Text>
        </View>

        <Button
          mode="contained"
          onPress={handleSubmit}
          loading={loading}
          disabled={loading}
          style={styles.submitButton}
          icon="check"
        >
          Aracı Ekle
        </Button>

        <Button
          mode="text"
          onPress={() => navigation.goBack()}
          disabled={loading}
          style={styles.cancelButton}
        >
          İptal
        </Button>
      </ScrollView>
    </KeyboardAvoidingView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5F9FC',
  },
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    padding: 16,
    paddingBottom: 40,
  },
  header: {
    alignItems: 'center',
    marginBottom: 24,
    paddingTop: 8,
  },
  title: {
    ...FONTS.bold,
    fontSize: 24,
    color: COLORS.text,
    marginTop: 12,
    marginBottom: 8,
  },
  subtitle: {
    ...FONTS.regular,
    fontSize: 14,
    color: COLORS.textSecondary,
    textAlign: 'center',
    paddingHorizontal: 32,
  },
  card: {
    borderRadius: 16,
    backgroundColor: '#FFFFFF',
    marginBottom: 16,
    elevation: 2,
  },
  input: {
    marginBottom: 8,
    backgroundColor: '#FFFFFF',
  },
  label: {
    ...FONTS.semiBold,
    fontSize: 14,
    color: COLORS.text,
    marginBottom: 8,
    marginTop: 8,
  },
  segmentedButtons: {
    marginBottom: 16,
  },
  infoBox: {
    flexDirection: 'row',
    backgroundColor: '#E3F2FD',
    padding: 12,
    borderRadius: 12,
    marginBottom: 24,
    alignItems: 'flex-start',
  },
  infoText: {
    ...FONTS.regular,
    fontSize: 13,
    color: COLORS.text,
    marginLeft: 8,
    flex: 1,
    lineHeight: 18,
  },
  submitButton: {
    paddingVertical: 8,
    borderRadius: 12,
    marginBottom: 12,
  },
  cancelButton: {
    borderRadius: 12,
  },
});
