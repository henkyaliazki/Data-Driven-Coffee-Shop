# ☕ Data-Driven Coffee Shop: Mengoptimalkan Operasional & Profitabilitas Kopi Senja dengan SQL

![SQL](https://img.shields.io/badge/SQL-Terapan-blue) ![Data Analysis](https://img.shields.io/badge/Data-Analysis-brightgreen) ![Business Intelligence](https://img.shields.io/badge/Business-Intelligence-orange)

## 📌 Ringkasan Eksekutif
Proyek analitik ini menggunakan SQL untuk membedah data transaksi *Point of Sale* (POS) harian dari sebuah kedai kopi. Sebagai analis dengan latar belakang operasional *Food & Beverage* (F&B) dan teknologi informasi, saya tidak hanya mengekstrak data mentah, tetapi menerjemahkannya menjadi strategi operasional. Analisis ini berfokus pada penguraian *bottleneck* antrean di jam sibuk, identifikasi produk penyumbang pendapatan terbesar (*revenue generator*), dan meminimalisir limbah bahan baku (*waste*) dari menu yang tidak laku.

## 🛠️ Tools & Teknologi
- **SQL** (agregasi, *grouping*, *filtering* dengan `HAVING`)
- **Spreadsheet / POS Export** untuk sumber data transaksi harian
- **Business Analysis Framework** untuk menerjemahkan hasil query menjadi aksi operasional

## 🧠 Key Skills yang Ditunjukkan
- **SQL Querying & Data Aggregation** untuk menjawab masalah bisnis nyata
- **Operational Analytics** untuk identifikasi pola *rush hour* dan bottleneck layanan
- **Profitability Analysis** untuk menemukan kategori produk penyumbang pendapatan utama
- **Inventory Decision Support** untuk mendeteksi menu *slow-moving* dan risiko *waste*
- **Business Communication** dalam bentuk rekomendasi yang siap dieksekusi manajemen

---

## 🎯 Latar Belakang & Masalah Bisnis
Manajemen "Kopi Senja" menghadapi tiga tantangan operasional utama di lapangan:
1. **Workforce Allocation:** Sering terjadi antrean panjang di pagi hari, namun manajemen belum memiliki data pasti kapan tepatnya *rush hour* terjadi untuk mengoptimalkan jadwal *shift* barista.
2. **Profitability Tracking:** Kategori menu apa yang sebenarnya menjadi tulang punggung finansial kedai?
3. **Inventory Efficiency:** Menu apa yang perputarannya sangat lambat (*slow-moving*) dan berisiko menjadi *waste* jika bahan bakunya terus di-stock?

## 🗄️ Persiapan Data (Dataset)
Data yang dianalisis adalah simulasi transaksi kasir yang memuat: `id_transaksi`, `tanggal`, `jam`, `nama_menu`, `kategori`, `harga`, dan `jumlah` (cup/porsi).

## ▶️ How to Run
### Opsi 1 — SQLOnline
1. Buka SQL editor online yang Anda gunakan.
2. Jalankan isi file `database/kopi_senja_seed.sql` untuk membuat tabel dan mengisi data.
3. Jalankan isi file `database/analysis_queries.sql` untuk melihat hasil analisis.

### Opsi 2 — SQLite Lokal
```bash
sqlite3 database/kopi_senja.db < database/kopi_senja_seed.sql
sqlite3 database/kopi_senja.db < database/analysis_queries.sql
```

Jika ingin menjalankan seed berulang kali, gunakan dulu:
```sql
DROP TABLE IF EXISTS transaksi_kopi;
```

---

## 🔍 Analisis Data & Eksekusi SQL

### 1. Mengidentifikasi Kemacetan Operasional (Rush Hour)
Untuk mengurai antrean, kita perlu mengidentifikasi jam berapa mesin *espresso* bekerja melampaui kapasitas idealnya.

```sql
SELECT jam, COUNT(*) AS total_transaksi
FROM transaksi_kopi
GROUP BY jam 
ORDER BY total_transaksi DESC;
```

### 2. Mengevaluasi Kategori yang Paling Menguntungkan
Untuk mengetahui kategori yang paling berdampak pada pendapatan, gunakan agregasi total pendapatan dan volume penjualan per kategori.

```sql
SELECT kategori,
	   SUM(harga * jumlah) AS total_pendapatan,
	   SUM(jumlah) AS total_cup
FROM transaksi_kopi
GROUP BY kategori
HAVING total_pendapatan > 50000;
```

### 3. Mencari Menu yang Sangat Jarang Dipesan
Analisis ini membantu mengidentifikasi menu *slow-moving* yang berpotensi menimbulkan pemborosan bahan baku.

```sql
SELECT nama_menu, SUM(jumlah) AS total_terjual
FROM transaksi_kopi
GROUP BY nama_menu
HAVING total_terjual = 1;
```

---

## 💡 Rekomendasi Bisnis Terapan
Berdasarkan data di atas, berikut adalah langkah strategis yang direkomendasikan untuk manajemen:

1. **Optimasi Tenaga Kerja (Workforce Optimization):** Kedai wajib menugaskan 1 part-timer tambahan khusus di jam 07:00 - 09:30 pagi. Tambahan tenaga ini difokuskan pada station non-kopi atau kasir untuk mempercepat *flow* dari *grinder* ke tangan pelanggan, sehingga mencegah hilangnya potensi penjualan akibat pelanggan yang membatalkan pesanan karena antrean panjang.

2. **Fokus Anggaran Marketing:** Alokasikan anggaran promosi digital atau buat paket promosi bundling pagi hari yang berfokus pada kategori pemenang (penyumbang *revenue* terbesar) untuk memaksimalkan *basket size*.

3. **Penyesuaian Inventaris (Inventory Adjustment):** Turunkan batas aman stok (*par level*) bahan baku untuk menu *slow-moving* yang teridentifikasi. Hal ini akan mencegah *cash flow* kedai tertahan pada barang yang diam di kulkas dan berisiko kedaluwarsa.

---

## ✅ Kesimpulan
Melalui pendekatan analitik berbasis SQL, manajemen Kopi Senja kini memiliki dasar keputusan yang lebih objektif untuk menjalankan operasional harian. Identifikasi *rush hour* membantu penjadwalan tenaga kerja secara presisi, analisis profitabilitas kategori mengarahkan fokus promosi ke produk bernilai tinggi, dan deteksi menu *slow-moving* menekan risiko pemborosan inventaris. Secara keseluruhan, strategi ini mendorong operasional yang lebih efisien, penjualan yang lebih optimal, serta profitabilitas kedai yang lebih berkelanjutan.

## 📈 Impact Metrics (KPI yang Direkomendasikan)
Untuk mengukur dampak implementasi rekomendasi, metrik berikut dapat dipantau mingguan:
- **Average Service Time** pada jam 07:00 - 09:30
- **Jumlah transaksi per jam sibuk** setelah penyesuaian tenaga kerja
- **Kontribusi pendapatan per kategori** sebelum vs sesudah fokus promosi
- **Persentase menu slow-moving** dan nilai *waste* bahan baku
- **Nilai rata-rata transaksi (basket size)** untuk evaluasi efektivitas bundling