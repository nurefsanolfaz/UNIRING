import React, { useState, useCallback } from 'react';
import { View, StyleSheet, FlatList, RefreshControl, Alert } from 'react-native';
import { 
  Card, 
  Title, 
  Text, 
  ActivityIndicator, 
  Chip,
  Button,
  IconButton,
  Divider
} from 'react-native-paper';
import { useFocusEffect } from '@react-navigation/native';
import { MaterialCommunityIcons as Icon } from '@expo/vector-icons';
import { getMyBookings, cancelBooking } from '../../services/rideService';
import { useAuth } from '../../context/AuthContext';
import { COLORS, FONTS } from '../../constants/config';

export default function MyBookingsScreen({ navigation }) {
  const { user } = useAuth();
  const [bookings, setBookings] = useState([]);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);

  const loadBookings = useCallback(async ({ showLoader = true } = {}) => {
    if (showLoader) setLoading(true);
    try {
      const response = await getMyBookings();
      setBookings(response.rezervasyonlar || response || []);
    } catch (error) {
      console.error('Rezervasyon yükleme hatası:', error);
      Alert.alert('⚠️ Uyarı', 'Rezervasyonlar yüklenirken bir hata oluştu');
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  }, []);

  useFocusEffect(
    useCallback(() => {
      loadBookings();
    }, [loadBookings])
  );

  const onRefresh = () => {
    setRefreshing(true);
    loadBookings({ showLoader: false });
  };

  const handleCancelBooking = (rezervasyonID, seferAdi) => {
    Alert.alert(
      '🚫 Rezervasyonu İptal Et',
      `${seferAdi} seferindeki rezervasyonunuzu iptal etmek istediğinize emin misiniz?`,
      [
        { text: 'Vazgeç', style: 'cancel' },
        {
          text: 'İptal Et',
          style: 'destructive',
          onPress: async () => {
            try {
              await cancelBooking(rezervasyonID, 'Kullanıcı iptali');
              Alert.alert('✅ Başarılı', 'Rezervasyon iptal edildi');
              loadBookings();
            } catch (error) {
              Alert.alert('❌ Hata', error.message || 'İptal işlemi başarısız');
            }
          },
        },
      ]
    );
  };

  const formatDate = (dateString) => {
    if (!dateString) return 'Belirtilmemiş';
    const date = new Date(dateString);
    return date.toLocaleDateString('tr-TR', { 
      day: 'numeric', 
      month: 'long',
      hour: '2-digit', 
      minute: '2-digit' 
    });
  };

  const getStatusColor = (durum) => {
    switch (durum) {
      case 'Onaylandı':
        return '#4CAF50';
      case 'Beklemede':
        return '#FF9800';
      case 'Reddedildi':
      case 'İptal Edildi':
        return '#F44336';
      case 'Tamamlandı':
        return '#2196F3';
      default:
        return COLORS.textSecondary;
    }
  };

  const getStatusIcon = (durum) => {
    switch (durum) {
      case 'Onaylandı':
        return 'check-circle';
      case 'Beklemede':
        return 'clock-outline';
      case 'Reddedildi':
      case 'İptal Edildi':
        return 'close-circle';
      case 'Tamamlandı':
        return 'check-all';
      default:
        return 'help-circle';
    }
  };

  const renderBooking = ({ item }) => {
    const sefer = item.sefer || {};
    const binisNokta = item.binisNokta || {};
    const inisNokta = item.inisNokta || {};
    const organizator = sefer.organizator || {};

    const baslangic = binisNokta.konumAdi || 'Belirtilmemiş';
    const varis = inisNokta.konumAdi || 'Belirtilmemiş';
    const kalkisZamani = formatDate(sefer.kalkisZamani);
    const statusColor = getStatusColor(item.durum);

    const canCancel = item.durum === 'Beklemede' || item.durum === 'Onaylandı';

    return (
      <Card 
        style={styles.card} 
        onPress={() => navigation.navigate('RideDetail', { seferID: sefer.seferID })}
      >
        <Card.Content>
          {/* Başlık ve Durum */}
          <View style={styles.headerRow}>
            <View style={styles.titleContainer}>
              <Text style={styles.title}>
                Rezervasyon #{item.rezervasyonID}
              </Text>
              <Chip
                icon={getStatusIcon(item.durum)}
                style={[styles.statusChip, { backgroundColor: statusColor + '20' }]}
                textStyle={[styles.statusText, { color: statusColor }]}
                compact
              >
                {item.durum}
              </Chip>
            </View>
          </View>

          <Divider style={styles.divider} />

          {/* Güzergah Bilgisi */}
          <View style={styles.routeContainer}>
            <View style={styles.routeRow}>
              <Icon name="map-marker" size={20} color={COLORS.primary} />
              <View style={styles.routeInfo}>
                <Text style={styles.locationLabel}>Binş Noktası</Text>
                <Text style={styles.locationText}>{baslangic}</Text>
              </View>
            </View>
            
            <View style={styles.routeLine} />
            
            <View style={styles.routeRow}>
              <Icon name="map-marker-check" size={20} color="#4CAF50" />
              <View style={styles.routeInfo}>
                <Text style={styles.locationLabel}>İniş Noktası</Text>
                <Text style={styles.locationText}>{varis}</Text>
              </View>
            </View>
          </View>

          {/* Sefer Detayları */}
          <View style={styles.detailsContainer}>
            <View style={styles.detailRow}>
              <Icon name="calendar-clock" size={18} color={COLORS.textSecondary} />
              <Text style={styles.detailText}>{kalkisZamani}</Text>
            </View>
            
            <View style={styles.detailRow}>
              <Icon name="account" size={18} color={COLORS.textSecondary} />
              <Text style={styles.detailText}>
                {organizator.ad} {organizator.soyad}
              </Text>
            </View>

            {item.yolcuSayisi > 1 && (
              <View style={styles.detailRow}>
                <Icon name="seat-passenger" size={18} color={COLORS.textSecondary} />
                <Text style={styles.detailText}>
                  {item.yolcuSayisi} Kişi
                </Text>
              </View>
            )}
          </View>

          {/* Ücret Bilgisi */}
          {item.odenecekTutar && (
            <View style={styles.priceContainer}>
              <Text style={styles.priceLabel}>Ücret:</Text>
              <Text style={styles.priceText}>₺{Number(item.odenecekTutar).toFixed(2)}</Text>
            </View>
          )}

          {/* Rezervasyon Tarihi */}
          <Text style={styles.bookingDate}>
            Rezervasyon: {formatDate(item.olusturulmaTarihi)}
          </Text>

          {/* İptal Butonu */}
          {canCancel && (
            <Button
              mode="outlined"
              onPress={() => handleCancelBooking(item.rezervasyonID, `${baslangic} - ${varis}`)}
              style={styles.cancelButton}
              textColor="#F44336"
              icon="close-circle"
            >
              Rezervasyonu İptal Et
            </Button>
          )}
        </Card.Content>
      </Card>
    );
  };

  if (loading) {
    return (
      <View style={styles.centerContainer}>
        <ActivityIndicator size="large" color={COLORS.primary} />
        <Text style={styles.loadingText}>Rezervasyonlar yükleniyor...</Text>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <FlatList
        data={bookings}
        renderItem={renderBooking}
        keyExtractor={(item) => item.rezervasyonID?.toString()}
        contentContainerStyle={styles.listContent}
        refreshControl={
          <RefreshControl 
            refreshing={refreshing} 
            onRefresh={onRefresh}
            colors={[COLORS.primary]}
          />
        }
        ListEmptyComponent={
          <View style={styles.emptyContainer}>
            <Icon name="ticket-outline" size={80} color={COLORS.textSecondary} />
            <Text style={styles.emptyTitle}>Henüz rezervasyon yok</Text>
            <Text style={styles.emptySubtitle}>
              Bir sefere katılarak rezervasyon oluşturabilirsiniz
            </Text>
            <Button
              mode="contained"
              onPress={() => navigation.navigate('RidesTab')}
              style={styles.emptyButton}
              icon="magnify"
            >
              Sefer Ara
            </Button>
          </View>
        }
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5F9FC',
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
  listContent: {
    padding: 16,
    paddingBottom: 100,
  },
  card: {
    marginBottom: 16,
    borderRadius: 16,
    backgroundColor: '#FFFFFF',
    elevation: 3,
    shadowColor: '#1E88E5',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.1,
    shadowRadius: 8,
  },
  headerRow: {
    marginBottom: 12,
  },
  titleContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  title: {
    ...FONTS.semiBold,
    fontSize: 16,
    color: COLORS.text,
  },
  statusChip: {
    height: 28,
  },
  statusText: {
    ...FONTS.medium,
    fontSize: 12,
  },
  divider: {
    marginVertical: 12,
  },
  routeContainer: {
    marginBottom: 16,
  },
  routeRow: {
    flexDirection: 'row',
    alignItems: 'flex-start',
  },
  routeInfo: {
    marginLeft: 12,
    flex: 1,
  },
  locationLabel: {
    ...FONTS.regular,
    fontSize: 12,
    color: COLORS.textSecondary,
    marginBottom: 2,
  },
  locationText: {
    ...FONTS.semiBold,
    fontSize: 15,
    color: COLORS.text,
  },
  routeLine: {
    width: 2,
    height: 20,
    backgroundColor: COLORS.border,
    marginLeft: 9,
    marginVertical: 4,
  },
  detailsContainer: {
    backgroundColor: '#F5F9FC',
    padding: 12,
    borderRadius: 12,
    marginBottom: 12,
  },
  detailRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
  },
  detailText: {
    ...FONTS.regular,
    fontSize: 14,
    color: COLORS.text,
    marginLeft: 8,
  },
  priceContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    backgroundColor: '#E8F5E9',
    padding: 12,
    borderRadius: 12,
    marginBottom: 8,
  },
  priceLabel: {
    ...FONTS.medium,
    fontSize: 14,
    color: COLORS.text,
  },
  priceText: {
    ...FONTS.bold,
    fontSize: 18,
    color: '#4CAF50',
  },
  bookingDate: {
    ...FONTS.regular,
    fontSize: 12,
    color: COLORS.textSecondary,
    marginBottom: 12,
    textAlign: 'right',
  },
  cancelButton: {
    borderColor: '#F44336',
    borderWidth: 1.5,
  },
  emptyContainer: {
    alignItems: 'center',
    justifyContent: 'center',
    paddingTop: 100,
    paddingHorizontal: 32,
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
  },
  emptyButton: {
    borderRadius: 12,
    paddingHorizontal: 24,
  },
});
