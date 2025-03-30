import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/catalog_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(VolnaApp());
}

class VolnaApp extends StatelessWidget {
  Future<Widget> _checkRegistration() async {
    final prefs = await SharedPreferences.getInstance();
    final isRegistered = prefs.getBool('isRegistered') ?? false;
    return isRegistered ? HomeScreen() : RegistrationScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Волна',
      theme: ThemeData(
        primaryColor: Color(0xFF00A1D6),
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.roboto(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF000000),
          ),
          bodyMedium: GoogleFonts.roboto(
            fontSize: 16,
            color: Color(0xFF000000),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF00A1D6),
            foregroundColor: Color(0xFFFFFFFF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
      ),
      home: FutureBuilder<Widget>(
        future: _checkRegistration(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          return snapshot.data ?? HomeScreen();
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00A1D6),
        elevation: 0,
        title: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Увеличены отступы
            decoration: BoxDecoration(
              color: Color(0xFF00A1D6),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3), // Увеличена интенсивность тени
                  spreadRadius: 2, // Расширена тень
                  blurRadius: 6, // Более мягкая тень
                  offset: Offset(0, 3), // Смещение вниз
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/logo.svg',
                  height: 50,
                ),
                SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/title.svg',
                  height: 30,
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          SizedBox(width: 8), // Отступ справа для симметрии
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Доставка продуктов от 15 минут',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 16),
            Text(
              'Заказывай всё, что нужно, прямо сейчас!',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CatalogScreen()),
                );
              },
              child: Text('Начать заказ'),
            ),
          ],
        ),
      ),
    );
  }
}