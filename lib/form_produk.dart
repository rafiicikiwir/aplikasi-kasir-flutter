import 'package:flutter/material.dart';
import 'api_service.dart';

class FormProduk extends StatefulWidget {
  final Map<String, dynamic>? produk;
  final Function onSave;

  const FormProduk({super.key, this.produk, required this.onSave});

  @override
  _FormProdukState createState() => _FormProdukState();
}

class _FormProdukState extends State<FormProduk> {
  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final _stokController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.produk != null) {
      _namaController.text = widget.produk!['nama_produk'];
      _hargaController.text = widget.produk!['harga'].toString();
      _stokController.text = widget.produk!['stok'].toString();
    }
  }

  void _simpan() async {
    if (_namaController.text.isEmpty ||
        _hargaController.text.isEmpty ||
        _stokController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Semua field harus diisi!')));
      return;
    }

    setState(() => _isLoading = true);

    Map<String, dynamic> result;
    if (widget.produk == null) {
      result = await ApiService.tambahProduk(
        _namaController.text,
        int.parse(_hargaController.text),
        int.parse(_stokController.text),
      );
    } else {
      result = await ApiService.editProduk(
        int.parse(widget.produk!['id']),
        _namaController.text,
        int.parse(_hargaController.text),
        int.parse(_stokController.text),
      );
    }

    setState(() => _isLoading = false);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(result['message'])));

    if (result['success']) {
      widget.onSave();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.produk == null ? 'Tambah Produk' : 'Edit Produk'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _namaController,
              decoration: InputDecoration(
                labelText: 'Nama Produk',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _hargaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Harga',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _stokController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Stok',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _simpan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                ),
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'SIMPAN',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
