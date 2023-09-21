import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:storeapp/Model/offersmodel.dart';

Future<List<OffersModel>> getdataforoffers() async {
  List<OffersModel> offermodel = [];
  var apilink =
      "https://raw.githubusercontent.com/MahdiMohammadi-dev/storeapp/main/offers.json";

  var response = await Dio().get(apilink);
  var responsedecode = jsonDecode(response.data);
  log(responsedecode.toString());

  for (var items in responsedecode['product']) {
    offermodel.add(OffersModel(
        id: items["id"],
        productname: items["product_name"],
        price: items["price"],
        offprice: items["off_price"],
        offpercent: items["off_precent"],
        imageurl: items["imgUrl"]));
  }
  return offermodel;
}
