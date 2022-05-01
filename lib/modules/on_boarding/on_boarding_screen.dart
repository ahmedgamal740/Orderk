import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../shop_login/shop_login_screen.dart';
class BoardingModel{
  late final String image;
  late final String title;
  late final String body;
  BoardingModel(
      this.image,
      this.title,
      this.body,
      );

}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;
  List<BoardingModel> board = [
    BoardingModel(
        'assets/images/onboard_1.jpg',
        'On Boarding Title 1',
        'On Boarding Body 1',
    ),
    BoardingModel(
      'assets/images/onboard_1.jpg',
      'On Boarding Title 2',
      'On Boarding Body 2',
    ),
    BoardingModel(
      'assets/images/onboard_1.jpg',
      'On Boarding Title 3',
      'On Boarding Body 3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function: submit,
              text: 'skip'
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => buildBoardItem(board[index]),
                itemCount: board.length,
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index){
                  if(index == board.length -1){
                    setState(() {
                      isLast = true;
                    });
                  }else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: defaultColor,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                      expansionFactor: 4,
                    ),
                    count: board.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      submit();
                    }else{
                      boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void submit(){
    CacheHelper.saveData(
        key: 'onBoarding',
        value: true
    ).then((value) {
      if(value){
        navigateAndFinish(
            context,
            ShopLoginScreen()
        );
      }
    });
  }
  Widget buildBoardItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(image: AssetImage(model.image),
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Text(
        model.title,
        style: const TextStyle(
          fontSize: 24,
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Text(
        model.body,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      const SizedBox(
        height: 30,
      ),
    ],
  );
}
