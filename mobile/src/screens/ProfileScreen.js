import React from 'react';
import { View, StyleSheet, ScrollView } from 'react-native';
import { Text, Button, Avatar, Card, List, Divider } from 'react-native-paper';
import { useAuth } from '../context/AuthContext';
import { COLORS, FONTS } from '../constants/config';
import { MaterialCommunityIcons as Icon } from '@expo/vector-icons';

export default function ProfileScreen() {
  const { user, logout } = useAuth();

  const handleLogout = () => {
    logout();
  };

  // Kullanıcı baş harfleri
  const getInitials = () => {
    if (!user) return '?';
    const firstName = user.first_name || user.ad || '';
    const lastName = user.last_name || user.soyad || '';
    return `${firstName.charAt(0)}${lastName.charAt(0)}`.toUpperCase();
  };

  return (
    <ScrollView style={styles.container}>
      <View style={styles.content}>
        {/* Profil Başlığı */}
        <View style={styles.header}>
          <Avatar.Text 
            size={100} 
            label={getInitials()}
            style={styles.avatar}
            color="#FFFFFF"
          />
          <Text style={styles.name}>
            {user?.first_name || user?.ad || 'Kullanıcı'} {user?.last_name || user?.soyad || ''}
          </Text>
          <Text style={styles.subtitle}>
            {user?.email || 'E-posta belirtilmemiş'}
          </Text>
        </View>

        {/* Hesap Bilgileri Kartı */}
        <Card mode="contained" style={[styles.card, styles.infoCard]}>
          <Card.Content style={styles.cardContent}>
            <Text style={styles.cardTitle}>Hesap Bilgileri</Text>
            <Divider style={styles.divider} />
            
            <View style={styles.infoRow}>
              <Icon name="phone" size={20} color={COLORS.primary} />
              <View style={styles.infoText}>
                <Text style={styles.infoLabel}>Telefon</Text>
                <Text style={styles.infoValue}>
                  {user?.phone_number || user?.telefon || 'Belirtilmemiş'}
                </Text>
              </View>
            </View>

            <View style={styles.infoRow}>
              <Icon name="school" size={20} color={COLORS.primary} />
              <View style={styles.infoText}>
                <Text style={styles.infoLabel}>Üniversite ID</Text>
                <Text style={styles.infoValue}>
                  {user?.universitID || user?.universite_id || 'Belirtilmemiş'}
                </Text>
              </View>
            </View>

            <View style={styles.infoRow}>
              <Icon name="shield-check" size={20} color={COLORS.primary} />
              <View style={styles.infoText}>
                <Text style={styles.infoLabel}>Güvenlik Skoru</Text>
                <Text style={styles.infoValue}>
                  {user?.guvenlikSkoru || user?.guvenlik_skoru || '100'} / 100
                </Text>
              </View>
            </View>
          </Card.Content>
        </Card>

        {/* İstatistikler */}
        <Card mode="contained" style={[styles.card, styles.statsCard]}>
          <Card.Content style={styles.cardContent}>
            <Text style={styles.cardTitle}>İstatistikler</Text>
            <Divider style={styles.divider} />
            <View style={styles.statsRow}>
              <View style={styles.statBox}>
                <Text style={styles.statValue}>0</Text>
                <Text style={styles.statLabel}>Yolculuk</Text>
              </View>
              <View style={styles.statBox}>
                <Text style={styles.statValue}>0</Text>
                <Text style={styles.statLabel}>Rezervasyon</Text>
              </View>
              <View style={styles.statBox}>
                <Text style={styles.statValue}>0</Text>
                <Text style={styles.statLabel}>Değerlendirme</Text>
              </View>
            </View>
          </Card.Content>
        </Card>

        {/* Menü */}
        <Card mode="contained" style={[styles.card, styles.menuCard]}>
          <Card.Content style={styles.cardContent}>
            <List.Item
              title="Ayarlar"
              titleStyle={styles.menuItemTitle}
              left={() => <Icon name="cog" size={24} color={COLORS.primary} />}
              right={() => <Icon name="chevron-right" size={24} color={COLORS.textSecondary} />}
              onPress={() => {}}
            />
            <Divider />
            <List.Item
              title="Yardım & Destek"
              titleStyle={styles.menuItemTitle}
              left={() => <Icon name="help-circle" size={24} color={COLORS.primary} />}
              right={() => <Icon name="chevron-right" size={24} color={COLORS.textSecondary} />}
              onPress={() => {}}
            />
            <Divider />
            <List.Item
              title="Gizlilik Politikası"
              titleStyle={styles.menuItemTitle}
              left={() => <Icon name="shield-account" size={24} color={COLORS.primary} />}
              right={() => <Icon name="chevron-right" size={24} color={COLORS.textSecondary} />}
              onPress={() => {}}
            />
          </Card.Content>
        </Card>

        {/* Çıkış Butonu */}
        <Button
          mode="contained"
          onPress={handleLogout}
          style={styles.logoutButton}
          buttonColor="#E53935"
          icon="logout"
        >
          Çıkış Yap
        </Button>
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5F9FC',
  },
  content: {
    paddingHorizontal: 20,
    paddingBottom: 120,
  },
  header: {
    alignItems: 'center',
    marginBottom: 24,
    paddingVertical: 20,
  },
  avatar: {
    backgroundColor: COLORS.primary,
    marginBottom: 16,
  },
  name: {
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
    marginBottom: 16,
    borderRadius: 16,
    borderWidth: 1,
    borderColor: '#E3F2FD',
    backgroundColor: '#FFFFFF',
    shadowColor: '#1E88E5',
    shadowOffset: { width: 0, height: 8 },
    shadowOpacity: 0.08,
    shadowRadius: 16,
    elevation: 4,
  },
  infoCard: {
    paddingTop: 4,
  },
  statsCard: {
    backgroundColor: '#FFFFFF',
  },
  menuCard: {
    backgroundColor: '#FFFFFF',
  },
  cardContent: {
    paddingVertical: 8,
  },
  cardTitle: {
    ...FONTS.semiBold,
    fontSize: 18,
    color: COLORS.text,
    marginBottom: 8,
  },
  divider: {
    marginBottom: 16,
  },
  infoRow: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
  },
  infoText: {
    marginLeft: 16,
    flex: 1,
  },
  infoLabel: {
    fontSize: 12,
    color: COLORS.textSecondary,
    marginBottom: 4,
  },
  infoValue: {
    ...FONTS.medium,
    fontSize: 15,
    color: COLORS.text,
  },
  statsRow: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    paddingVertical: 8,
  },
  statBox: {
    alignItems: 'center',
    backgroundColor: '#F5F9FC',
    borderRadius: 14,
    paddingVertical: 12,
    paddingHorizontal: 16,
    minWidth: 90,
  },
  statValue: {
    ...FONTS.bold,
    fontSize: 28,
    color: COLORS.primary,
  },
  statLabel: {
    ...FONTS.regular,
    fontSize: 12,
    color: COLORS.textSecondary,
    marginTop: 4,
  },
  menuItemTitle: {
    ...FONTS.medium,
    color: COLORS.text,
  },
  logoutButton: {
    marginTop: 8,
    paddingVertical: 8,
    borderRadius: 12,
  },
});
