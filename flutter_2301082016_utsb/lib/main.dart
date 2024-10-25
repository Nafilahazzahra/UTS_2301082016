import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi Fare Calculator',
      home: TaxiCalculator(),
    );
  }
}

class TaxiCalculator extends StatefulWidget {
  @override
  _TaxiCalculatorState createState() => _TaxiCalculatorState();
}

class _TaxiCalculatorState extends State<TaxiCalculator> {
  final TextEditingController kodeTransaksiController = TextEditingController();
  final TextEditingController kodePenumpangController = TextEditingController();
  final TextEditingController namaPenumpangController = TextEditingController();
  final TextEditingController jenisPenumpangController = TextEditingController();
  final TextEditingController platNomorController = TextEditingController();
  final TextEditingController supirController = TextEditingController();
  final TextEditingController biayaAwalController = TextEditingController();
  final TextEditingController biayaPerKilometerController = TextEditingController();
  final TextEditingController jumlahKiloMeterController = TextEditingController();

  String totalBayar = '';

  void hitungTotalBayar() {
    final double biayaAwal = double.tryParse(biayaAwalController.text) ?? 0;
    final double biayaPerKilometer = double.tryParse(biayaPerKilometerController.text) ?? 0;
    final double jumlahKiloMeter = double.tryParse(jumlahKiloMeterController.text) ?? 0;

    double diskon = 0;
    if(jenisPenumpangController.text == "VIP"){
      diskon = 5;
    }else if(jenisPenumpangController.text == "GOLD"){
      diskon = 2;
    }

    double totalBayarValue = biayaAwal + (biayaPerKilometer * (jumlahKiloMeter - diskon).clamp(0, double.infinity));
    setState(() {
      totalBayar = 'Total Bayar: Rp${totalBayarValue.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Taxi Fare Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input Section
            Text('Input Data', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            _buildTextField(kodeTransaksiController, 'Kode Transaksi'),
            _buildTextField(kodePenumpangController, 'Kode Penumpang'),
            _buildTextField(namaPenumpangController, 'Nama Penumpang'),
            _buildTextField(jenisPenumpangController, 'Jenis Penumpang (VIP/GOLD)'),
            _buildTextField(platNomorController, 'Plat Nomor'),
            _buildTextField(supirController, 'Supir'),
            _buildTextField(biayaAwalController, 'Biaya Awal'),
            _buildTextField(biayaPerKilometerController, 'Biaya Per Kilometer'),
            _buildTextField(jumlahKiloMeterController, 'Jumlah Kilometer'),
            SizedBox(height: 20),
            ElevatedButton(onPressed: hitungTotalBayar, child: Text('Hitung Total Bayar')),
            SizedBox(height: 40),
            // Output Section
            Text('Output Data', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(totalBayar, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      keyboardType:  TextInputType.numberWithOptions(decimal: true),
    );
  }
}
