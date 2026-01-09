APLIKASI RESEP MASAKAN FLUTTER
Deskripsi Aplikasi:
Aplikasi mobile untuk mengelola resep masakan dengan integrasi backend Supabase. Dibuat untuk memenuhi tugas Coding On The Spot (COTS) mata kuliah Pemrograman Perangkat Bergerak.

Fitur Utama:

Dashboard dengan statistik resep

Daftar resep dengan filter kategori

Detail resep lengkap

Tambah resep baru

Edit catatan resep

Teknologi yang Digunakan:

Flutter 3.x

Dart 3.x

Provider (State Management)

Supabase REST API

HTTP Client

Struktur Folder:

main.dart - Entry point aplikasi

design_system/ - Warna, tipografi, spacing

models/ - Data model resep

services/ - API service ke Supabase

controllers/ - Business logic dengan Provider

presentation/pages/ - 4 halaman utama

presentation/widgets/ - Komponen UI reusable

Halaman Utama:

Dashboard (Beranda) - Menampilkan statistik dan resep terbaru

Daftar Resep - List semua resep dengan filter kategori

Detail Resep - Informasi lengkap satu resep

Tambah Resep - Form input resep baru

Persyaratan Sistem:

Flutter SDK versi 3.0.0 atau lebih tinggi

Dart SDK versi 3.0.0 atau lebih tinggi

Koneksi internet untuk mengakses Supabase

Cara Instalasi:

Clone repository

Jalankan flutter pub get

Jalankan flutter run

API Supabase:

Base URL: https://rpblbedygmnzpowbumzd.supabase.co

Endpoints: GET recipes, POST recipes, PATCH recipes

Fitur Teknis:

Validasi input form

Error handling

Loading states

Refresh indicator

Responsive design

Developer:
Ryan Gabriel Togar 
2311104045
Kelas: SE-07-02
Semester: Ganjil 2025/2026

Status:
✅ Selesai sesuai requirements
✅ Integrasi dengan Supabase
✅ 4 halaman utama
✅ State management dengan Provider
✅ Design system konsisten
