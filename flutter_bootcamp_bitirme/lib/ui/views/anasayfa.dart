
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootcamp_bitirme/data/entity/SepetYemekler.dart';
import 'package:flutter_bootcamp_bitirme/data/entity/Yemekler.dart';
import 'package:flutter_bootcamp_bitirme/ui/cubit/AnasayfaCubit.dart';
import 'package:flutter_bootcamp_bitirme/ui/views/urun_detay.dart';

import '../../data/entity/Urunler.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaVarMi = false;
  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:  Color.fromARGB(255, 183, 13, 13),
          centerTitle: true,
          title:aramaVarMi ? TextField(
          decoration: InputDecoration(hintText: "Ürün, Marka, Mağaza Ara"),
          onChanged: (arama){
           // context.read<AnasayfaCubit>().ara(arama);


          },
        ):const Text("Menü",style: TextStyle(color: Colors.white),),
          actions: [
            aramaVarMi?
            IconButton(onPressed: (){
              setState(() {
                aramaVarMi =false;
              });
             // context.read<AnasayfaCubit>().kisileriYukle();


            },icon: const Icon(Icons.clear),):
            IconButton(onPressed: (){
              setState(() {
                aramaVarMi = true;
              });

            },icon: const Icon(Icons.search,color: Colors.white,),)

          ],),

        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<AnasayfaCubit,List<Yemekler>>(
                builder: (context, yemeklerListesi) {
                  if (yemeklerListesi.isNotEmpty) {
                    return GridView.builder(
                      shrinkWrap: true,
                      // Listeyi sığdırır
                      physics: NeverScrollableScrollPhysics(),
                      // Ana kaydırma ile çakışmasını önler
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        // Her satırda 2 ürün göster
                        crossAxisSpacing: 5.0,
                        // Ürünler arasındaki yatay boşluk
                        mainAxisSpacing: 5.0,
                        // Ürünler arasındaki dikey boşluk
                        childAspectRatio: 3 / 5, // Ürün kartlarının boyut oranı
                      ),
                      itemCount: yemeklerListesi.length,
                      itemBuilder: (context, index) {
                        var yemek = yemeklerListesi[index];
                        return GestureDetector(

                          onTap:(){
                            var newYemek = SepetYemekler(sepet_yemek_id: yemek.yemek_id, yemek_adi: yemek.yemek_adi, yemek_resim_adi: yemek.yemek_resim_adi, yemek_fiyat: yemek.yemek_fiyat, yemek_siparis_adet: "1", kullanici_adi: "ahmet_kartal1686");
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>UrunDetay(yemek: newYemek)));

                          },
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 175,
                                    child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/" + yemek.yemek_resim_adi,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  yemek.yemek_adi,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                    Icon(Icons.directions_bike_outlined),
                                    Text("Ücretsiz Teslimat"),
                                  ],),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      yemek.yemek_fiyat.toString() + " ₺",
                                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                                    ),
                                   IconButton(onPressed:(){
                                     context.read<AnasayfaCubit>().arepo.sepeteEkle(yemek.yemek_adi,yemek.yemek_resim_adi,int.parse(yemek.yemek_fiyat),1);

                                   }, icon:Icon(Icons.add_box_sharp)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (yemeklerListesi.isEmpty) {
                    return Center(child: CircularProgressIndicator());

                  } else {
                    return Center(
                        child: Text("Liste Boş"));

                  }
                },
              ),
            ],
          ),
        ));
  }
}
