<?php
include 'koneksi.php';

$id = $_POST['id'];
$nama_produk = $_POST['nama_produk'];
$harga = $_POST['harga'];
$stok = $_POST['stok'];

$query = "UPDATE produk SET 
          nama_produk='$nama_produk', 
          harga='$harga', 
          stok='$stok' 
          WHERE id='$id'";

if (mysqli_query($conn, $query)) {
    echo json_encode(['success' => true, 'message' => 'Produk berhasil diupdate']);
} else {
    echo json_encode(['success' => false, 'message' => 'Gagal mengupdate produk']);
}
?>