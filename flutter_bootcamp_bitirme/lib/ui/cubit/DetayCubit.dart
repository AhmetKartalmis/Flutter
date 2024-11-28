import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootcamp_bitirme/data/repository/anasayfa_repo.dart';
import 'package:flutter_bootcamp_bitirme/data/repository/sepet_repository.dart';

class DetayCubit extends Cubit<void>{
  DetayCubit():super(0);
   var arepo = AnasayfaRepository();
   var srepo = SepetRepository();


}