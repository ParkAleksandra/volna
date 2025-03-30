import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = '';
  String _phone = '';
  String _address = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? 'Не указано';
      _phone = prefs.getString('phone') ?? 'Не указано';
      _address = prefs.getString('address') ?? 'Не указано';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Личный кабинет'),
        backgroundColor: Color(0xFF00A1D6),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Имя: $_name', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Телефон: $_phone', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Адрес: $_address', style: TextStyle(fontSize: 18)),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Функция редактирования пока не доступна')),
                );
              },
              child: Text('Редактировать'),
            ),
          ],
        ),
      ),
    );
  }
}