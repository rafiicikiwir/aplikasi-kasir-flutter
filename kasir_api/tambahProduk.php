<?php
include 'koneksi.php';

$nama_produk = $_POST['nama_produk'];
$harga = $_POST['harga'];
$stok = $_POST['stok'];

$query = "INSERT INTO produk (nama_produk, harga, stok) 
          VALUES ('$nama_produk', '$harga', '$stok')";

if (mysqli_query($conn, $query)) {
    echo json_encode(['success' => true, 'message' => 'Produk berhasil ditambahkan']);
} else {
    echo json_encode(['success' => false, 'message' => 'Gagal menambahkan produk']);
}
?>