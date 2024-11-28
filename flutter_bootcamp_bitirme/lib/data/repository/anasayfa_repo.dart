import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bootcamp_bitirme/data/entity/Yemekler.dart';

import '../entity/YemeklerCevap.dart';

class AnasayfaRepository{
  List<Yemekler> parseYemekler(dynamic cevap){
    return YemeklerCevap.fromJson(json.decode(cevap)).yemekler;
  }
  Future<List<Yemekler>> yemekleriYukle() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parseYemekler(cevap.data.toString());
  }
  Future<void> sepeteEkle(String yemek_adi,String resim_adi,int yemek_fiyat,int yemek_adet) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {
        "yemek_adi": yemek_adi,
        "yemek_resim_adi": resim_adi,
        "yemek_fiyat": yemek_fiyat,
        "yemek_siparis_adet":yemek_adet,
        "kullanici_adi": "ahmet_kartal1686"
    };
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    print("print ${cevap.data.toString()}");




  }




}