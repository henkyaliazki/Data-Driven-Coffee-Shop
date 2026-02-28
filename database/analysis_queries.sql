-- Query 1: Rush hour
SELECT jam, COUNT(*) AS total_transaksi
FROM transaksi_kopi
GROUP BY jam
ORDER BY total_transaksi DESC;

-- Query 2: Kategori paling menguntungkan
SELECT kategori,
       SUM(harga * jumlah) AS total_pendapatan,
       SUM(jumlah) AS total_cup
FROM transaksi_kopi
GROUP BY kategori
HAVING total_pendapatan > 50000;

-- Query 3: Menu sangat jarang dipesan
SELECT nama_menu, SUM(jumlah) AS total_terjual
FROM transaksi_kopi
GROUP BY nama_menu
HAVING total_terjual = 1;
