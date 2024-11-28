import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootcamp_bitirme/data/entity/SepetYemekler.dart';
import 'package:flutter_bootcamp_bitirme/ui/cubit/SepetCubit.dart';
import 'package:flutter_bootcamp_bitirme/ui/views/urun_detay.dart';

class FavorilerSayfa extends StatefulWidget {
  const FavorilerSayfa({super.key});

  @override
  State<FavorilerSayfa> createState() => _FavorilerSayfaState();
}

class _FavorilerSayfaState extends State<FavorilerSayfa> {
  bool aramaVarMi = false;

  @override
  void initState() {
    super.initState();
    context.read<SepetCubit>().yemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 183, 13, 13),
        centerTitle: true,
        title: aramaVarMi
            ? TextField(
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Yemek, Tatlı, İçecek Ara",
            hintStyle: TextStyle(color: Colors.white),
          ),
          autofocus: true,
          onChanged: (arama) {
            // context.read<AnasayfaCubit>().ara(arama);
          },
        )
            : const Text(
          "Sepetim",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                aramaVarMi = !aramaVarMi;
              });
            },
            icon: Icon(
              aramaVarMi ? Icons.clear : Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BlocBuilder<SepetCubit, List<SepetYemekler>>(
                builder: (context, yemekler) {
                  if (yemekler.isEmpty) {
                    return const Center(child: Text("Liste Boş"));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: yemekler.length,
                      itemBuilder: (context, index) {
                        var urun = yemekler[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UrunDetay(yemek: urun),
                              ),
                            );
                          },
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: SizedBox(
                                    width: 150,
                                    height: 150,
                                    child: Image.network(
                                      "http://kasimadalan.pe.hu/yemekler/resimler/" +
                                          urun.yemek_resim_adi,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      urun.yemek_adi,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "${urun.yemek_fiyat} ₺",
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "${urun.yemek_siparis_adet} adet",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        try {
                                          await context
                                              .read<SepetCubit>()
                                              .yemekSil(int.parse(
                                              urun.sepet_yemek_id));
                                          // Silme işleminden sonra yemekleri yeniden yükle
                                          await context
                                              .read<SepetCubit>()
                                              .yemekleriYukle();
                                        } catch (e) {
                                          print("Hata var: $e");
                                        }
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                    Text(
                                      "${int.parse(urun.yemek_fiyat) * int.parse(urun.yemek_siparis_adet)} ₺",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<SepetCubit, List<SepetYemekler>>(
        builder: (context, yemekler) {
          int toplam = yemekler.fold(
            0,
                (previousValue, element) {
              int fiyat = int.tryParse(element.yemek_fiyat) ?? 0;
              int adet = int.tryParse(element.yemek_siparis_adet) ?? 1;
              return previousValue + (fiyat * adet);
            },
          );

          return FloatingActionButton.extended(
            onPressed: () {

            },
            backgroundColor: const Color.fromARGB(255, 183, 13, 13),
            label: Text(
              "Sepet Toplamı: $toplam ₺",
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootcamp_bitirme/data/entity/SepetYemekler.dart';
import 'package:flutter_bootcamp_bitirme/ui/cubit/SepetCubit.dart';
import 'package:flutter_bootcamp_bitirme/ui/views/urun_detay.dart';

class FavorilerSayfa extends StatefulWidget {
  const FavorilerSayfa({super.key});

  @override
  State<FavorilerSayfa> createState() => _FavorilerSayfaState();
}

class _FavorilerSayfaState extends State<FavorilerSayfa> {
  bool aramaVarMi = false;

  @override
  void initState() {
    super.initState();
    context.read<SepetCubit>().yemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 183, 13, 13),
        centerTitle: true,
        title: aramaVarMi
            ? TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(hintText: "Yemek, Tatlı, İçecek Ara",hintStyle:TextStyle(color: Colors.white)),
          autofocus: true,
          onChanged: (arama) {
            // context.read<AnasayfaCubit>().ara(arama);
          },
        )
            : const Text(
          "Sepetim",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          aramaVarMi
              ? IconButton(
            onPressed: () {

              setState(() {
                aramaVarMi = false;
              });
            },
            icon: const Icon(Icons.clear),
          )
              : IconButton(
            onPressed: () {
              setState(() {
                aramaVarMi = true;
              });
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BlocBuilder<SepetCubit, List<SepetYemekler>>(
                builder: (context, yemekler) {
                  if(yemekler.isEmpty){
                    return Center(child: Text("Liste Boş Knk");

                }
                  else
                  {
                  return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: yemekler.length,
                  itemBuilder: (context, index) {
                  var urun = yemekler[index];
                  return GestureDetector(
                  onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) =>
                  UrunDetay(yemek: urun)));
                  },
                  child: Card(
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.network(
                  "http://kasimadalan.pe.hu/yemekler/resimler/" +
                  urun.yemek_resim_adi),
                  ),
                  ),
                  Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                  urun.yemek_adi,
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  Text(
                  urun.yemek_fiyat.toString() + " ₺",
                  style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  Text(
                  urun.yemek_siparis_adet + " adet",
                  style: TextStyle(fontSize: 16),
                  ),
                  ],
                  ),
                  Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  IconButton(
                  onPressed: () async {
                  try {
                  await context.read<SepetCubit>().yemekSil(int.tryParse(urun.sepet_yemek_id)!);
                  // Silme işleminden sonra yemekleri yeniden yükle
                  await context.read<SepetCubit>().yemekleriYukle();
                  } catch (e) {
                  print("Hata var: $e");
                  }
                  },
                  icon: Icon(Icons.delete),
                  ),
                  Text((int.parse(urun.yemek_fiyat) *
                  int.parse(urun.yemek_siparis_adet))
                      .toString() +
                  " ₺"),
                  ],
                  ),
                  ],
                  ),
                  ),
                  );
                  },
                  );
                  }

                  //return Center(child: Text("Sepette Ürün Yoktur"));
                  }
                },
              ),
            ],
          ),
        ),
      ),
      // Floating Action Button benzeri bir toplam fiyat göstergesi
      floatingActionButton: BlocBuilder<SepetCubit, List<SepetYemekler>>(
        builder: (context, yemekler) {
          int toplam = 0;

          if (yemekler.isNotEmpty) {
            // Toplam fiyatı hesapla
            toplam = yemekler.fold(
              0,
                  (previousValue, element) {
                int fiyat = int.tryParse(element.yemek_fiyat) ?? 0;
                int adet = int.tryParse(element.yemek_siparis_adet) ?? 1;
                return previousValue + (fiyat * adet);

              },
            );
          }

          return FloatingActionButton.extended(
            onPressed: () {},
            backgroundColor:  Color.fromARGB(255, 183, 13, 13),
            label: Text(
              "Sepet Toplamı: $toplam ₺",
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),
            icon: Icon(Icons.shopping_cart,color: Colors.white,),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

 */
