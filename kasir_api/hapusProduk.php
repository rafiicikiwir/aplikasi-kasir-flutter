<?php
include 'koneksi.php';

$id = $_POST['id'];

$query = "DELETE FROM produk WHERE id='$id'";

if (mysqli_query($conn, $query)) {
    echo json_encode(['success' => true, 'message' => 'Produk berhasil dihapus']);
} else {
    echo json_encode(['success' => false, 'message' => 'Gagal menghapus produk']);
}
?>