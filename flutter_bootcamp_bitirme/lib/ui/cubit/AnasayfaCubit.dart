import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootcamp_bitirme/data/entity/Yemekler.dart';
import 'package:flutter_bootcamp_bitirme/data/repository/anasayfa_repo.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>>{
  AnasayfaCubit():super(<Yemekler>[]);
  var arepo = AnasayfaRepository();
  Future<void> yemekleriYukle() async {
     var liste = await arepo.yemekleriYukle();
     emit(liste);
  }
  Future<void> yemeklerdeAra(String arama) async {
    var liste = await arepo.yemeklerdeAra(arama);
    emit(liste);
  }






}