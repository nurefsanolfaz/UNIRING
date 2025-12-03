import React, { useState, useEffect } from 'react';
import { View, StyleSheet, ScrollView, Alert } from 'react-native';
import { 
  Card, 
  Title, 
  Paragraph, 
  Button, 
  Text, 
  ActivityIndicator, 
  Divider,
  Chip,
  Avatar
} from 'react-native-paper';
import { getRideById, createBooking } from '../../services/rideService';
import { COLORS } from '../../constants/config';

export default function RideDetailScreen({ route, navigation }) {
  const { seferID } = route.params;
  const [sefer, setSefer] = useState(null);
  const [loading, setLoading] = useState(true);
  const [bookingLoading, setBookingLoading] = useState(false);

  useEffect(() => {
    loadRideDetails();
  }, [seferID]);

  const loadRideDetails = async () => {
    try {
      const data = await getRideById(seferID);
      setSefer(data);
    } catch (error) {
      console.error('Sefer detayı yüklenemedi:', error);
      Alert.alert('Hata', 'Sefer bilgileri yüklenemedi');
      navigation.goBack();
    } finally {
      setLoading(false);
    }
  };

  const handleBooking = async (binisNoktaID, inisNoktaID) => {
    Alert.alert(
      'Rezervasyon Yap',
      'Bu sefere katılmak istiyor musunuz?',
      [
        { text: 'İptal', style: 'cancel' },
        { 
          text: 'Evet', 
          onPress: async () => {
            try {
              setBookingLoading(true);
              await createBooking({
                seferID,
                binisNoktaID,
                inisNoktaID,
                yolcuSayisi: 1
              });
              Alert.alert('Başarılı', 'Rezervasyonunuz oluşturuldu!');
              navigation.goBack();
            } catch (error) {
              console.error('Rezervasyon hatası:', error);
              Alert.alert('Hata', error.message || 'Rezervasyon oluşturulamadı');
            } finally {
              setBookingLoading(false);
            }
          }
        }
      ]
    );
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

  if (loading) {
    return (
      <View style={styles.centerContainer}>
        <ActivityIndicator size="large" color={COLORS.primary} />
      </View>
    );
  }

  if (!sefer) {
    return (
      <View style={styles.centerContainer}>
        <Text>Sefer bulunamadı</Text>
      </View>
    );
  }

  const bosKoltuk = sefer.maxKapasite - sefer.mevcutDoluluk;
  const surucu = sefer.organizator ? `${sefer.organizator.ad} ${sefer.organizator.soyad}` : 'Bilinmiyor';
  const baslangic = sefer.guzergah && sefer.guzergah.length > 0 ? sefer.guzergah[0] : null;
  const varis = sefer.guzergah && sefer.guzergah.length > 1 ? sefer.guzergah[sefer.guzergah.length - 1] : null;

  return (
    <ScrollView style={styles.container}>
      {/* Sefer Tipi & Durum */}
      <Card style={styles.card}>
        <Card.Content style={styles.cardContent}>
          <View style={styles.chipContainer}>
            <Chip icon="car" mode="outlined" style={styles.chip}>
              {sefer.seferTipi}
            </Chip>
            <Chip 
              icon="information" 
              mode="outlined" 
              style={[styles.chip, { backgroundColor: sefer.seferDurumu === 'Aktif' ? '#E8F5E9' : '#FFF3E0' }]}
            >
              {sefer.seferDurumu}
            </Chip>
          </View>
          <Text style={styles.seferIdLabel}>Sefer ID: <Text style={styles.seferIdValue}>#{sefer.seferID}</Text></Text>
        </Card.Content>
      </Card>

      {/* Güzergah Bilgileri */}
      <Card style={styles.card}>
        <Card.Content style={styles.cardContent}>
          <Title>📍 Güzergah</Title>
          <Divider style={styles.divider} />
          
          {sefer.guzergah && sefer.guzergah.length > 0 ? (
            sefer.guzergah.map((nokta, index) => (
              <View key={nokta.noktaID} style={styles.routePoint}>
                <View style={styles.routeIndicator}>
                  <View style={[
                    styles.routeDot, 
                    index === 0 ? styles.startDot : 
                    index === sefer.guzergah.length - 1 ? styles.endDot : styles.middleDot
                  ]} />
                  {index < sefer.guzergah.length - 1 && <View style={styles.routeLine} />}
                </View>
                <View style={styles.routeInfo}>
                  <Text style={styles.routeTitle}>{nokta.konumAdi}</Text>
                  {nokta.planlananVarisZamani && (
                    <Text style={styles.routeTime}>⏰ {nokta.planlananVarisZamani}</Text>
                  )}
                  {nokta.mesafeOncekiNoktaya && (
                    <Text style={styles.routeDistance}>📏 {nokta.mesafeOncekiNoktaya} km</Text>
                  )}
                </View>
              </View>
            ))
          ) : (
            <Text style={styles.noData}>Güzergah bilgisi mevcut değil</Text>
          )}
        </Card.Content>
      </Card>

      {/* Tarih & Saat */}
      <Card style={styles.card}>
        <Card.Content style={styles.cardContent}>
          <Title>🕒 Tarih & Saat</Title>
          <Divider style={styles.divider} />
          <Paragraph style={styles.infoText}>
            <Text style={styles.label}>Kalkış: </Text>
            {formatDate(sefer.kalkisZamani)}
          </Paragraph>
          {sefer.tahminiVarisZamani && (
            <Paragraph style={styles.infoText}>
              <Text style={styles.label}>Tahmini Varış: </Text>
              {formatDate(sefer.tahminiVarisZamani)}
            </Paragraph>
          )}
        </Card.Content>
      </Card>

      {/* Kapasite & Fiyat */}
      <Card style={styles.card}>
        <Card.Content style={styles.cardContent}>
          <Title>💺 Kapasite & Fiyat</Title>
          <Divider style={styles.divider} />
          <View style={styles.infoRow}>
            <View style={styles.infoBox}>
              <Text style={styles.infoLabel}>Toplam Kapasite</Text>
              <Text style={styles.infoValue}>{sefer.maxKapasite} kişi</Text>
            </View>
            <View style={styles.infoBox}>
              <Text style={styles.infoLabel}>Boş Koltuk</Text>
              <Text style={[styles.infoValue, { color: bosKoltuk > 0 ? '#4CAF50' : '#F44336' }]}>
                {bosKoltuk} kişi
              </Text>
            </View>
          </View>
          <View style={styles.priceContainer}>
            <Text style={styles.priceLabel}>Kişi Başı Fiyat</Text>
            <Text style={styles.priceValue}>{sefer.temelFiyat} TL</Text>
          </View>
        </Card.Content>
      </Card>

      {/* Araç & Özellikler */}
      {sefer.arac && (
        <Card style={styles.card}>
          <Card.Content style={styles.cardContent}>
            <Title>🚗 Araç Bilgileri</Title>
            <Divider style={styles.divider} />
            <Paragraph style={styles.infoText}>
              <Text style={styles.label}>Marka/Model: </Text>
              {sefer.arac.marka} {sefer.arac.model}
            </Paragraph>
            <Paragraph style={styles.infoText}>
              <Text style={styles.label}>Plaka: </Text>
              {sefer.arac.plaka}
            </Paragraph>
            <Paragraph style={styles.infoText}>
              <Text style={styles.label}>Renk: </Text>
              {sefer.arac.renk}
            </Paragraph>
            <Paragraph style={styles.infoText}>
              <Text style={styles.label}>Yıl: </Text>
              {sefer.arac.yil}
            </Paragraph>
          </Card.Content>
        </Card>
      )}

      {/* Özellikler */}
      <Card style={styles.card}>
        <Card.Content style={styles.cardContent}>
          <Title>✨ Özellikler</Title>
          <Divider style={styles.divider} />
          <View style={styles.featuresContainer}>
            <Chip icon={sefer.bagajAlaniVar ? "check" : "close"} style={styles.featureChip}>
              🧳 Bagaj Alanı
            </Chip>
            <Chip icon={sefer.klimaVar ? "check" : "close"} style={styles.featureChip}>
              ❄️ Klima
            </Chip>
            <Chip icon="information" style={styles.featureChip}>
              {sefer.katilimKapsami}
            </Chip>
          </View>
        </Card.Content>
      </Card>

      {/* Sürücü Bilgileri */}
      {sefer.organizator && (
        <Card style={styles.card}>
          <Card.Content style={styles.cardContent}>
            <Title>👤 Sürücü</Title>
            <Divider style={styles.divider} />
            <View style={styles.driverContainer}>
              <Avatar.Text 
                size={60} 
                label={sefer.organizator.ad[0] + sefer.organizator.soyad[0]} 
                style={{ backgroundColor: COLORS.primary }}
              />
              <View style={styles.driverInfo}>
                <Text style={styles.driverName}>{surucu}</Text>
                {sefer.organizator.guvenlikSkoru && (
                  <Text style={styles.driverRating}>
                    ⭐ {sefer.organizator.guvenlikSkoru.toFixed(1)} / 100
                  </Text>
                )}
                {sefer.organizator.universitAdi && (
                  <Text style={styles.driverUniversity}>
                    🎓 {sefer.organizator.universitAdi}
                  </Text>
                )}
              </View>
            </View>
            {sefer.organizator.biyografi && (
              <Paragraph style={styles.bio}>{sefer.organizator.biyografi}</Paragraph>
            )}
          </Card.Content>
        </Card>
      )}

      {/* Açıklama */}
      {sefer.aciklama && (
        <Card style={styles.card}>
          <Card.Content style={styles.cardContent}>
            <Title>📝 Açıklama</Title>
            <Divider style={styles.divider} />
            <Paragraph>{sefer.aciklama}</Paragraph>
          </Card.Content>
        </Card>
      )}

      {/* Rezervasyon Butonu */}
      {bosKoltuk > 0 && sefer.seferDurumu === 'Aktif' && (
        <View style={styles.buttonContainer}>
          <Button
            mode="contained"
            onPress={() => handleBooking(baslangic?.noktaID, varis?.noktaID)}
            loading={bookingLoading}
            disabled={bookingLoading}
            style={styles.bookButton}
            contentStyle={styles.bookButtonContent}
          >
            Rezervasyon Yap
          </Button>
        </View>
      )}

      {bosKoltuk === 0 && (
        <View style={styles.buttonContainer}>
          <Text style={styles.fullText}>Bu sefer dolu</Text>
        </View>
      )}
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: COLORS.background,
  },
  centerContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  card: {
    margin: 15,
    marginBottom: 0,
    borderRadius: 18,
    backgroundColor: '#FFFFFF',
    elevation: 1,
    shadowColor: '#00000020',
    shadowOpacity: 0.12,
    shadowRadius: 8,
    shadowOffset: { width: 0, height: 4 },
  },
  cardContent: {
    paddingVertical: 18,
  },
  chipContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  chip: {
    marginRight: 5,
  },
  seferIdLabel: {
    marginTop: 12,
    fontSize: 14,
    color: COLORS.textSecondary,
  },
  seferIdValue: {
    fontWeight: 'bold',
    color: COLORS.primary,
  },
  divider: {
    marginVertical: 10,
  },
  routePoint: {
    flexDirection: 'row',
    marginVertical: 8,
  },
  routeIndicator: {
    alignItems: 'center',
    marginRight: 15,
  },
  routeDot: {
    width: 12,
    height: 12,
    borderRadius: 6,
    backgroundColor: COLORS.primary,
  },
  startDot: {
    backgroundColor: '#4CAF50',
  },
  endDot: {
    backgroundColor: '#F44336',
  },
  middleDot: {
    backgroundColor: COLORS.primary,
  },
  routeLine: {
    width: 2,
    flex: 1,
    backgroundColor: COLORS.border,
    minHeight: 30,
  },
  routeInfo: {
    flex: 1,
    justifyContent: 'center',
  },
  routeTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 4,
  },
  routeTime: {
    fontSize: 12,
    color: COLORS.textSecondary,
  },
  routeDistance: {
    fontSize: 12,
    color: COLORS.textSecondary,
  },
  noData: {
    fontStyle: 'italic',
    color: COLORS.textSecondary,
  },
  infoText: {
    marginVertical: 4,
    fontSize: 14,
  },
  label: {
    fontWeight: 'bold',
    color: COLORS.text,
  },
  infoRow: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    marginVertical: 10,
  },
  infoBox: {
    alignItems: 'center',
  },
  infoLabel: {
    fontSize: 12,
    color: COLORS.textSecondary,
    marginBottom: 5,
  },
  infoValue: {
    fontSize: 18,
    fontWeight: 'bold',
    color: COLORS.text,
  },
  priceContainer: {
    alignItems: 'center',
    marginTop: 15,
    padding: 15,
    backgroundColor: COLORS.surface,
    borderRadius: 8,
  },
  priceLabel: {
    fontSize: 14,
    color: COLORS.textSecondary,
    marginBottom: 5,
  },
  priceValue: {
    fontSize: 32,
    fontWeight: 'bold',
    color: COLORS.primary,
  },
  featuresContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 10,
  },
  featureChip: {
    marginVertical: 5,
  },
  driverContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginVertical: 10,
  },
  driverInfo: {
    marginLeft: 15,
    flex: 1,
  },
  driverName: {
    fontSize: 18,
    fontWeight: 'bold',
  },
  driverRating: {
    fontSize: 14,
    color: '#FFA500',
    marginTop: 4,
  },
  driverUniversity: {
    fontSize: 12,
    color: COLORS.textSecondary,
    marginTop: 4,
  },
  bio: {
    marginTop: 10,
    fontStyle: 'italic',
    color: COLORS.textSecondary,
  },
  buttonContainer: {
    margin: 15,
    marginTop: 10,
  },
  bookButton: {
    backgroundColor: COLORS.primary,
  },
  bookButtonContent: {
    paddingVertical: 8,
  },
  fullText: {
    textAlign: 'center',
    fontSize: 16,
    color: '#F44336',
    fontWeight: 'bold',
  },
});
