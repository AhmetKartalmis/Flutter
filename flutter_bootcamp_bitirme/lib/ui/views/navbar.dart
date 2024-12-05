import 'package:flutter/material.dart';
import 'anasayfa.dart';
import 'sepet.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}
class _NavbarState extends State<Navbar> {
  int selectedIndex = 0;
  var pages = [const Anasayfa(),const FavorilerSayfa()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Menü"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Sepetim"),
      ],
        currentIndex: selectedIndex,
        backgroundColor:  Color.fromARGB(255, 183, 13, 13),
        selectedItemColor: Colors.lightGreen,
        unselectedItemColor: Colors.white,
        onTap:(indeks){
          setState(() {
            selectedIndex=indeks;
          });
        },
      ),
    );
  }
}
