import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootcamp_bitirme/data/entity/SepetYemekler.dart';
import 'package:flutter_bootcamp_bitirme/data/entity/Yemekler.dart';
import 'package:flutter_bootcamp_bitirme/main.dart';
import 'package:flutter_bootcamp_bitirme/ui/cubit/DetayCubit.dart';
import 'package:flutter_bootcamp_bitirme/ui/views/sepet.dart';

import '../../data/entity/Urunler.dart';

class UrunDetay extends StatefulWidget {
  SepetYemekler yemek;
  UrunDetay({required this.yemek});


  @override
  State<UrunDetay> createState() => _UrunDetayState();
}

class _UrunDetayState extends State<UrunDetay> {

  late int adet;
  @override
  void initState() {
    super.initState();
    adet = int.parse(widget.yemek.yemek_siparis_adet);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text(widget.yemek.yemek_adi)),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
         Image.network("http://kasimadalan.pe.hu/yemekler/resimler/"+widget.yemek.yemek_resim_adi),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             IconButton(onPressed: (){
               if (adet>1) {
                setState(() {
                  --adet;
                });
               }
             }, icon: Icon(Icons.indeterminate_check_box_sharp,size: 48,)),
             Text(adet.toString(),style: TextStyle(fontSize: 32),),
             IconButton(onPressed: (){
               setState(() {
                 ++adet;
               });
             }, icon: Icon(Icons.add_box_sharp,size: 48)),
           ],
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
           Text(widget.yemek.yemek_fiyat.toString()+" ₺",style: TextStyle(fontSize: 32),),
           ElevatedButton(onPressed: (){
             setState(() {
               context.read<DetayCubit>().srepo.yemekSil(int.parse(widget.yemek.sepet_yemek_id));
               context.read<DetayCubit>().arepo.sepeteEkle(widget.yemek.yemek_adi, widget.yemek.yemek_resim_adi, int.parse(widget.yemek.yemek_fiyat), adet);
               Navigator.pop(context);
             });


            }, child: Text("Sepete Ekle",style: TextStyle(color: Colors.black87),))


         ],)

        ],


      ),),
    );
  }
}
