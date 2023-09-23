import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:storeapp/Model/offersmodel.dart';
import 'package:storeapp/View/BottomNav.dart';
import 'package:storeapp/View/GoogleMaps.dart';
import 'package:storeapp/View/Widgets.dart';
import 'package:storeapp/method/getdataforoffers.dart';

class SeeAllOffers extends StatefulWidget {
  const SeeAllOffers({super.key});

  @override
  State<SeeAllOffers> createState() => _SeeAllOffersState();
}

class _SeeAllOffersState extends State<SeeAllOffers> {
  Future<List<OffersModel>>? offermodelfutuere;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    offermodelfutuere = getdataforoffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNav(),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          "تخفیفات ویژه",
          style: TextStyle(fontFamily: 'vazir', fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(const GoogleMaps(), transition: Transition.fadeIn);
              },
              icon: const Icon(Icons.map))
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: offermodelfutuere,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<OffersModel>? model = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: List.generate(
                      model!.length, (index) => generatedItem(model[index])),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
