import 'package:flutter/material.dart';
import 'package:shop_app_app/modules/shop_app/login_screen/login_screen/login_screen.dart';
import 'package:shop_app_app/modules/shop_app/on_boarding/custom_Button_login.dart';
import 'package:shop_app_app/shared/componants/componants/componants.dart';
import 'package:shop_app_app/shared/network/local/cash_helper.dart';
import 'package:shop_app_app/shared/styles/colors.dart';


import 'package:simple_page_indicator/simple_page_indicator.dart';

class BoardingModel {
  late String image;
  late String title;
  late String body;

  BoardingModel({
// ignore: non_constant_identifier_names
    required this.image,
    required this.title,
    required this.body,
  });
}

// ignore: must_be_immutable
class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardContrller = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/shop2.png',
        title: 'Purchase your items online',
        body: 'let\'s go shopping !'),
    BoardingModel(
        image: 'assets/images/shop1.png',
        title: 'Choose in-store pick-up',
        body: 'let\'s go shopping !'),
    BoardingModel(
        image: 'assets/images/shop3.png',
        title: 'Or,choose home delivery',
        body: 'let\'s go shopping !')
  ];
  bool isLast = false;

  void submit() {
    CashHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, LoginShopScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: Text('SKIP'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardContrller,
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
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SimplePageIndicator(
                  itemCount: boarding.length,
                  controller: boardContrller,
                  maxSize: 10,
                  minSize: 5,
                  indicatorColor: defultColor,
                  space: 14,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardContrller.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              '${model.title}',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: CustomButton(text:
              '${model.body}', radius: 20, width: 300,isUpperCase: true,
              background: Colors.purpleAccent,
function: (){},


            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      );
}
