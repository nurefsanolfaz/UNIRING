-- UNIRING Database Oluşturma Script
-- SQLTools ile çalıştırılacak

-- Database oluştur
CREATE DATABASE IF NOT EXISTS uniring 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- Database'i kullan
USE uniring;

-- Başarılı mesajı
SELECT 'Database oluşturuldu!' AS message;
