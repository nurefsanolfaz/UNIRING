import React, { useState, useCallback } from 'react';
import { View, StyleSheet, FlatList, RefreshControl } from 'react-native';
import { 
  Card, 
  Title, 
  Paragraph, 
  Text, 
  ActivityIndicator, 
  SegmentedButtons,
  Chip,
  Button,
  FAB
} from 'react-native-paper';
import { useFocusEffect } from '@react-navigation/native';
import { getMyCreatedRides, getMyBookings, cancelBooking } from '../../services/rideService';
import { COLORS } from '../../constants/config';

export default function MyRidesScreen({ navigation }) {
  const [activeTab, setActiveTab] = useState('created'); // 'created' veya 'joined'
  const [createdRides, setCreatedRides] = useState([]);
  const [joinedRides, setJoinedRides] = useState([]);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);

  const loadMyRides = useCallback(async ({ showLoader = true } = {}) => {
    if (showLoader) {
      setLoading(true);
    }
    try {
      const [created, joined] = await Promise.all([
        getMyCreatedRides(),
        getMyBookings()
      ]);
      setCreatedRides(created.seferler || created || []);
      setJoinedRides(joined.rezervasyonlar || joined || []);
    } catch (error) {
      console.error('Sefer yükleme hatası:', error);
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  }, []);

  useFocusEffect(
    useCallback(() => {
      loadMyRides();
    }, [loadMyRides])
  );

  const onRefresh = () => {
    setRefreshing(true);
    loadMyRides({ showLoader: false });
  };

  const handleCancelBooking = async (rezervasyonID) => {
    try {
      await cancelBooking(rezervasyonID, 'Kullanıcı iptali');
      alert('Rezervasyon iptal edildi');
      loadMyRides();
    } catch (error) {
      alert('İptal işlemi başarısız: ' + error.message);
    }
  };

  const formatDate = (dateString) => {
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
      case 'Aktif':
      case 'Onaylandı':
        return '#4CAF50';
      case 'Tamamlandı':
        return '#2196F3';
      case 'İptal Edildi':
      case 'Reddedildi':
        return '#F44336';
      case 'Beklemede':
      case 'Planlanıyor':
        return '#FFA500';
      default:
        return COLORS.textSecondary;
    }
  };

  // Oluşturduğum Seferler
  const renderCreatedRide = ({ item }) => {
    const bosKoltuk = item.maxKapasite - item.mevcutDoluluk;
    const baslangic = item.guzergah?.[0]?.konumAdi || 'Belirtilmemiş';
    const varis = item.guzergah?.[item.guzergah.length - 1]?.konumAdi || 'Belirtilmemiş';

    return (
      <Card 
        style={styles.card} 
        onPress={() => navigation.navigate('RideDetail', { seferID: item.seferID })}
      >
        <Card.Content>
          <View style={styles.header}>
            <Chip 
              style={[styles.statusChip, { backgroundColor: getStatusColor(item.seferDurumu) }]}
              textStyle={{ color: '#fff' }}
            >
              {item.seferDurumu}
            </Chip>
            <Text style={styles.seferTipi}>{item.seferTipi}</Text>
          </View>

          <View style={styles.routeContainer}>
            <View style={styles.locationBox}>
              <Text style={styles.locationLabel}>Kalkış</Text>
              <Title style={styles.locationText} numberOfLines={1}>{baslangic}</Title>
            </View>
            <Text style={styles.arrow}>→</Text>
            <View style={styles.locationBox}>
              <Text style={styles.locationLabel}>Varış</Text>
              <Title style={styles.locationText} numberOfLines={1}>{varis}</Title>
            </View>
          </View>

          <Paragraph style={styles.dateText}>📅 {formatDate(item.kalkisZamani)}</Paragraph>

          <View style={styles.infoRow}>
            <Text style={styles.infoText}>🪑 {bosKoltuk}/{item.maxKapasite} boş</Text>
            <Text style={styles.priceText}>💰 {item.temelFiyat} TL</Text>
          </View>

          {item.mevcutDoluluk > 0 && (
            <View style={styles.participantsBox}>
              <Text style={styles.participantsText}>
                👥 {item.mevcutDoluluk} kişi katıldı
              </Text>
            </View>
          )}
        </Card.Content>
      </Card>
    );
  };

  // Katıldığım Seferler (Rezervasyonlarım)
  const renderJoinedRide = ({ item }) => {
    const sefer = item.sefer; // Rezervasyon içinde sefer bilgisi var
    if (!sefer) return null;

    const baslangic = item.binisNokta?.konumAdi || 'Belirtilmemiş';
    const varis = item.inisNokta?.konumAdi || 'Belirtilmemiş';
    const surucu = sefer.organizator ? `${sefer.organizator.ad} ${sefer.organizator.soyad}` : 'Bilinmiyor';

    return (
      <Card 
        style={styles.card}
        onPress={() => navigation.navigate('RideDetail', { seferID: sefer.seferID })}
      >
        <Card.Content>
          <View style={styles.header}>
            <Chip 
              style={[styles.statusChip, { backgroundColor: getStatusColor(item.durum) }]}
              textStyle={{ color: '#fff' }}
            >
              {item.durum}
            </Chip>
            <Text style={styles.rezervasyonID}>#{item.rezervasyonID}</Text>
          </View>

          <View style={styles.routeContainer}>
            <View style={styles.locationBox}>
              <Text style={styles.locationLabel}>Biniş</Text>
              <Title style={styles.locationText} numberOfLines={1}>{baslangic}</Title>
            </View>
            <Text style={styles.arrow}>→</Text>
            <View style={styles.locationBox}>
              <Text style={styles.locationLabel}>İniş</Text>
              <Title style={styles.locationText} numberOfLines={1}>{varis}</Title>
            </View>
          </View>

          <Paragraph style={styles.dateText}>📅 {formatDate(sefer.kalkisZamani)}</Paragraph>

          <View style={styles.driverRow}>
            <Text style={styles.driverText}>👤 Sürücü: {surucu}</Text>
          </View>

          <View style={styles.infoRow}>
            <Text style={styles.infoText}>🪑 {item.yolcuSayisi} kişi</Text>
            <Text style={styles.priceText}>💰 {item.odenecekTutar} TL</Text>
          </View>

          {item.durum === 'Beklemede' && (
            <Button 
              mode="outlined" 
              onPress={() => handleCancelBooking(item.rezervasyonID)}
              style={styles.cancelButton}
              textColor="#F44336"
            >
              İptal Et
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
      </View>
    );
  }

  const isCreatedTab = activeTab === 'created';
  const currentData = isCreatedTab ? createdRides : joinedRides;

  return (
    <View style={styles.container}>
      <SegmentedButtons
        value={activeTab}
        onValueChange={setActiveTab}
        buttons={[
          { value: 'created', label: 'Oluşturduklarım', icon: 'car' },
          { value: 'joined', label: 'Katıldıklarım', icon: 'account-group' },
        ]}
        style={styles.segmentedButtons}
      />

      <FlatList
        data={currentData}
        renderItem={isCreatedTab ? renderCreatedRide : renderJoinedRide}
        keyExtractor={(item) => 
          isCreatedTab 
            ? item.seferID?.toString() 
            : item.rezervasyonID?.toString()
        }
        contentContainerStyle={styles.listContent}
        refreshControl={
          <RefreshControl refreshing={refreshing} onRefresh={onRefresh} />
        }
        ListFooterComponent={<View style={styles.footerSpacer} />}
        ListEmptyComponent={
          <View style={styles.emptyContainer}>
            <Text style={styles.emptyText}>
              {isCreatedTab 
                ? 'Henüz sefer oluşturmadınız' 
                : 'Henüz bir sefere katılmadınız'}
            </Text>
            <Text style={styles.emptySubtext}>
              {isCreatedTab 
                ? 'Hemen bir sefer oluşturun!' 
                : 'Ana sayfadan seferlere göz atın!'}
            </Text>
            {isCreatedTab && (
              <Button
                mode="contained"
                icon="plus-circle"
                style={styles.emptyActionButton}
                onPress={() => navigation.navigate('CreateRide')}
              >
                Sefer Oluştur
              </Button>
            )}
          </View>
        }
      />

      {isCreatedTab && (
        <FAB
          style={styles.fab}
          icon="plus"
          label="Sefer Oluştur"
          color="#fff"
          onPress={() => navigation.navigate('CreateRide')}
        />
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: COLORS.surface,
  },
  centerContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  segmentedButtons: {
    margin: 15,
  },
  listContent: {
    paddingHorizontal: 15,
    paddingTop: 0,
    paddingBottom: 140,
  },
  card: {
    marginBottom: 15,
    elevation: 3,
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 15,
  },
  statusChip: {
    height: 28,
  },
  seferTipi: {
    fontSize: 12,
    color: COLORS.textSecondary,
  },
  rezervasyonID: {
    fontSize: 12,
    color: COLORS.textSecondary,
    fontWeight: 'bold',
  },
  routeContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: 12,
  },
  locationBox: {
    flex: 1,
  },
  locationLabel: {
    fontSize: 12,
    color: COLORS.textSecondary,
    marginBottom: 4,
  },
  locationText: {
    fontSize: 14,
    fontWeight: 'bold',
  },
  arrow: {
    fontSize: 20,
    marginHorizontal: 8,
    color: COLORS.primary,
  },
  dateText: {
    fontSize: 13,
    marginBottom: 10,
  },
  infoRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginTop: 10,
  },
  infoText: {
    fontSize: 13,
    color: COLORS.textSecondary,
  },
  priceText: {
    fontSize: 16,
    fontWeight: 'bold',
    color: COLORS.primary,
  },
  participantsBox: {
    marginTop: 10,
    paddingTop: 10,
    borderTopWidth: 1,
    borderTopColor: COLORS.border,
  },
  participantsText: {
    fontSize: 13,
    color: COLORS.primary,
    fontWeight: 'bold',
  },
  driverRow: {
    marginBottom: 8,
  },
  driverText: {
    fontSize: 13,
    color: COLORS.textSecondary,
  },
  cancelButton: {
    marginTop: 10,
    borderColor: '#F44336',
  },
  emptyContainer: {
    alignItems: 'center',
    marginTop: 80,
  },
  emptyText: {
    fontSize: 16,
    fontWeight: 'bold',
    color: COLORS.textSecondary,
  },
  emptySubtext: {
    fontSize: 14,
    color: COLORS.textSecondary,
    marginTop: 8,
  },
  emptyActionButton: {
    marginTop: 16,
    borderRadius: 12,
  },
  footerSpacer: {
    height: 80,
  },
  fab: {
    position: 'absolute',
    right: 20,
    bottom: 20,
    backgroundColor: COLORS.primary,
    elevation: 6,
  },
});
