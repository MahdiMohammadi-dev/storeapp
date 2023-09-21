import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:storeapp/Model/PageviewModel.dart';

Future<List<PageViewModel>> getDataFromServerForPageView() async {
  List<PageViewModel> model = [];
  var apilink =
      "https://raw.githubusercontent.com/MahdiMohammadi-dev/storeapp/main/banners.json";

  var response = await Dio().get(apilink);
  var modaldata = jsonDecode(response.data);

  for (var item in modaldata['photos']) {
    model.add(PageViewModel(id: item['id'], imageurl: item['imgUrl']));
  }

  return model;
}
