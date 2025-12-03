import React, { useState, useEffect } from 'react';
import { View, StyleSheet, FlatList, RefreshControl, Alert } from 'react-native';
import { Card, Title, Paragraph, Button, Text, ActivityIndicator, FAB, Avatar, Chip } from 'react-native-paper';
import { getAllRides } from '../../services/rideService';
import { COLORS, FONTS } from '../../constants/config';

export default function HomeScreen({ navigation }) {
  const [rides, setRides] = useState([]);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);
  const [selectedFilter, setSelectedFilter] = useState('all');

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

  const renderRideCard = ({ item }) => {
    const bosKoltuk = item.maxKapasite - item.mevcutDoluluk;
    const surucu = item.organizator ? `${item.organizator.ad} ${item.organizator.soyad}` : 'Bilinmiyor';
    const baslangic = item.guzergah && item.guzergah.length > 0 ? item.guzergah[0].konumAdi : 'Belirtilmemiş';
    const varis = item.guzergah && item.guzergah.length > 1 ? item.guzergah[item.guzergah.length - 1].konumAdi : 'Belirtilmemiş';
    
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
      <Card style={[styles.card, { backgroundColor: '#FFFFFF' }]} onPress={() => navigation.navigate('RideDetail', { seferID: item.seferID })}>
        <Card.Content>
          {/* Sefer Tipi Badge */}
          <View style={styles.badgeContainer}>
            <Text style={styles.badge}>
              {item.seferTipi === 'Araç Paylaşımı' ? '🚗 Araç Paylaşımı' : '🤝 Ortak Araç'}
            </Text>
            <Text style={[styles.badge, { backgroundColor: statusStyle.bg, color: statusStyle.text }]}>
              {statusStyle.emoji} {item.seferDurumu}
            </Text>
          </View>

          {/* Güzergah */}
          <View style={styles.routeContainer}>
            <View style={styles.locationContainer}>
              <Text style={styles.locationLabel}>Kalkış</Text>
              <Title style={styles.locationText} numberOfLines={1}>{baslangic}</Title>
            </View>
            <Text style={styles.arrow}>→</Text>
            <View style={styles.locationContainer}>
              <Text style={styles.locationLabel}>Varış</Text>
              <Title style={styles.locationText} numberOfLines={1}>{varis}</Title>
            </View>
          </View>

          {/* Tarih & Saat */}
          <View style={styles.infoRow}>
            <Paragraph>📅 {formatDate(item.kalkisZamani)}</Paragraph>
          </View>

          {/* Özellikler */}
          <View style={styles.featuresRow}>
            {item.bagajAlaniVar && <Text style={styles.feature}>🧳 Bagaj</Text>}
            {item.klimaVar && <Text style={styles.feature}>❄️ Klima</Text>}
          </View>

          {/* Alt Bilgiler */}
          <View style={styles.footerRow}>
            <View style={styles.seatsContainer}>
              <Text style={styles.seats}>🪑 {bosKoltuk} boş koltuk</Text>
            </View>
            <Text style={styles.price}>💰 {item.temelFiyat} TL</Text>
          </View>

          {/* Sürücü */}
          <View style={styles.driverContainer}>
            <Avatar.Text 
              size={36} 
              label={surucu.split(' ').map(n => n[0]).join('')} 
              style={styles.avatar}
              color="#fff"
            />
            <View style={styles.driverInfo}>
              <Text style={styles.driver}>👤 {surucu}</Text>
              {item.organizator?.guvenlikSkoru && (
                <Text style={styles.rating}>⭐ {item.organizator.guvenlikSkoru.toFixed(1)}</Text>
              )}
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

  // Filtre başlığını render et
  const renderFilterHeader = () => (
    <View style={styles.filterContainer}>
      <Chip 
        selected={selectedFilter === 'all'}
        onPress={() => setSelectedFilter('all')}
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
        onPress={() => setSelectedFilter('today')}
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
        onPress={() => setSelectedFilter('tomorrow')}
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
        onPress={() => setSelectedFilter('cheap')}
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
      <FlatList
        data={filteredRides}
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
    paddingBottom: 120,
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
    marginBottom: 20,
    elevation: 8,
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    shadowColor: '#1976D2',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.12,
    shadowRadius: 12,
    overflow: 'hidden',
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
    justifyContent: 'space-between',
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
    bottom: 0,
    backgroundColor: COLORS.primary,
    elevation: 8,
    borderRadius: 28,
    zIndex: 100,
  },
});
