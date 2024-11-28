import 'package:flutter/material.dart';

class SaticiSayfa extends StatefulWidget {
  const SaticiSayfa({super.key});

  @override
  State<SaticiSayfa> createState() => _SaticiSayfaState();
}

class _SaticiSayfaState extends State<SaticiSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 109, 75),
        centerTitle: true,
        title: Text("Hesabım"),
      ),
      body: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white, // Buton yazı rengi
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () {
                  // Google giriş işlemi tetiklenir
                   },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 24),
                    Text(
                      "Ürünlerim",
                      style: TextStyle(fontSize: 28),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
            ],
          )
      ),
    );
  }
}
