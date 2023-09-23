import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:storeapp/Model/PageviewModel.dart';
import 'package:storeapp/Model/eventsmodel.dart';
import 'package:storeapp/Model/offersmodel.dart';
import 'package:storeapp/View/Widgets.dart';
import 'package:storeapp/View/seeAllOffers.dart';
import 'package:storeapp/method/fetchdataforpageview.dart';
import 'package:storeapp/method/getDataFromEvents.dart';
import 'package:storeapp/method/getdataforoffers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<PageViewModel>>? pageviewmodelfuture;
  Future<List<OffersModel>>? offersmodelfuture;
  Future<List<EventsModel>>? eventmodelFuture;
  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageviewmodelfuture = getDataFromServerForPageView();
    offersmodelfuture = getdataforoffers();
    eventmodelFuture = getDataFromEvents();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text(
          "SamaLaunge Shop",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontFamily: 'vazir'),
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
                          physics: const BouncingScrollPhysics(),
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
                                            side: const BorderSide(
                                                color: Colors.white)),
                                        onPressed: () {
                                          Get.to(SeeAllOffers(),
                                              transition: Transition.downToUp,
                                              duration: const Duration(
                                                  milliseconds: 500));
                                        },
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
              ),

              ///TODO:Event Section Under Offer Section
              Container(
                width: double.infinity,
                child: FutureBuilder(
                  future: eventmodelFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<EventsModel>? model = snapshot.data;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(),
                                  height: 150,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      model![0].imageUrl,
                                      fit: BoxFit.fill,
                                      width: 210,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(),
                                  height: 150,
                                  width: 170,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      model![1].imageUrl,
                                      fit: BoxFit.fill,
                                      width: 210,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(),
                                  height: 150,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      model![2].imageUrl,
                                      fit: BoxFit.fill,
                                      width: 210,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(),
                                  height: 150,
                                  width: 170,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      model![3].imageUrl,
                                      fit: BoxFit.fill,
                                      width: 210,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 12, right: 8, left: 8),
                            child: Container(
                              decoration: const BoxDecoration(),
                              height: 150,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  model![4].imageUrl,
                                  fit: BoxFit.fill,
                                  width: 210,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(12),
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.red,
                        )),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
