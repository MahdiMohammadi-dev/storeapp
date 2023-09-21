import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:storeapp/Model/PageviewModel.dart';
import 'package:storeapp/Model/offersmodel.dart';
import 'package:storeapp/method/fetchdataforpageview.dart';
import 'package:storeapp/method/getdataforoffers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<PageViewModel>>? pageviewmodelfuture;
  Future<List<OffersModel>>? offersmodelfuture;
  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageviewmodelfuture = getDataFromServerForPageView();
    offersmodelfuture = getdataforoffers();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text(
          "Digikala",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.shopping_cart_outlined))
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              ///TODO: Slider Section
              Container(
                height: 250,
                child: FutureBuilder<List<PageViewModel>>(
                  future: pageviewmodelfuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<PageViewModel>? model = snapshot.data;
                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PageView.builder(
                            controller: pageController,
                            allowImplicitScrolling: true,
                            itemCount: model!.length,
                            itemBuilder: (context, index) {
                              return pageViewItem(model[index]);
                            },
                          ),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: SmoothPageIndicator(
                                controller: pageController,
                                count: model.length,
                                effect: const ExpandingDotsEffect(
                                  dotWidth: 5,
                                  dotHeight: 5,
                                  activeDotColor: Colors.red,
                                  dotColor: Colors.white,
                                  spacing: 4,
                                  radius: 100.0,
                                ),
                              )),
                        ],
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

              ///TODO: Offers Section
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: 300,
                  color: Colors.red,
                  child: FutureBuilder<List<OffersModel>>(
                    future: offersmodelfuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<OffersModel>? model = snapshot.data;
                        return ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: model!.length,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Container(
                                height: 300,
                                width: 200,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 10, right: 10),
                                      child: Image.asset(
                                        'assets/images/offer.png',
                                        height: 230,
                                      ),
                                    ),
                                    OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                                color: Colors.white)),
                                        onPressed: () {},
                                        child: const Text(
                                          "< مشاهده همه",
                                          style: TextStyle(
                                              fontFamily: 'vazir',
                                              color: Colors.white),
                                        ))
                                  ],
                                ),
                              );
                            } else {
                              return specialOfferItemListView(model[index - 1]);
                            }
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

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
                  style: TextStyle(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            offersModel.offpercent.toString() + "%",
                            style: TextStyle(color: Colors.white),
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
      padding: EdgeInsets.only(top: 15, left: 10, right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Image.network(
          pageViewModel.imageurl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
