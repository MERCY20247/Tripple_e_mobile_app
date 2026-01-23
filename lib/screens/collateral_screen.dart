import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CollateralScreen extends StatefulWidget {
  const CollateralScreen({super.key});

  @override
  State<CollateralScreen> createState() => _CollateralScreenState();
}

class _CollateralScreenState extends State<CollateralScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _assetName = TextEditingController();
  final TextEditingController _value = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collateral Info', style: GoogleFonts.poppins(color: const Color(0xFFFFD700))),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Provide details of the asset you are using as security for this loan.",
                style: GoogleFonts.poppins(color: Colors.grey[600]),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _assetName,
                decoration: const InputDecoration(labelText: 'Asset Name (e.g. Car, Land)', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _value,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Estimated Value (UGX)', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 30),
              // Image Placeholder
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, size: 50, color: Colors.grey),
                    Text("Upload Asset Photo")
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700),
                  minimumSize: const Size(double.infinity, 55),
                ),
                child: Text('COMPLETE APPLICATION', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}