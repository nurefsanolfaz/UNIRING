import React, { useState, useEffect } from 'react';
import { View, StyleSheet, FlatList, RefreshControl, Alert } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { Card, Title, Paragraph, Button, Text, ActivityIndicator, FAB, Avatar, Chip } from 'react-native-paper';
import { getAllRides, createBooking } from '../../services/rideService';
import { COLORS, FONTS } from '../../constants/config';

export default function HomeScreen({ navigation }) {
  const [rides, setRides] = useState([]);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);
  const [selectedFilter, setSelectedFilter] = useState('all');
  const [currentPage, setCurrentPage] = useState(1);
  const ITEMS_PER_PAGE = 5;

  useEffect(() => {
    loadRides();
  }, []);

  const loadRides = async () => {
    try {
      const data = await getAllRides();
      // Backend'den gelen seferler direkt kullanılıyor
      // Beklenen format: { seferler: [...] } veya doğrudan array
      setRides(data.seferler || data || []);
    } catch (error) {
      console.error('Sefer yükleme hatası:', error);
      Alert.alert('Hata', 'Seferler yüklenemedi');
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  };

  const getRoutePoints = (ride) => {
    if (Array.isArray(ride.guzergah) && ride.guzergah.length > 0) {
      return ride.guzergah;
    }
    if (Array.isArray(ride.guzergahNoktalari) && ride.guzergahNoktalari.length > 0) {
      return ride.guzergahNoktalari;
    }
    return [];
  };

  const onRefresh = () => {
    setRefreshing(true);
    loadRides();
  };

  const formatDate = (dateString) => {
    const date = new Date(dateString);
    return date.toLocaleDateString('tr-TR', { 
      day: 'numeric', 
      month: 'long',
      year: 'numeric',
      hour: '2-digit', 
      minute: '2-digit' 
    });
  };

  // Filtreleme fonksiyonu
  const getFilteredRides = () => {
    if (selectedFilter === 'all') {
      return rides;
    }

    const now = new Date();
    const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);
    const dayAfterTomorrow = new Date(tomorrow);
    dayAfterTomorrow.setDate(dayAfterTomorrow.getDate() + 1);

    if (selectedFilter === 'today') {
      return rides.filter(ride => {
        const rideDate = new Date(ride.kalkisZamani);
        return rideDate >= today && rideDate < tomorrow;
      });
    }

    if (selectedFilter === 'tomorrow') {
      return rides.filter(ride => {
        const rideDate = new Date(ride.kalkisZamani);
        return rideDate >= tomorrow && rideDate < dayAfterTomorrow;
      });
    }

    if (selectedFilter === 'cheap') {
      return [...rides].sort((a, b) => (a.temelFiyat || 0) - (b.temelFiyat || 0));
    }

    return rides;
  };

  const handleQuickJoin = async (ride) => {
    console.log('🔵 Hızlı Katılım başladı:', ride.seferID);
    
    const guzergah = getRoutePoints(ride);
    const baslangic = guzergah.length > 0 ? guzergah[0] : null;
    const varis = guzergah.length > 1 ? guzergah[guzergah.length - 1] : null;

    if (!baslangic || !varis) {
      alert('Hata: Bu sefer için geçerli bir güzergah bulunamadı.');
      return;
    }

    try {
      const storedUser = await AsyncStorage.getItem('userData');
      const user = storedUser ? JSON.parse(storedUser) : null;

      if (!user?.kullaniciID) {
        alert('Hata: Kullanıcı bilgisine ulaşılamadı. Lütfen tekrar giriş yap.');
        return;
      }

      const confirmed = window.confirm(
        `${baslangic.konumAdi} → ${varis.konumAdi} seferine katılmak istiyor musun?`
      );
      
      if (!confirmed) {
        return;
      }

      console.log('⏳ Rezervasyon oluşturuluyor...');
      
      const requestData = {
        seferID: ride.seferID,
        yolcuID: user.kullaniciID,
        binisNoktaID: baslangic.noktaID,
        inisNoktaID: varis.noktaID,
        yolcuSayisi: 1,
      };
      console.log('📤 API isteği:', requestData);
      
      const response = await createBooking(requestData);
      console.log('✅ API yanıtı:', response);
      
      alert('✅ Başarılı! Rezervasyonun oluşturuldu!');
      onRefresh();
    } catch (error) {
      console.error('❌ Hızlı rezervasyon hatası:', error);
      alert('❌ Hata: ' + (error?.error || error?.message || 'Rezervasyon oluşturulamadı'));
    }
  };

  const renderRideCard = ({ item }) => {
    const guzergah = getRoutePoints(item);
    const bosKoltuk = item.maxKapasite - item.mevcutDoluluk;
    const surucu = item.organizator ? `${item.organizator.ad} ${item.organizator.soyad}` : 'Bilinmiyor';
    const baslangic = guzergah.length > 0 ? guzergah[0].konumAdi : 'Belirtilmemiş';
    const varis = guzergah.length > 1 ? guzergah[guzergah.length - 1].konumAdi : 'Belirtilmemiş';
    
    // Durum badge renkleri
    const getStatusColor = (durum) => {
      switch(durum?.toLowerCase()) {
        case 'planlanıyor':
          return { bg: '#FFA726', text: '#fff', emoji: '⏳' }; // Sarı
        case 'iptal edildi':
        case 'iptal':
          return { bg: '#E53935', text: '#fff', emoji: '❌' }; // Kırmızı
        case 'tamamlandı':
        case 'tamamlanmış':
          return { bg: '#78909C', text: '#fff', emoji: '✅' }; // Gri
        case 'aktif':
        case 'devam ediyor':
          return { bg: '#66BB6A', text: '#fff', emoji: '🚗' }; // Yeşil
        default:
          return { bg: '#42A5F5', text: '#fff', emoji: '🛣️' }; // Mavi (default)
      }
    };
    
    const statusStyle = getStatusColor(item.seferDurumu);
    
    return (
      <Card style={styles.card} onPress={() => navigation.navigate('RideDetail', { seferID: item.seferID })}>
        <Card.Content>
          {/* Başlık Satırı: Durum + Hızlı Katıl */}
          <View style={styles.headerRow}>
            <Chip
              icon={() => <Text style={styles.chipEmoji}>{statusStyle.emoji}</Text>}
              style={[styles.statusChip, { backgroundColor: statusStyle.bg }]}
              textStyle={[styles.statusText, { color: statusStyle.text }]}
              compact
            >
              {item.seferDurumu}
            </Chip>

            {bosKoltuk > 0 && (
              <Button
                mode="contained"
                compact
                style={styles.joinButton}
                labelStyle={styles.joinButtonLabel}
                onPress={() => handleQuickJoin(item)}
              >
                Katıl
              </Button>
            )}
          </View>

          {/* Kompakt Güzergah */}
          <View style={styles.compactRoute}>
            <View style={styles.routePoint}>
              <Text style={styles.routeIcon}>📍</Text>
              <Text style={styles.routeLocation} numberOfLines={1}>{baslangic}</Text>
            </View>
            <Text style={styles.routeArrow}>→</Text>
            <View style={styles.routePoint}>
              <Text style={styles.routeIcon}>🎯</Text>
              <Text style={styles.routeLocation} numberOfLines={1}>{varis}</Text>
            </View>
          </View>

          {/* Bilgi Satırı */}
          <View style={styles.infoLine}>
            <Text style={styles.infoItem}>📅 {formatDate(item.kalkisZamani).split(',')[0]}</Text>
            <Text style={styles.infoItem}>🪑 {bosKoltuk}</Text>
            <Text style={styles.priceTag}>₺{item.temelFiyat}</Text>
          </View>

          {/* Sürücü ve Özellikler */}
          <View style={styles.bottomRow}>
            <View style={styles.driverCompact}>
              <Avatar.Text 
                size={28} 
                label={surucu.split(' ').map(n => n[0]).join('')} 
                style={styles.avatarSmall}
                color="#fff"
                labelStyle={styles.avatarLabel}
              />
              <Text style={styles.driverName} numberOfLines={1}>{surucu}</Text>
              {item.organizator?.guvenlikSkoru && (
                <Text style={styles.ratingSmall}>⭐{item.organizator.guvenlikSkoru.toFixed(1)}</Text>
              )}
            </View>
            <View style={styles.featuresCompact}>
              {item.bagajAlaniVar && <Text style={styles.featureIcon}>🧳</Text>}
              {item.klimaVar && <Text style={styles.featureIcon}>❄️</Text>}
            </View>
          </View>
        </Card.Content>
      </Card>
    );
  };

  if (loading) {
    return (
      <View style={styles.centerContainer}>
        <ActivityIndicator size="large" color={COLORS.primary} />
      </View>
    );
  }

  const filteredRides = getFilteredRides();

  // Pagination hesaplamaları
  const totalPages = Math.ceil(filteredRides.length / ITEMS_PER_PAGE);
  const startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
  const endIndex = startIndex + ITEMS_PER_PAGE;
  const paginatedRides = filteredRides.slice(startIndex, endIndex);

  // Sayfa değiştiğinde en üste scroll et
  const handlePageChange = (newPage) => {
    setCurrentPage(newPage);
  };

  // Filtre değiştiğinde sayfa 1'e dön
  const handleFilterChange = (filter) => {
    setSelectedFilter(filter);
    setCurrentPage(1);
  };

  // Filtre başlığını render et
  const renderFilterHeader = () => (
    <View style={styles.filterContainer}>
      <Chip 
        selected={selectedFilter === 'all'}
        onPress={() => handleFilterChange('all')}
        style={[
          styles.filterChip,
          selectedFilter === 'all' && styles.filterChipActive
        ]}
        textStyle={[
          styles.filterChipText,
          selectedFilter === 'all' && styles.filterChipTextActive
        ]}
        icon={selectedFilter === 'all' ? 'check-circle' : 'checkbox-blank-circle-outline'}
      >
        Tümü
      </Chip>
      <Chip 
        selected={selectedFilter === 'today'}
        onPress={() => handleFilterChange('today')}
        style={[
          styles.filterChip,
          selectedFilter === 'today' && styles.filterChipActive
        ]}
        textStyle={[
          styles.filterChipText,
          selectedFilter === 'today' && styles.filterChipTextActive
        ]}
        icon="calendar-today"
      >
        Bugün
      </Chip>
      <Chip 
        selected={selectedFilter === 'tomorrow'}
        onPress={() => handleFilterChange('tomorrow')}
        style={[
          styles.filterChip,
          selectedFilter === 'tomorrow' && styles.filterChipActive
        ]}
        textStyle={[
          styles.filterChipText,
          selectedFilter === 'tomorrow' && styles.filterChipTextActive
        ]}
        icon="calendar-clock"
      >
        Yarın
      </Chip>
      <Chip 
        selected={selectedFilter === 'cheap'}
        onPress={() => handleFilterChange('cheap')}
        style={[
          styles.filterChip,
          selectedFilter === 'cheap' && styles.filterChipActive
        ]}
        textStyle={[
          styles.filterChipText,
          selectedFilter === 'cheap' && styles.filterChipTextActive
        ]}
        icon="cash"
      >
        Ucuz
      </Chip>
    </View>
  );

  return (
    <View style={styles.container}>
      <View style={styles.contentWrapper}>
        <FlatList
          data={paginatedRides}
          renderItem={renderRideCard}
          keyExtractor={(item) => item.seferID?.toString() || Math.random().toString()}
          style={styles.list}
          contentContainerStyle={styles.listContent}
          ListHeaderComponentStyle={styles.filterHeader}
          ListHeaderComponent={renderFilterHeader}
          stickyHeaderIndices={[0]}
          nestedScrollEnabled={true}
          refreshControl={
            <RefreshControl refreshing={refreshing} onRefresh={onRefresh} />
          }
          ListEmptyComponent={
            <View style={styles.emptyContainer}>
              <Text style={styles.emptyText}>Henüz yolculuk yok</Text>
              <Text style={styles.emptySubtext}>İlk yolculuğu sen oluştur!</Text>
            </View>
          }
        />
      </View>

      {/* Pagination Controls */}
      {totalPages > 1 && (
        <View style={styles.paginationContainer}>
          <Button
            mode="outlined"
            onPress={() => handlePageChange(currentPage - 1)}
            disabled={currentPage === 1}
            style={styles.paginationButton}
            labelStyle={styles.paginationButtonLabel}
            compact
          >
            ◀
          </Button>

          <View style={styles.pageNumbersContainer}>
            <Text style={styles.pageInfo}>
              Sayfa {currentPage} / {totalPages}
            </Text>
          </View>

          <Button
            mode="outlined"
            onPress={() => handlePageChange(currentPage + 1)}
            disabled={currentPage === totalPages}
            style={styles.paginationButton}
            labelStyle={styles.paginationButtonLabel}
            compact
          >
            ▶
          </Button>
        </View>
      )}

      <FAB
        style={styles.fab}
        icon="plus"
        label="Yolculuk Oluştur"
        onPress={() => navigation.navigate('CreateRide')}
        color="#fff"
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5F9FC', // Hafif mavi arka plan
  },
  contentWrapper: {
    flex: 1,
  },
  filterContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    alignItems: 'center',
    gap: 8,
  },
  filterChip: {
    height: 38,
    borderRadius: 20,
    backgroundColor: '#F5F9FC',
    borderWidth: 1,
    borderColor: '#E0E0E0',
  },
  filterChipActive: {
    backgroundColor: COLORS.primary,
    borderColor: COLORS.primary,
  },
  filterChipText: {
    ...FONTS.medium,
    fontSize: 13,
    color: COLORS.text,
  },
  filterChipTextActive: {
    color: '#FFFFFF',
  },
  centerContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  list: {
    flex: 1,
  },
  listContent: {
    flexGrow: 1,
    paddingHorizontal: 15,
    paddingTop: 12,
    paddingBottom: 20,
  },
  filterHeader: {
    backgroundColor: '#FFFFFF',
    paddingHorizontal: 15,
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#E3F2FD',
    zIndex: 10,
  },
  card: {
    marginBottom: 12,
    marginHorizontal: 16,
    borderRadius: 16,
    backgroundColor: '#FFFFFF',
    elevation: 2,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.08,
    shadowRadius: 4,
  },
  headerRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 12,
  },
  statusChip: {
    height: 28,
  },
  chipEmoji: {
    fontSize: 12,
  },
  statusText: {
    fontSize: 11,
    fontWeight: '600',
  },
  compactRoute: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#F5F9FC',
    padding: 10,
    borderRadius: 12,
    marginBottom: 10,
  },
  routePoint: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
  },
  routeIcon: {
    fontSize: 14,
    marginRight: 4,
  },
  routeLocation: {
    ...FONTS.semiBold,
    fontSize: 14,
    color: COLORS.text,
    flex: 1,
  },
  routeArrow: {
    fontSize: 16,
    color: COLORS.primary,
    marginHorizontal: 8,
  },
  infoLine: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: 10,
  },
  infoItem: {
    ...FONTS.regular,
    fontSize: 12,
    color: COLORS.textSecondary,
  },
  priceTag: {
    ...FONTS.bold,
    fontSize: 15,
    color: '#4CAF50',
  },
  bottomRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  driverCompact: {
    flexDirection: 'row',
    alignItems: 'center',
    flex: 1,
  },
  avatarSmall: {
    backgroundColor: COLORS.primary,
  },
  avatarLabel: {
    fontSize: 11,
  },
  driverName: {
    ...FONTS.medium,
    fontSize: 12,
    color: COLORS.text,
    marginLeft: 8,
    flex: 1,
  },
  ratingSmall: {
    ...FONTS.semiBold,
    fontSize: 11,
    color: '#FFA726',
    marginLeft: 4,
  },
  featuresCompact: {
    flexDirection: 'row',
    gap: 6,
  },
  featureIcon: {
    fontSize: 16,
  },
  joinButton: {
    backgroundColor: COLORS.primary,
    borderRadius: 8,
    height: 32,
  },
  joinButtonLabel: {
    fontSize: 11,
    color: '#FFFFFF',
    fontWeight: '700',
    marginVertical: 0,
  },
  routeContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: 15,
  },
  locationContainer: {
    flex: 1,
  },
  locationLabel: {
    fontSize: 12,
    color: COLORS.textSecondary,
    marginBottom: 4,
  },
  locationText: {
    fontSize: 16,
    fontWeight: '700',
    color: COLORS.text,
    letterSpacing: 0.3,
  },
  arrow: {
    fontSize: 28,
    marginHorizontal: 12,
    color: COLORS.primary,
    fontWeight: 'bold',
  },
  infoRow: {
    marginBottom: 10,
  },
  footerRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginTop: 10,
  },
  seatsContainer: {
    flex: 1,
  },
  seats: {
    fontSize: 14,
    color: COLORS.textSecondary,
  },
  price: {
    fontSize: 22,
    ...FONTS.bold,
    color: COLORS.primary,
    letterSpacing: 0.5,
  },
  driverContainer: {
    marginTop: 10,
    paddingTop: 10,
    borderTopWidth: 1,
    borderTopColor: COLORS.border,
    flexDirection: 'row',
    alignItems: 'center',
  },
  avatar: {
    backgroundColor: COLORS.primary,
    marginRight: 12,
  },
  driverInfo: {
    flex: 1,
  },
  driver: {
    fontSize: 14,
    ...FONTS.semiBold,
    color: COLORS.text,
  },
  rating: {
    fontSize: 14,
    ...FONTS.bold,
    color: '#FFA500',
  },
  badgeContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
  },
  badgeRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 10,
  },
  badge: {
    fontSize: 11,
    ...FONTS.semiBold,
    backgroundColor: COLORS.primary,
    color: '#fff',
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 20,
    overflow: 'hidden',
  },
  joinButton: {
    backgroundColor: '#FFFFFF',
    borderRadius: 20,
    paddingHorizontal: 14,
    height: 34,
    justifyContent: 'center',
    borderWidth: 1,
    borderColor: COLORS.primary,
  },
  joinButtonLabel: {
    fontSize: 12,
    color: COLORS.primary,
    fontWeight: '700',
  },
  statusBadge: {
    backgroundColor: '#4CAF50',
    marginLeft: 8,
  },
  featuresRow: {
    flexDirection: 'row',
    marginVertical: 8,
    gap: 10,
  },
  feature: {
    fontSize: 11,
    ...FONTS.medium,
    backgroundColor: '#E3F2FD',
    color: COLORS.primary,
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 16,
    borderWidth: 0,
  },
  emptyContainer: {
    alignItems: 'center',
    marginTop: 100,
    paddingHorizontal: 40,
  },
  emptyText: {
    fontSize: 20,
    ...FONTS.bold,
    color: COLORS.text,
    marginBottom: 8,
    textAlign: 'center',
  },
  emptySubtext: {
    fontSize: 15,
    ...FONTS.medium,
    color: COLORS.textSecondary,
    marginTop: 10,
    textAlign: 'center',
  },
  fab: {
    position: 'absolute',
    margin: 16,
    right: 0,
    bottom: 80,
    backgroundColor: COLORS.primary,
    elevation: 12,
    borderRadius: 28,
    zIndex: 9999,
  },
  paginationContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingVertical: 12,
    paddingHorizontal: 20,
    backgroundColor: '#FFFFFF',
    borderTopWidth: 1,
    borderTopColor: '#E0E0E0',
    elevation: 8,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: -2 },
    shadowOpacity: 0.15,
    shadowRadius: 8,
  },
  paginationButton: {
    borderColor: COLORS.primary,
    borderRadius: 8,
    minWidth: 50,
    height: 44,
  },
  paginationButtonLabel: {
    fontSize: 20,
    color: COLORS.primary,
    fontWeight: 'bold',
  },
  pageNumbersContainer: {
    alignItems: 'center',
    justifyContent: 'center',
  },
  pageInfo: {
    fontSize: 15,
    fontWeight: '600',
    color: COLORS.text,
  },
});
