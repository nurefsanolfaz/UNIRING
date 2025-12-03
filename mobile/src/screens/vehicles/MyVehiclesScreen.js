import React, { useState, useEffect } from 'react';
import { 
  View, 
  StyleSheet, 
  ScrollView, 
  Alert,
  RefreshControl 
} from 'react-native';
import { 
  Text, 
  Card, 
  Button, 
  FAB,
  Chip,
  IconButton,
  ActivityIndicator 
} from 'react-native-paper';
import { MaterialCommunityIcons as Icon } from '@expo/vector-icons';
import { useAuth } from '../../context/AuthContext';
import vehicleService from '../../services/vehicleService';
import { COLORS, FONTS } from '../../constants/config';

export default function MyVehiclesScreen({ navigation }) {
  const { user } = useAuth();
  const [vehicles, setVehicles] = useState([]);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);

  useEffect(() => {
    loadVehicles();
  }, []);

  const loadVehicles = async () => {
    try {
      setLoading(true);
      const response = await vehicleService.getMyVehicles(user.kullaniciID);
      
      if (response.success) {
        setVehicles(response.araclar || []);
      }
    } catch (error) {
      console.error('Araç yükleme hatası:', error);
      Alert.alert(
        'Uyarı', 
        'Araçlar yüklenirken bir hata oluştu',
        [{ text: 'Tamam' }]
      );
    } finally {
      setLoading(false);
    }
  };

  const onRefresh = async () => {
    setRefreshing(true);
    await loadVehicles();
    setRefreshing(false);
  };

  const handleDeleteVehicle = (vehicleId, vehicleName) => {
    Alert.alert(
      '🗑️ Aracı Sil',
      `${vehicleName} aracını silmek istediğinize emin misiniz?\n\nBu işlem geri alınamaz.`,
      [
        { 
          text: 'İptal', 
          style: 'cancel' 
        },
        {
          text: 'Sil',
          style: 'destructive',
          onPress: async () => {
            try {
              const response = await vehicleService.deleteVehicle(vehicleId);
              if (response.success) {
                Alert.alert(
                  ' Başarılı', 
                  'Araç başarıyla silindi',
                  [{ text: 'Tamam' }]
                );
                loadVehicles();
              }
            } catch (error) {
              Alert.alert(
                ' Hata', 
                error.response?.data?.message || 'Araç silinemedi. Lütfen tekrar deneyin.',
                [{ text: 'Tamam', style: 'cancel' }]
              );
            }
          },
        },
      ]
    );
  };

  const getStatusColor = (status) => {
    switch (status) {
      case 'Onaylandı':
        return '#4CAF50';
      case 'Beklemede':
        return '#FF9800';
      case 'Reddedildi':
        return '#F44336';
      default:
        return COLORS.textSecondary;
    }
  };

  const getStatusIcon = (status) => {
    switch (status) {
      case 'Onaylandı':
        return 'check-circle';
      case 'Beklemede':
        return 'clock-outline';
      case 'Reddedildi':
        return 'close-circle';
      default:
        return 'help-circle';
    }
  };

  const renderVehicleCard = (vehicle) => (
    <Card key={vehicle.aracID} style={styles.card} mode="elevated">
      <Card.Content>
        <View style={styles.cardHeader}>
          <View style={styles.vehicleIcon}>
            <Icon name="car" size={32} color={COLORS.primary} />
          </View>
          <View style={styles.vehicleInfo}>
            <Text style={styles.vehicleName}>
              {vehicle.marka} {vehicle.model}
            </Text>
            <Text style={styles.vehiclePlate}>{vehicle.plaka}</Text>
          </View>
          <View style={styles.cardActions}>
            <IconButton
              icon="pencil"
              size={20}
              iconColor={COLORS.primary}
              onPress={() => navigation.navigate('EditVehicle', { vehicleId: vehicle.aracID })}
            />
            <IconButton
              icon="delete"
              size={20}
              iconColor="#F44336"
              onPress={() => handleDeleteVehicle(vehicle.aracID, `${vehicle.marka} ${vehicle.model}`)}
            />
          </View>
        </View>

        <View style={styles.vehicleDetails}>
          <View style={styles.detailRow}>
            <Icon name="palette" size={16} color={COLORS.textSecondary} />
            <Text style={styles.detailText}>{vehicle.renk || 'Belirtilmemiş'}</Text>
          </View>
          <View style={styles.detailRow}>
            <Icon name="calendar" size={16} color={COLORS.textSecondary} />
            <Text style={styles.detailText}>{vehicle.yil || 'Belirtilmemiş'}</Text>
          </View>
          <View style={styles.detailRow}>
            <Icon name="seat-passenger" size={16} color={COLORS.textSecondary} />
            <Text style={styles.detailText}>{vehicle.yolcuKapasitesi} Kişi</Text>
          </View>
        </View>

        <View style={styles.statusContainer}>
          <Chip
            icon={getStatusIcon(vehicle.onayDurumu)}
            style={[styles.statusChip, { backgroundColor: getStatusColor(vehicle.onayDurumu) + '20' }]}
            textStyle={[styles.statusText, { color: getStatusColor(vehicle.onayDurumu) }]}
          >
            {vehicle.onayDurumu}
          </Chip>
        </View>
      </Card.Content>
    </Card>
  );

  if (loading) {
    return (
      <View style={styles.centerContainer}>
        <ActivityIndicator size="large" color={COLORS.primary} />
        <Text style={styles.loadingText}>Araçlar yükleniyor...</Text>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <ScrollView
        style={styles.scrollView}
        contentContainerStyle={styles.scrollContent}
        refreshControl={
          <RefreshControl refreshing={refreshing} onRefresh={onRefresh} colors={[COLORS.primary]} />
        }
      >
        {vehicles.length === 0 ? (
          <View style={styles.emptyContainer}>
            <Icon name="car-off" size={80} color={COLORS.textSecondary} />
            <Text style={styles.emptyTitle}>Henüz araç eklemediniz</Text>
            <Text style={styles.emptySubtitle}>
              Sefer oluşturmak için önce aracınızı ekleyin
            </Text>
            <Button
              mode="contained"
              onPress={() => navigation.navigate('AddVehicle')}
              style={styles.emptyButton}
              icon="plus"
            >
              İlk Aracınızı Ekleyin
            </Button>
          </View>
        ) : (
          <>
            <View style={styles.header}>
              <Text style={styles.title}>Araçlarım</Text>
              <Text style={styles.subtitle}>{vehicles.length} araç kayıtlı</Text>
            </View>
            {vehicles.map(renderVehicleCard)}
          </>
        )}
      </ScrollView>

      {vehicles.length > 0 && (
        <FAB
          icon="plus"
          style={styles.fab}
          onPress={() => navigation.navigate('AddVehicle')}
          label="Araç Ekle"
        />
      )}
    </View>
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
    paddingBottom: 100,
  },
  centerContainer: {
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
  header: {
    marginBottom: 16,
  },
  title: {
    ...FONTS.bold,
    fontSize: 24,
    color: COLORS.text,
    marginBottom: 4,
  },
  subtitle: {
    ...FONTS.regular,
    fontSize: 14,
    color: COLORS.textSecondary,
  },
  card: {
    marginBottom: 12,
    borderRadius: 16,
    backgroundColor: '#FFFFFF',
    elevation: 2,
  },
  cardHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  vehicleIcon: {
    width: 56,
    height: 56,
    borderRadius: 28,
    backgroundColor: '#E3F2FD',
    justifyContent: 'center',
    alignItems: 'center',
  },
  vehicleInfo: {
    flex: 1,
    marginLeft: 12,
  },
  vehicleName: {
    ...FONTS.semiBold,
    fontSize: 18,
    color: COLORS.text,
    marginBottom: 2,
  },
  vehiclePlate: {
    ...FONTS.medium,
    fontSize: 14,
    color: COLORS.textSecondary,
    letterSpacing: 1,
  },
  cardActions: {
    flexDirection: 'row',
  },
  vehicleDetails: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    marginBottom: 12,
    paddingVertical: 8,
    backgroundColor: '#F5F9FC',
    borderRadius: 8,
  },
  detailRow: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  detailText: {
    ...FONTS.medium,
    fontSize: 13,
    color: COLORS.text,
    marginLeft: 6,
  },
  statusContainer: {
    alignItems: 'flex-start',
  },
  statusChip: {
    height: 28,
  },
  statusText: {
    ...FONTS.medium,
    fontSize: 12,
  },
  emptyContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    paddingTop: 100,
  },
  emptyTitle: {
    ...FONTS.bold,
    fontSize: 20,
    color: COLORS.text,
    marginTop: 16,
    marginBottom: 8,
  },
  emptySubtitle: {
    ...FONTS.regular,
    fontSize: 14,
    color: COLORS.textSecondary,
    textAlign: 'center',
    marginBottom: 24,
    paddingHorizontal: 32,
  },
  emptyButton: {
    borderRadius: 12,
    paddingHorizontal: 16,
  },
  fab: {
    position: 'absolute',
    margin: 16,
    right: 0,
    bottom: 0,
    backgroundColor: COLORS.primary,
  },
});
