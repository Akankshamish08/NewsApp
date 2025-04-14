import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('No Internet')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.redAccent,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  'No Internet Connection',
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),

          const Center(child: Text('Please check your internet connection.')),
        ],
      ),
    );
  }
}
