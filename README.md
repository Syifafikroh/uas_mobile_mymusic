# MyMusic App 🎧  
(Ujian Akhir Semester – Mobile Programming)

## 📱 Deskripsi Aplikasi
MyMusic merupakan aplikasi mobile berbasis Flutter yang dikembangkan sebagai
pengembangan lanjutan dari project Ujian Tengah Semester (UTS).
Aplikasi ini menampilkan data musik secara real-time dengan mengintegrasikan
RESTful API publik, sehingga data lagu, album, dan detail informasi tidak lagi
menggunakan data statis (hardcoded).

Aplikasi menyediakan fitur pencarian lagu, daftar album, detail lagu,
serta pemutaran preview audio yang diambil langsung dari server melalui
protokol HTTP.

---

## 🌐 API yang Digunakan
Aplikasi ini menggunakan **iTunes Search API** (API publik dan gratis).

### Base URL
[https://itunes.apple.com/search](https://itunes.apple.com/search)


### Endpoint yang Digunakan
- Pencarian lagu berdasarkan kata kunci:
https://itunes.apple.com/search?term={query}&entity=song

Contoh:
[https://itunes.apple.com/search?term=pop&entity=song](https://itunes.apple.com/search?term=pop&entity=song)

### Data yang Digunakan dari API
- Judul lagu (trackName)
- Nama penyanyi (artistName)
- Gambar album (artworkUrl100)
- Genre musik (primaryGenreName)
- Preview audio (previewUrl)

---

## ⚙️ Cara Instalasi & Menjalankan Aplikasi

#### 1. Clone Repository
[git clone https://github.com/Syifafikroh/uas_mobile_mymusic.git](git clone https://github.com/Syifafikroh/uas_mobile_mymusic.git)
#### 2. Masuk ke Folder Project
#### 3. Install Dependency
#### 4. Jalankan Aplikasi

Pastikan perangkat/emulator terhubung dan koneksi internet aktif,
karena data diambil langsung dari API.

---

## ✨ Fitur Utama
- Menampilkan daftar lagu dari API (HTTP GET)
- Pencarian lagu secara real-time
- Detail lagu dan preview audio
- Loading, Success, dan Error handling
- Desain UI responsif dan estetik

---

## 📝 Catatan
Aplikasi ini dibuat untuk memenuhi tugas **Ujian Akhir Semester (UAS)**
mata kuliah **Mobile Programming**.



