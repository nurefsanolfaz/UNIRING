import React from 'react';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { createStackNavigator } from '@react-navigation/stack';
import { MaterialCommunityIcons as Icon } from '@expo/vector-icons';
import HomeScreen from '../screens/rides/HomeScreen';
import CreateRideScreen from '../screens/rides/CreateRideScreen';
import RideDetailScreen from '../screens/rides/RideDetailScreen';
import MyRidesScreen from '../screens/rides/MyRidesScreen';
import ProfileScreen from '../screens/ProfileScreen';
import { COLORS } from '../constants/config';

const Tab = createBottomTabNavigator();
const Stack = createStackNavigator();

// Ana Yolculuk Stack'i
function RidesStack() {
  return (
    <Stack.Navigator
      screenOptions={{
        headerStyle: {
          backgroundColor: COLORS.primary,
        },
        headerTintColor: '#fff',
        headerTitleStyle: {
          fontWeight: 'bold',
        },
      }}
    >
      <Stack.Screen 
        name="Home" 
        component={HomeScreen}
        options={{ title: 'Seferler' }}
      />
      <Stack.Screen 
        name="RideDetail" 
        component={RideDetailScreen}
        options={{ title: 'Sefer Detayı' }}
      />
      <Stack.Screen 
        name="CreateRide" 
        component={CreateRideScreen}
        options={{ title: 'Sefer Oluştur' }}
      />
    </Stack.Navigator>
  );
}

// Seferlerim Stack'i
function MyRidesStack() {
  return (
    <Stack.Navigator
      screenOptions={{
        headerStyle: {
          backgroundColor: COLORS.primary,
        },
        headerTintColor: '#fff',
        headerTitleStyle: {
          fontWeight: 'bold',
        },
      }}
    >
      <Stack.Screen 
        name="MyRidesMain" 
        component={MyRidesScreen}
        options={{ title: 'Seferlerim' }}
      />
      <Stack.Screen 
        name="CreateRide" 
        component={CreateRideScreen}
        options={{ title: 'Sefer Oluştur' }}
      />
      <Stack.Screen 
        name="RideDetail" 
        component={RideDetailScreen}
        options={{ title: 'Sefer Detayı' }}
      />
    </Stack.Navigator>
  );
}

// Alt Tab Navigasyon
export default function MainTabNavigator() {
  return (
    <Tab.Navigator
      screenOptions={({ route }) => ({
        tabBarActiveTintColor: COLORS.primary,
        tabBarInactiveTintColor: '#9E9E9E',
        tabBarStyle: {
          position: 'absolute',
          bottom: 20,
          left: 15,
          right: 15,
          height: 70,
          borderRadius: 20,
          backgroundColor: '#FFFFFF',
          borderTopWidth: 0,
          elevation: 12,
          shadowColor: '#000',
          shadowOffset: { width: 0, height: 8 },
          shadowOpacity: 0.15,
          shadowRadius: 16,
          paddingBottom: 10,
          paddingTop: 10,
        },
        tabBarLabelStyle: {
          fontSize: 11,
          fontWeight: '700',
          marginTop: 4,
        },
        tabBarItemStyle: {
          paddingVertical: 6,
        },
        tabBarIcon: ({ focused, color }) => {
          let iconName;
          let iconSize = focused ? 30 : 26;
          
          if (route.name === 'RidesTab') {
            iconName = focused ? 'compass' : 'compass-outline';
          } else if (route.name === 'MyRidesTab') {
            iconName = focused ? 'car-multiple' : 'car-outline';
          } else if (route.name === 'Profile') {
            iconName = focused ? 'account-circle' : 'account-circle-outline';
          }
          
          return (
            <Icon 
              name={iconName} 
              color={color} 
              size={iconSize}
              style={{
                marginTop: 4,
              }}
            />
          );
        },
      })}
    >
      <Tab.Screen 
        name="RidesTab" 
        component={RidesStack}
        options={{
          headerShown: false,
          tabBarLabel: 'Keşfet',
        }}
      />
      <Tab.Screen 
        name="MyRidesTab" 
        component={MyRidesStack}
        options={{
          headerShown: false,
          tabBarLabel: 'Seferlerim',
        }}
      />
      <Tab.Screen 
        name="Profile" 
        component={ProfileScreen}
        options={{
          headerShown: true,
          headerStyle: {
            backgroundColor: COLORS.primary,
          },
          headerTintColor: '#fff',
          headerTitleStyle: {
            fontWeight: 'bold',
          },
          title: 'Profil',
          tabBarLabel: 'Profil',
        }}
      />
    </Tab.Navigator>
  );
}
