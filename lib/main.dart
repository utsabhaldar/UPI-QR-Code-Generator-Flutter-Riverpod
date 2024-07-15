import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:upi_qr_code_generator/provider/providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UPI QR Code Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(),
    );
  }
}

class HomeScreen {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final upiId = watch(upiIdProvider).state;
    final amount = watch(amountProvider).state;
    final name = watch(nameProvider).state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('UPI QR Code Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'UPI ID'),
              onChanged: (value) => context.read(upiIdProvider).state = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              onChanged: (value) => context.read(amountProvider).state = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) => context.read(nameProvider).state = value,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: upiId.isEmpty || amount.isEmpty || name.isEmpty
                  ? null
                  : () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          content: QrImage(
                            data:
                                'upi://pay?pa=$upiId&pn=$name&am=$amount&cu=INR',
                            version: QrVersions.auto,
                            size: 200.0,
                          ),
                        ),
                      );
                    },
              child: const Text('Generate QR Code'),
            ),
          ],
        ),
      ),
    );
  }
}
