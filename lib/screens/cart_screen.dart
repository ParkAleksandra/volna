import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  CartScreen({required this.cartItems});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double calculateTotal() {
    return widget.cartItems.fold(0.0, (sum, item) {
      String priceStr = item['price'].replaceAll(' ₽', '');
      return sum + double.parse(priceStr);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Корзина'),
        backgroundColor: Color(0xFF00A1D6),
        elevation: 0,
      ),
      body: widget.cartItems.isEmpty
          ? Center(child: Text('Корзина пуста'))
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 8), // Исправлено на "bottom"
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      child: Image.asset(item['image'], fit: BoxFit.cover),
                    ),
                    title: Text(item['name']),
                    subtitle: Text(item['price']),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          widget.cartItems.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: widget.cartItems.isNotEmpty
          ? Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Итого: ${calculateTotal()} ₽',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Заказ оформлен!')),
                      );
                      setState(() {
                        widget.cartItems.clear();
                      });
                    },
                    child: Text('Оформить заказ'),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}