import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bootcamp_bitirme/data/entity/SepetYemekler.dart';
import 'package:flutter_bootcamp_bitirme/data/entity/SepetYemeklerCevap.dart';
class SepetRepository {
  List<SepetYemekler> parseYemekler(dynamic cevap) {
    return SepetYemeklerCevap
        .fromJson(json.decode(cevap))
        .sepetYemekler;
  }

  Future<List<SepetYemekler>> sepettekileriYukle() async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi": "ahmet_kartal1686"};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    if (cevap.data.toString() == "") {
      return []; // Boş bir liste döndür
    }else{
      try{
        return parseYemekler(cevap.data.toString());
      }
      catch(e){
        return [];
      }
    }
  }
  Future<List<SepetYemekler>> sepettekilerdeAra(String arama) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi": "ahmet_kartal1686"};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    if (cevap.data.toString() == "") {
      return []; // Boş bir liste döndür
    } else {
      try {
        var tumYemekler = parseYemekler(cevap.data.toString());
        // Arama kriterine göre filtreleme yap
        return tumYemekler.where((yemek) {
          return yemek.yemek_adi.toLowerCase().contains(arama.toLowerCase());
        }).toList();
      } catch (e) {
        return [];
      }
    }
  }

  Future<void> yemekSil(int yemek_id) async {
    print("Silinen yemek no:" + yemek_id.toString());
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {
      "sepet_yemek_id": yemek_id,
      "kullanici_adi": "ahmet_kartal1686"
    };
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("Yemek Sil : ${cevap.data.toString()}");
  }
}
