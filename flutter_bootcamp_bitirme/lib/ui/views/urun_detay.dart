import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootcamp_bitirme/data/entity/SepetYemekler.dart';
import 'package:flutter_bootcamp_bitirme/ui/cubit/DetayCubit.dart';


class UrunDetay extends StatefulWidget {
  final SepetYemekler yemek;
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
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 183, 13, 13),
          centerTitle: true,
          title:Text(widget.yemek.yemek_adi,style: TextStyle(color:Colors.white),)
      ),
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
             }, icon: Icon(Icons.indeterminate_check_box_sharp,size: 48,color: Colors.red,)),
             Text(adet.toString(),style: TextStyle(fontSize: 32),),
             IconButton(onPressed: (){
               setState(() {
                 ++adet;
               });
             }, icon: Icon(Icons.add_box_sharp,size: 48,color: Colors.red,),),
           ],
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
           Text(widget.yemek.yemek_fiyat.toString()+" ₺",style: TextStyle(fontSize: 32),),
             ElevatedButton(
               style: ButtonStyle(
                 backgroundColor: WidgetStateProperty.all(Colors.red), // Kırmızı renk
                 foregroundColor: WidgetStateProperty.all(Colors.white), // Yazı rengi
               ),
               onPressed: () {
                 setState(() {
                   context.read<DetayCubit>().srepo.yemekSil(int.parse(widget.yemek.sepet_yemek_id));
                   context.read<DetayCubit>().arepo.sepeteEkle(widget.yemek.yemek_adi, widget.yemek.yemek_resim_adi, int.parse(widget.yemek.yemek_fiyat), adet);
                   Navigator.pop(context);
                 });
               },
               child: Text("Sepete Ekle"),
             ),


         ],)

        ],


      ),),
    );
  }
}
