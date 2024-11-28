import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootcamp_bitirme/data/entity/SepetYemekler.dart';
import 'package:flutter_bootcamp_bitirme/data/repository/sepet_repository.dart';

class SepetCubit extends Cubit<List<SepetYemekler>>{
  SepetCubit():super(<SepetYemekler>[]);
  var srepo = SepetRepository();
  Future<void> yemekleriYukle() async {
    var liste = await srepo.sepettekileriYukle();
    if(liste.isEmpty) emit([]);
    else emit(liste);
  }
  Future<void> yemekSil (int yemek_id) async {
    await srepo.yemekSil(yemek_id);
    // Silme işleminden sonra yeni yemek listesini yükleyin
    await yemekleriYukle();
    if (state.length == 0) { // Liste boş mu kontrol et
      emit([]); // Liste boş ise boş liste emit et
    }


  }
}