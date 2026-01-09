# 🍳 Resep Masakan - Flutter App

<div align="center">
  
![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)
![Provider](https://img.shields.io/badge/State%20Management-Provider-FF9800?style=for-the-badge)

**Aplikasi manajemen resep masakan dengan backend Supabase**  
*Tugas COTS - Pemrograman Perangkat Bergerak 2025/2026*

[✨ Fitur](#-fitur) • [🏗️ Struktur](#%EF%B8%8F-struktur) • [🚀 Instalasi](#-instalasi) • [📸 Screenshot](#-screenshot)

</div>

## 📱 Aplikasi Resep Masakan

Aplikasi mobile Flutter untuk mengelola resep masakan dengan integrasi real-time ke Supabase sebagai backend.

---

## ✨ Fitur Utama

### 🎯 **Fitur Pengguna**
- 📊 **Dashboard** dengan statistik resep per kategori
- 📋 **Daftar Resep** dengan filter kategori
- 🔍 **Detail Resep** lengkap dengan bahan & langkah
- ➕ **Tambah Resep** baru dengan form validasi
- ✏️ **Edit Catatan** resep secara real-time

### ⚙️ **Fitur Teknis**
- 🌐 **Supabase Integration** - REST API backend
- 🏗️ **Clean Architecture** - Struktur folder terorganisir
- 🎨 **Design System** - Konsisten warna & typography
- 📱 **Responsive UI** - Optimal di semua device
- 🔄 **Provider State Management** - State management modern

---

## 🏗️ Struktur Project

---

## 🚀 Instalasi & Setup

### Prerequisites
- ✅ Flutter SDK >= 3.0.0
- ✅ Dart SDK >= 3.0.0
- ✅ IDE (VS Code / Android Studio)
- ✅ Git

📸 Screenshot Aplikasi
🏠 Dashboard
https://via.placeholder.com/400x800/4A90E2/FFFFFF?text=Dashboard+Screen
Statistik resep & kategori

📋 Daftar Resep
https://via.placeholder.com/400x800/7B68EE/FFFFFF?text=Recipe+List
List resep dengan filter kategori

🔍 Detail Resep
https://via.placeholder.com/400x800/20B2AA/FFFFFF?text=Recipe+Detail
Detail lengkap resep dengan bahan & langkah

➕ Tambah Resep
https://via.placeholder.com/400x800/FF6347/FFFFFF?text=Add+Recipe
Form input resep baru

🔧 API Endpoints
Method	Endpoint	Deskripsi
GET	/recipes?select=*	Ambil semua resep
GET	/recipes?category=eq.{category}	Filter by kategori
POST	/recipes	Tambah resep baru
PATCH	/recipes?id=eq.{id}	Update catatan resep
🎨 Design System
Colors
dart
Primary: #1275F7
Background: #F7F7F7
Surface: #FFFFFF
Text: #333333
Danger: #E74444
Success: #4CAF50
Typography
Title Large: 20px SemiBold

Section Title: 16px SemiBold

Body: 14px Regular

Caption: 12px Regular

Button: 14px SemiBold

Spacing
Base: 8pt grid system

Border Radius: 12px

Button Height: 48px

Card Padding: 18px

📁 Requirements Tugas
✅ Yang Sudah Terpenuhi
4 halaman utama (Dashboard, Daftar, Detail, Tambah)

Integrasi Supabase API

State Management dengan Provider

Design system konsisten

Validasi input form

Error handling

Navigasi antar halaman

Folder structure terorganisir

🔗 Navigasi
Dashboard → Daftar Resep

Dashboard → Detail Resep

Dashboard → Tambah Resep

Daftar Resep → Detail Resep

Daftar Resep → Tambah Resep


👨‍💻 Developer
Nama: Ryan Gabriel Togar Simamora
NIM: 2311104045
Kelas: SE-07-02
Mata Kuliah: Pemrograman Perangkat Bergerak
Semester: Ganjil 2025/2026
