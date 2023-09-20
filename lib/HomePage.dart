import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:storeapp/Model/PageviewModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<PageViewModel>>? pageviewmodelfuture;
  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageviewmodelfuture = getDataFromServerForPageView();
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
      body: Container(
        child: Column(
          children: [
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
            )
          ],
        ),
      ),
    );
  }

  Future<List<PageViewModel>> getDataFromServerForPageView() async {
    List<PageViewModel> model = [];
    var apilink =
        "https://raw.githubusercontent.com/MahdiMohammadi-dev/storeapp/main/banners.json";

    var response = await Dio().get(apilink);
    var modaldata = jsonDecode(response.data);
    // log(modaldata.toString());

    for (var item in modaldata['photos']) {
      model.add(PageViewModel(id: item['id'], imageurl: item['imgUrl']));
    }

    return model;
  }

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
