import 'package:flutter/material.dart';
import 'api_service.dart';
import 'form_produk.dart';

class HalamanProduk extends StatefulWidget {
  final String namaKasir;
  const HalamanProduk({super.key, required this.namaKasir});

  @override
  _HalamanProdukState createState() => _HalamanProdukState();
}

class _HalamanProdukState extends State<HalamanProduk> {
  List<dynamic> _produkList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProduk();
  }

  void _loadProduk() async {
    setState(() => _isLoading = true);
    final data = await ApiService.getProduk();
    setState(() {
      _produkList = data;
      _isLoading = false;
    });
  }

  void _hapusProduk(int id) async {
    final result = await ApiService.hapusProduk(id);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(result['message'])));
    if (result['success']) _loadProduk();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Data Produk'),
            Text('Kasir: ${widget.namaKasir}', style: TextStyle(fontSize: 14)),
          ],
        ),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _produkList.isEmpty
          ? Center(child: Text('Belum ada produk'))
          : ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: _produkList.length,
              itemBuilder: (context, index) {
                final produk = _produkList[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[700],
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      produk['nama_produk'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Harga: Rp ${produk['harga']} | Stok: ${produk['stok']}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.orange),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FormProduk(
                                  produk: produk,
                                  onSave: _loadProduk,
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text('Hapus Produk'),
                                content: Text('Yakin hapus produk ini?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _hapusProduk(int.parse(produk['id']));
                                    },
                                    child: Text('Hapus'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => FormProduk(onSave: _loadProduk)),
          );
        },
        backgroundColor: Colors.blue[700],
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
