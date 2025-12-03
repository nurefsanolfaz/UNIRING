import React, { useState } from 'react';
import { View, StyleSheet, ScrollView } from 'react-native';
import { Text, Button, Avatar, Card, List, Divider } from 'react-native-paper';
import { useAuth } from '../context/AuthContext';
import { COLORS, FONTS } from '../constants/config';
import { MaterialCommunityIcons as Icon } from '@expo/vector-icons';

export default function ProfileScreen({ navigation }) {
  const { user, logout } = useAuth();
  const [accountInfoExpanded, setAccountInfoExpanded] = useState(false);
  const [statsExpanded, setStatsExpanded] = useState(false);

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
        {/* Kompakt Profil Başlığı */}
        <View style={styles.header}>
          <Avatar.Text 
            size={60} 
            label={getInitials()}
            style={styles.avatar}
            color="#FFFFFF"
          />
          <View style={styles.userInfo}>
            <Text style={styles.name}>
              {user?.first_name || user?.ad || 'Kullanıcı'} {user?.last_name || user?.soyad || ''}
            </Text>
            <Text style={styles.subtitle}>
              {user?.email || 'E-posta belirtilmemiş'}
            </Text>
          </View>
        </View>

        {/* Hesap Bilgileri - Açılır Menü */}
        <Card mode="contained" style={styles.card}>
          <List.Accordion
            title="Hesap Bilgileri"
            titleStyle={styles.accordionTitle}
            left={props => <Icon name="account-details" size={24} color={COLORS.primary} />}
            expanded={accountInfoExpanded}
            onPress={() => setAccountInfoExpanded(!accountInfoExpanded)}
            style={styles.accordion}
          >
            <View style={styles.accordionContent}>
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
            </View>
          </List.Accordion>
        </Card>

        {/* İstatistikler - Açılır Menü */}
        <Card mode="contained" style={styles.card}>
          <List.Accordion
            title="İstatistikler"
            titleStyle={styles.accordionTitle}
            left={props => <Icon name="chart-bar" size={24} color={COLORS.primary} />}
            expanded={statsExpanded}
            onPress={() => setStatsExpanded(!statsExpanded)}
            style={styles.accordion}
          >
            <View style={styles.accordionContent}>
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
            </View>
          </List.Accordion>
        </Card>

        {/* Menü */}
        <Card mode="contained" style={[styles.card, styles.menuCard]}>
          <Card.Content style={styles.cardContent}>
            <List.Item
              title="Rezervasyonlarım"
              titleStyle={styles.menuItemTitle}
              left={() => <Icon name="ticket-confirmation" size={24} color={COLORS.primary} />}
              right={() => <Icon name="chevron-right" size={24} color={COLORS.textSecondary} />}
              onPress={() => navigation.navigate('MyBookings')}
            />
            <Divider />
            <List.Item
              title="Araçlarım"
              titleStyle={styles.menuItemTitle}
              left={() => <Icon name="car-multiple" size={24} color={COLORS.primary} />}
              right={() => <Icon name="chevron-right" size={24} color={COLORS.textSecondary} />}
              onPress={() => navigation.navigate('MyVehicles')}
            />
            <Divider />
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
    paddingHorizontal: 16,
    paddingBottom: 120,
    paddingTop: 12,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#FFFFFF',
    padding: 16,
    borderRadius: 16,
    marginBottom: 16,
    shadowColor: '#1E88E5',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.08,
    shadowRadius: 8,
    elevation: 3,
  },
  avatar: {
    backgroundColor: COLORS.primary,
  },
  userInfo: {
    marginLeft: 16,
    flex: 1,
  },
  name: {
    ...FONTS.bold,
    fontSize: 18,
    color: COLORS.text,
    marginBottom: 2,
  },
  subtitle: {
    ...FONTS.regular,
    fontSize: 13,
    color: COLORS.textSecondary,
  },
  card: {
    marginBottom: 12,
    borderRadius: 16,
    backgroundColor: '#FFFFFF',
    shadowColor: '#1E88E5',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.08,
    shadowRadius: 8,
    elevation: 3,
    overflow: 'hidden',
  },
  accordion: {
    backgroundColor: '#FFFFFF',
    paddingVertical: 4,
  },
  accordionTitle: {
    ...FONTS.semiBold,
    fontSize: 16,
    color: COLORS.text,
  },
  accordionContent: {
    paddingHorizontal: 16,
    paddingBottom: 12,
    backgroundColor: '#F9FAFB',
  },
  infoRow: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 10,
  },
  infoText: {
    marginLeft: 12,
    flex: 1,
  },
  infoLabel: {
    fontSize: 12,
    color: COLORS.textSecondary,
    marginBottom: 2,
  },
  infoValue: {
    ...FONTS.medium,
    fontSize: 14,
    color: COLORS.text,
  },
  statsRow: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    paddingVertical: 12,
  },
  statBox: {
    alignItems: 'center',
    backgroundColor: '#FFFFFF',
    borderRadius: 12,
    paddingVertical: 12,
    paddingHorizontal: 16,
    minWidth: 85,
    borderWidth: 1,
    borderColor: '#E3F2FD',
  },
  statValue: {
    ...FONTS.bold,
    fontSize: 24,
    color: COLORS.primary,
  },
  statLabel: {
    ...FONTS.regular,
    fontSize: 11,
    color: COLORS.textSecondary,
    marginTop: 4,
  },
  menuCard: {
    backgroundColor: '#FFFFFF',
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
