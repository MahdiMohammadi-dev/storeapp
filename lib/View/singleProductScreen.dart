import 'package:flutter/material.dart';
import 'package:storeapp/Model/offersmodel.dart';

class SingleProductScreen extends StatelessWidget {
  OffersModel offersModel;
  SingleProductScreen(this.offersModel);

  @override
  Widget build(BuildContext context) {
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
                        onPressed: () {},
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
}
