<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

$host = 'localhost';
$user = 'root';
$pass = '';
$db = 'kasir';

$conn = mysqli_connect($host, $user, $pass, $db);

if (!$conn) {
    die(json_encode(['error' => 'Koneksi gagal']));
}
?>