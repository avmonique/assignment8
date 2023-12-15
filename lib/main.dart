import 'package:ave_assignment8/screens/product_listing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(ProductManagementApp());
}

class ProductManagementApp extends StatelessWidget {
  ProductManagementApp({super.key});

  final colorScheme = ColorScheme.fromSeed(seedColor: Color(0xff9A4EAE));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 20,
          ),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.primaryContainer,
        ),
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          displayMedium: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: ProductListingScreen(),
    );
  }
}