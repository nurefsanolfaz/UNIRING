import React, { useState, useEffect } from 'react';
import { 
  View, 
  StyleSheet, 
  ScrollView, 
  Alert,
  KeyboardAvoidingView,
  Platform,
  ActivityIndicator,
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

export default function EditVehicleScreen({ route, navigation }) {
  const { vehicleId } = route.params;
  const { user } = useAuth();
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [formData, setFormData] = useState({
    marka: '',
    model: '',
    renk: '',
    yil: '',
    yolcuKapasitesi: '4',
    sigortaBitisTarihi: '',
  });
  const [errors, setErrors] = useState({});

  useEffect(() => {
    loadVehicleData();
  }, [vehicleId]);

  const loadVehicleData = async () => {
    try {
      setLoading(true);
      const response = await vehicleService.getVehicleById(vehicleId);
      
      if (response.success) {
        const vehicle = response.arac;
        setFormData({
          marka: vehicle.marka || '',
          model: vehicle.model || '',
          renk: vehicle.renk || '',
          yil: vehicle.yil ? vehicle.yil.toString() : '',
          yolcuKapasitesi: vehicle.yolcuKapasitesi.toString(),
          sigortaBitisTarihi: vehicle.sigortaBitisTarihi || '',
        });
      }
    } catch (error) {
      console.error('Araç yükleme hatası:', error);
      Alert.alert('Hata', 'Araç bilgileri yüklenemedi', [
        { text: 'Tamam', onPress: () => navigation.goBack() }
      ]);
    } finally {
      setLoading(false);
    }
  };

  const validateForm = () => {
    const newErrors = {};

    if (!formData.marka.trim()) {
      newErrors.marka = 'Marka zorunludur';
    }

    if (!formData.model.trim()) {
      newErrors.model = 'Model zorunludur';
    }

    if (formData.yil) {
      const year = parseInt(formData.yil);
      if (isNaN(year) || year < 1990 || year > CURRENT_YEAR + 1) {
        newErrors.yil = `Yıl 1990 ile ${CURRENT_YEAR + 1} arasında olmalı`;
      }
    }

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

    setSubmitting(true);

    try {
      const vehicleData = {
        sahipID: user.kullaniciID,
        marka: formData.marka.trim(),
        model: formData.model.trim(),
        renk: formData.renk.trim() || null,
        yil: formData.yil ? parseInt(formData.yil) : null,
        yolcuKapasitesi: parseInt(formData.yolcuKapasitesi),
        sigortaBitisTarihi: formData.sigortaBitisTarihi || null,
      };

      const response = await vehicleService.updateVehicle(vehicleId, vehicleData);

      if (response.success) {
        // Platform'a göre bildirim göster
        if (Platform.OS === 'android') {
          ToastAndroid.show(
            '✅ Araç güncellendi!',
            ToastAndroid.SHORT
          );
        }
        
        Alert.alert(
          '✨ Başarılı!',
          'Araç bilgileri başarıyla güncellendi.',
          [
            { 
              text: 'Tamam', 
              onPress: () => navigation.goBack() 
            }
          ]
        );
      }
    } catch (error) {
      console.error('Araç güncelleme hatası:', error);
      
      Alert.alert(
        '❌ Hata',
        error.response?.data?.message || 'Araç güncellenirken bir hata oluştu',
        [{ text: 'Tamam', style: 'cancel' }]
      );
    } finally {
      setSubmitting(false);
    }
  };

  const updateFormData = (field, value) => {
    setFormData({ ...formData, [field]: value });
    if (errors[field]) {
      setErrors({ ...errors, [field]: null });
    }
  };

  if (loading) {
    return (
      <View style={styles.loadingContainer}>
        <ActivityIndicator size="large" color={COLORS.primary} />
        <Text style={styles.loadingText}>Araç bilgileri yükleniyor...</Text>
      </View>
    );
  }

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
          <Icon name="car-wrench" size={48} color={COLORS.primary} />
          <Text style={styles.title}>Araç Düzenle</Text>
          <Text style={styles.subtitle}>
            Aracınızın bilgilerini güncelleyin
          </Text>
        </View>

        <Card style={styles.card} mode="elevated">
          <Card.Content>
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

        <Button
          mode="contained"
          onPress={handleSubmit}
          loading={submitting}
          disabled={submitting}
          style={styles.submitButton}
          icon="check"
        >
          Değişiklikleri Kaydet
        </Button>

        <Button
          mode="text"
          onPress={() => navigation.goBack()}
          disabled={submitting}
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
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5F9FC',
  },
  loadingText: {
    marginTop: 12,
    ...FONTS.regular,
    color: COLORS.textSecondary,
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
  submitButton: {
    paddingVertical: 8,
    borderRadius: 12,
    marginBottom: 12,
  },
  cancelButton: {
    borderRadius: 12,
  },
});
