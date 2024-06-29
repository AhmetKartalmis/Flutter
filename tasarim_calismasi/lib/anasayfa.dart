import 'package:flutter/material.dart';
import 'package:tasarim_calismasi/renkler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYukseklik = ekranBilgisi.size.height;
    final double ekranGenislik = ekranBilgisi.size.width;
    print(ekranGenislik);
    print(ekranYukseklik);
    var d = AppLocalizations.of(context);


    return Scaffold(
      appBar: AppBar(
        title: Text("Pizza",style: TextStyle(color: yaziRenk,fontFamily:"Pacifico",fontSize: ekranGenislik/19 ),),
        backgroundColor: anaRenk,
        centerTitle: true,
      ),
      body:Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:16.0),
              child: Text(d!.pizzaBaslik,style:TextStyle(fontSize:36,color:anaRenk,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.only(top:16.0),
              child: Image.asset("resimler/pizza_resim.png"),
            ),
            Padding(
              padding: const EdgeInsets.only(top:16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Chip(d.peynirYazi),
                  Chip(d.sucukYazi),
                  Chip(d.zeytinYazi),
                  Chip(d.biberYazi),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                 Text(d.teslimatSure,style:TextStyle(fontSize:22,color:yaziRenk2,fontWeight: FontWeight.bold),),
                 Padding(
                   padding: const EdgeInsets.all(16.0),
                   child: Text(d.teslimatBaslik,style:TextStyle(fontSize:22,color:anaRenk,fontWeight: FontWeight.bold),),
                 ),
                 Text(d.teslimatAciklama,style:TextStyle(fontSize:22,color:yaziRenk2,),textAlign:TextAlign.center,),
              ],),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(d.fiyat,style:TextStyle(fontSize:44,color:anaRenk,fontWeight: FontWeight.bold),),
                  const Spacer(),
                  SizedBox(width: 200,height: 50,
                    child: TextButton(onPressed:(){}, child:Text(d.fiyat,style:TextStyle(color:yaziRenk,fontSize: 18) ,),
                        style: TextButton.styleFrom(
                          backgroundColor: anaRenk,
                          shape: const RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(10))),
                        )),
                  ),
                ],
              ),
            )

          ],
        ),

    );
  }
}
class Chip extends StatelessWidget {
  String icerik;

  Chip(this.icerik);

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed:(){}, child:Text(icerik,style:TextStyle(color:yaziRenk) ,),
        style: TextButton.styleFrom(backgroundColor: anaRenk));
  }
}

