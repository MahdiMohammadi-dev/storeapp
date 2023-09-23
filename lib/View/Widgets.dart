import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storeapp/Model/PageviewModel.dart';
import 'package:storeapp/Model/offersmodel.dart';
import 'package:storeapp/View/singleProductScreen.dart';

///TODO:Special Offer Section for ListView
Container specialOfferItemListView(OffersModel offersModel) {
  return Container(
    width: 200,
    height: 300,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 1.5,
      child: Container(
        width: 200,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Image.network(
                offersModel.imageurl,
                height: 150,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                offersModel.productname,
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontFamily: 'vazir'),
              ),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        offersModel.offprice.toString() + " T",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        offersModel.price.toString() + " T",
                        style: const TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10, right: 10),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          offersModel.offpercent.toString() + "%",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    ),
  );
}

///TODO: Page View Section for Images
Padding pageViewItem(PageViewModel pageViewModel) {
  return Padding(
    padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
    child: ClipRRect(
      borderRadius: BorderRadius.all(const Radius.circular(15)),
      child: Image.network(
        pageViewModel.imageurl,
        fit: BoxFit.fill,
      ),
    ),
  );
}

///TODO:Special Offers Page
InkWell generatedItem(OffersModel offersModel) {
  return InkWell(
    onTap: () {
      Get.to(SingleProductScreen(offersModel));
    },
    child: Card(
      elevation: 2,
      child: Center(
        child: Column(
          children: [
            Container(
              width: 90,
              height: 90,
              child: Image.network(offersModel.imageurl),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                offersModel.productname,
                style: const TextStyle(fontFamily: 'vazir'),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  offersModel.price.toString() + " T",
                  style: TextStyle(fontFamily: 'vazir'),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
