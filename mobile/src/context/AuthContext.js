import React, { createContext, useState, useContext, useEffect } from 'react';
import { checkAuth, getUserData, logout as authLogout } from '../services/authService';

const AuthContext = createContext();

export const AuthProvider = ({ children }) => {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  // Uygulama açıldığında giriş kontrolü
  useEffect(() => {
    checkAuthStatus();
  }, []);

  const checkAuthStatus = async () => {
    const isLoggedIn = await checkAuth();
    setIsAuthenticated(isLoggedIn);
    
    if (isLoggedIn) {
      const userData = await getUserData();
      setUser(userData);
    }
    
    setLoading(false);
  };

  const login = (userData, token) => {
    setUser(userData);
    setIsAuthenticated(true);
  };

  const logout = async () => {
    await authLogout();
    setUser(null);
    setIsAuthenticated(false);
  };

  return (
    <AuthContext.Provider
      value={{
        isAuthenticated,
        user,
        loading,
        login,
        logout,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within AuthProvider');
  }
  return context;
};
