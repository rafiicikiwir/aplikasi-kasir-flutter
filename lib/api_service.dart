import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost/kasir_api';

  // LOGIN
  static Future<Map<String, dynamic>> login(
    String username,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login.php'),
      body: {'username': username, 'password': password},
    );
    return json.decode(response.body);
  }

  // GET PRODUK
  static Future<List<dynamic>> getProduk() async {
    final response = await http.get(Uri.parse('$baseUrl/getProduk.php'));
    return json.decode(response.body);
  }

  // TAMBAH PRODUK
  static Future<Map<String, dynamic>> tambahProduk(
    String nama,
    int harga,
    int stok,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tambahProduk.php'),
      body: {
        'nama_produk': nama,
        'harga': harga.toString(),
        'stok': stok.toString(),
      },
    );
    return json.decode(response.body);
  }

  // EDIT PRODUK
  static Future<Map<String, dynamic>> editProduk(
    int id,
    String nama,
    int harga,
    int stok,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/editProduk.php'),
      body: {
        'id': id.toString(),
        'nama_produk': nama,
        'harga': harga.toString(),
        'stok': stok.toString(),
      },
    );
    return json.decode(response.body);
  }

  // HAPUS PRODUK
  static Future<Map<String, dynamic>> hapusProduk(int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/hapusProduk.php'),
      body: {'id': id.toString()},
    );
    return json.decode(response.body);
  }
}
