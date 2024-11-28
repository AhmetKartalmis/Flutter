import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bootcamp_bitirme/data/entity/SepetYemekler.dart';
import 'package:flutter_bootcamp_bitirme/data/entity/SepetYemeklerCevap.dart';

import '../entity/Yemekler.dart';
import '../entity/YemeklerCevap.dart';

class SepetRepository{
  List<SepetYemekler> parseYemekler(dynamic cevap){
    return SepetYemeklerCevap.fromJson(json.decode(cevap)).sepetYemekler;

  }
  Future<List<SepetYemekler>> sepettekileriYukle() async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi":"ahmet_kartal1686"};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    return parseYemekler(cevap.data.toString());
  }
  Future<void> yemekSil (int yemek_id) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {"sepet_yemek_id":yemek_id,"kullanici_adi":"ahmet_kartal1686"};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    await sepettekileriYukle();
  }
}