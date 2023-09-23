import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/Model/ShopBasketModel.dart';

class ShopBasket extends StatefulWidget {
  const ShopBasket({super.key});

  @override
  State<ShopBasket> createState() => _ShopBasketState();
}

class _ShopBasketState extends State<ShopBasket> {
  StreamController<ShopBasketModel> shopbasketControllerstram =
      StreamController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdatafromPrefrences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: const Text(
          "سبد خرید",
          style: TextStyle(fontFamily: 'vazir', fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: StreamBuilder<ShopBasketModel>(
          stream: shopbasketControllerstram.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ShopBasketModel? model = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: model!.imageurl.length,
                itemBuilder: (context, index) {
                  return generateItems(
                      model.imageurl[index],
                      model.producttitle[index],
                      model.productprice[index].toString());
                },
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

  Card generateItems(
      String imageurl, String producttitle, String productprice) {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Text(
                        producttitle,
                        style: const TextStyle(
                            fontFamily: 'vazir', fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          productprice,
                          style: const TextStyle(
                              fontFamily: 'vazir', fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.network(
                  imageurl,
                  fit: BoxFit.contain,
                  width: 150,
                  height: 150,
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> getdatafromPrefrences() async {
    List<String> imageUrl = [];
    List<String> ProductTitle = [];
    List<String> ProductPrice = [];

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    imageUrl = sharedPreferences.getStringList("imgUrl") ?? [];
    ProductTitle = sharedPreferences.getStringList("producttitle") ?? [];
    ProductPrice = sharedPreferences.getStringList("productprice") ?? [];

    var model = ShopBasketModel(
        imageurl: imageUrl,
        producttitle: ProductTitle,
        productprice: ProductPrice);

    shopbasketControllerstram.add(model);
  }
}
