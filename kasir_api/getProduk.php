<?php
include 'koneksi.php';

$query = "SELECT * FROM produk ORDER BY id DESC";
$result = mysqli_query($conn, $query);

$data = [];
while ($row = mysqli_fetch_assoc($result)) {
    $data[] = $row;
}

echo json_encode($data);
?>