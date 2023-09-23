import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:storeapp/Model/eventsmodel.dart';

Future<List<EventsModel>> getDataFromEvents() async {
  List<EventsModel> eventsModelList = [];
  var apilink =
      "https://raw.githubusercontent.com/MahdiMohammadi-dev/storeapp/main/events.json";

  var response = await Dio().get(apilink);
  var decoderesponse = jsonDecode(response.data);

  for (var items in decoderesponse["product"]) {
    eventsModelList.add(EventsModel(imageUrl: items["imgUrl"]));
  }

  return eventsModelList;
}
