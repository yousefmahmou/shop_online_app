import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
//هنعمل 3اونبورد في الشوب اب
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'Icons.arrow_forward_ios',
      title: 'On Board 1 Title',
      body: 'On Board 1 body',
    ),
    BoardingModel(
      image: 'Icon(Icons.arrow_forward_ios)',
      title: 'On Board 2 Title',
      body: 'On Board 2 body',
    ),
    BoardingModel(
      image: 'Icon(Icons.arrow_forward_ios)',
      title: 'On Board 3 Title',
      body: 'On Board 3 body',
    ),
  ];
  bool isLast = false;

  void supmit() {
    Cachehelper.savaData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndfinish(
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
          defaultTextButton(
            function: supmit,
            text: 'Skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
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
                itemBuilder: (context, index) =>
                    buildBoardinItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Row(children: [
              SmoothPageIndicator(
                controller: boardController,
                effect: ExpandingDotsEffect(
                  activeDotColor: defaultColor,
                  dotColor: Colors.grey,
                  dotHeight: 10,
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 5,
                ),
                count: boarding.length,
              ),
            ]),
            Spacer(),
            FloatingActionButton(
              onPressed: () {
                if (isLast) {
                  supmit();
                } else {
                  boardController.nextPage(
                    duration: Duration(
                      milliseconds: 750,
                    ),
                    curve: Curves.fastLinearToSlowEaseIn,
                  );
                }
              },
              child: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardinItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image(
          //  image: AssetImage('assests/images/onboars1.png'),
          //  ),
          Expanded(
              child: Icon(
            Icons.ac_unit,
          )),
          SizedBox(
            height: 5,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      );
}
