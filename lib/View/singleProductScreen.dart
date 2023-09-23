import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/Model/offersmodel.dart';

class SingleProductScreen extends StatelessWidget {
  OffersModel offersModel;
  SingleProductScreen(this.offersModel);

  List<String> imgUrl = [];
  List<String> producttitle = [];
  List<String> productprice = [];

  @override
  Widget build(BuildContext context) {
    getDataFromSharedPrefrences();

    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        title: Text(
          offersModel.productname,
          style:
              const TextStyle(fontFamily: 'vazir', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Image.network(
                  offersModel.imageurl,
                  height: 280,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  offersModel.productname,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontFamily: 'vazir',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  offersModel.offprice.toString(),
                  style: const TextStyle(
                      fontFamily: 'vazir',
                      fontSize: 30,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: size.width - 40,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () async {
                          addToBasketWithSharedPrefrences(offersModel);
                        },
                        child: const Text(
                          "افزودن به سبد خرید",
                          style: TextStyle(fontFamily: 'vazir'),
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> getDataFromSharedPreferences() async {
  //   try {
  //     // Get an instance of SharedPreferences
  //     SharedPreferences sharedPreferences =
  //         await SharedPreferences.getInstance();

  //     // Get data from SharedPreferences or use empty lists as default values
  //     imgUrl = sharedPreferences.getStringList("imgUrl") ?? [];
  //     producttitle = sharedPreferences.getStringList("producttitle") ?? [];
  //     productprice = sharedPreferences.getStringList("productprice") ?? [];

  //     // Print the length of product titles
  //     log("Product Title Count: ${producttitle.length}");
  //   } catch (e) {
  //     // Handle any exceptions that might occur during SharedPreferences operations
  //     print("Error fetching data from SharedPreferences: $e");
  //   }
  // }

  Future<void> getDataFromSharedPrefrences() async {
    ///TODO:Get Instance Of sharedPrefrences
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    ///TODO:Get The Data From SharedPrefrences
    imgUrl = sharedPreferences.getStringList("imgUrl") ?? [];
    producttitle = sharedPreferences.getStringList("producttitle") ?? [];
    productprice = sharedPreferences.getStringList("productprice") ?? [];

    print(producttitle.length);
  }

  Future<void> addToBasketWithSharedPrefrences(OffersModel offersModel) async {
    ///TODO:Create the List Object For Saving Data With List

    ///TODO:Get Instance Of The Shared Preferences
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    ///Add to the List with the offresModel variable that Instance Of the OfferModel Class
    imgUrl.add(offersModel.imageurl.toString());
    producttitle.add(offersModel.productname);
    productprice.add(offersModel.price.toString());

    ///TODO:Add the List Ex:imageURL,Producttile.... To the Instance Of Shared Prefrences
    sharedPreferences.setStringList("imgUrl", imgUrl);
    sharedPreferences.setStringList("producttitle", producttitle);
    sharedPreferences.setStringList("productprice", productprice);
  }
}
