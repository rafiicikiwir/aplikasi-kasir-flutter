<?php
include 'koneksi.php';

$username = $_POST['username'];
$password = $_POST['password'];

$query = "SELECT * FROM kasir WHERE username='$username' AND password='$password'";
$result = mysqli_query($conn, $query);

if (mysqli_num_rows($result) > 0) {
    $data = mysqli_fetch_assoc($result);
    echo json_encode([
        'success' => true,
        'message' => 'Login berhasil',
        'data' => $data
    ]);
} else {
    echo json_encode([
        'success' => false,
        'message' => 'Username atau password salah'
    ]);
}
?>