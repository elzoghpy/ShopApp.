// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore, must_be_immutable, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:shop_app/modules/shop_app/shop_login/shop_loginScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/styles/colors.dart';

class BoardingModel {
  final String image;
  final String titel;
  final String body;
  BoardingModel({required this.image, required this.titel, required this.body});
}

// ignore: use_key_in_widget_constructors
class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardcontroller = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/shoop2.jpg',
        titel: 'On Board1 Titel',
        body: 'On Board1 Body'),
    BoardingModel(
        image: 'assets/images/daughter.png',
        titel: 'On Board2 Titel',
        body: 'On Board2 Body'),
    BoardingModel(
        image: 'assets/images/famely.webp',
        titel: 'On Board3 Titel',
        body: 'On Board3 Body')
  ];
  bool isLast = false;

  void submit() {
    CasheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        NavigateAndFinsh(
          context,
          ShopLoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(function: submit, text: 'SKIP'),
        ],
      ),
      // ignore: prefer_const_literals_to_create_immutables
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          Expanded(
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: boardcontroller,
              onPageChanged: (int index) {
                if (index == boarding.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
              itemBuilder: ((context, index) =>
                  buildBoardingItem(boarding[index])),
              itemCount: boarding.length,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SmoothPageIndicator(
                controller: boardcontroller,
                count: boarding.length,
                effect: ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  dotHeight: 10,
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 5.0,
                  activeDotColor: defaultColor,
                ),
              ),
              Spacer(),
              FloatingActionButton(
                onPressed: () {
                  if (isLast) {
                    submit;
                  } else {
                    boardcontroller.nextPage(
                        duration: Duration(
                          milliseconds: 800,
                        ),
                        curve: Curves.fastOutSlowIn);
                  }
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                ),
              )
            ],
          )
        ]),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: Image(image: AssetImage('${model.image}'))),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.titel}',
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
        ]),
      );
}
