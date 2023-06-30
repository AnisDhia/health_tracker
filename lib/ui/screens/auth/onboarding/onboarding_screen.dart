// import 'package:flutter/material.dart';
// import 'package:health_tracker/ui/screens/auth/welcome_screen.dart';
// import 'package:health_tracker/ui/widgets/navigation_widget.dart';
// import 'package:introduction_screen/introduction_screen.dart';

// class OnBoardingScreen extends StatefulWidget {
//   const OnBoardingScreen({Key? key}) : super(key: key);

//   @override
//   State<OnBoardingScreen> createState() => _OnBoardingScreenState();
// }

// class _OnBoardingScreenState extends State<OnBoardingScreen> {
//   final introKey = GlobalKey<IntroductionScreenState>();

//   void _onIntroEnd(context) {
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (_) => const Navigation()),
//     );
//   }

//   Widget _buildFullscreenImage() {
//     return Image.asset(
//       'assets/images/cover.jpg',
//       fit: BoxFit.cover,
//       height: double.infinity,
//       width: double.infinity,
//       alignment: Alignment.center,
//     );
//   }

//   Widget _buildImage(String assetName, [double width = 350]) {
//     return Image.asset('assets/images/$assetName', width: width);
//   }

//   @override
//   Widget build(BuildContext context) {
//     const bodyStyle = TextStyle(fontSize: 19.0);

//     final pageDecoration = PageDecoration(
//       titleTextStyle: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
//       bodyTextStyle: bodyStyle,
//       bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
//       pageColor: Theme.of(context).scaffoldBackgroundColor,
//       imagePadding: EdgeInsets.zero,
//     );

//     return IntroductionScreen(
//       key: introKey,
//       globalBackgroundColor: Colors.white,
//       // globalHeader: Align(
//       //   alignment: Alignment.topRight,
//       //   child: SafeArea(
//       //     child: Padding(
//       //       padding: const EdgeInsets.only(top: 16, right: 16),
//       //       child: _buildImage('app_logo.png', 100),
//       //     ),
//       //   ),
//       // ),
//       globalFooter: SizedBox(
//         width: double.infinity,
//         height: 60,
//         child: ElevatedButton(
//           child: const Text(
//             'Let\'s go right away!',
//             style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//           onPressed: () => _onIntroEnd(context),
//         ),
//       ),
//       pages: [
//         PageViewModel(
//           title: "Start a healthy lifestyle",
//           body:
//               "Instead of having to buy an entire share, invest any amount you want.",
//           image: _buildImage('onboardingone.png'),
//           decoration: pageDecoration,
//         ),
//         PageViewModel(
//           title: "Track your progress",
//           body:
//               "Download the Stockpile app and master the market with our mini-lesson.",
//           image: _buildImage('onboardingtwo.png'),
//           decoration: pageDecoration,
//         ),
//         PageViewModel(
//           title: "Connect with others",
//           body:
//               "Kids and teens can track their stocks 24/7 and place trades that you approve.",
//           image: _buildImage('onboardingthree.png'),
//           decoration: pageDecoration,
//         ),
//         PageViewModel(
//           title: "High quality efficient workouts",
//           body:
//               "Pages can be full screen as well.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
//           image: _buildFullscreenImage(),
//           decoration: pageDecoration.copyWith(
//             contentMargin: const EdgeInsets.symmetric(horizontal: 16),
//             fullScreen: true,
//             bodyFlex: 2,
//             imageFlex: 3,
//           ),
//         ),
//         PageViewModel(
//           title: "Tasty and healhty recipes",
//           body: "Another beautiful body text for this example onboarding",
//           image: _buildImage('img2.jpg'),
//           footer: ElevatedButton(
//             onPressed: () {
//               introKey.currentState?.animateScroll(0);
//             },
//             style: ElevatedButton.styleFrom(
//               primary: Colors.lightBlue,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//             ),
//             child: const Text(
//               'FooButton',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           decoration: pageDecoration,
//         ),
//         PageViewModel(
//           title: "Title of last page - reversed",
//           bodyWidget: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               Text("Click on ", style: bodyStyle),
//               Icon(Icons.edit),
//               Text(" to edit a post", style: bodyStyle),
//             ],
//           ),
//           decoration: pageDecoration.copyWith(
//             bodyFlex: 2,
//             imageFlex: 4,
//             bodyAlignment: Alignment.bottomCenter,
//             imageAlignment: Alignment.topCenter,
//           ),
//           image: _buildImage('img1.jpg'),
//           reverse: true,
//         ),
//       ],
//       onDone: () => _onIntroEnd(context),
//       //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
//       showSkipButton: false,
//       skipOrBackFlex: 0,
//       nextFlex: 0,
//       showBackButton: true,
//       //rtl: true, // Display as right-to-left
//       back: const Icon(Icons.arrow_back),
//       skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
//       next: const Icon(Icons.arrow_forward),
//       done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
//       curve: Curves.fastLinearToSlowEaseIn,
//       controlsMargin: const EdgeInsets.all(16),
//       controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
//       dotsDecorator: const DotsDecorator(
//         size: Size(10.0, 10.0),
//         color: Color(0xFFBDBDBD),
//         activeSize: Size(22.0, 10.0),
//         activeShape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(25.0)),
//         ),
//       ),
//       // dotsContainerDecorator: const ShapeDecoration(
//       //   color: Colors.black87,
//       //   shape: RoundedRectangleBorder(
//       //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
//       //   ),
//       // ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:health_tracker/ui/screens/auth/about/about_screen.dart';
import 'package:health_tracker/ui/screens/auth/onboarding/size_config.dart';
import 'package:health_tracker/ui/screens/auth/onboarding/onboarding_contents.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;
  List colors = [const Color.fromARGB(255, 236, 217, 217), const Color.fromARGB(255, 255, 222, 222), const Color.fromARGB(255, 246, 220, 220)];

  AnimatedContainer _buildDots({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: Colors.red,
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;
    double blockH = SizeConfig.blockH!;
    double blockV = SizeConfig.blockV!;

    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: contents.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Image.asset(
                          contents[i].image,
                          height: SizeConfig.blockV! * 35,
                        ),
                        SizedBox(
                          height: (height >= 840) ? 60 : 30,
                        ),
                        Text(
                          contents[i].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w600,
                            fontSize: (width <= 550) ? 30 : 35,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          contents[i].desc,
                          style: TextStyle(
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w300,
                            fontSize: (width <= 550) ? 17 : 25,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      contents.length,
                      (int index) => _buildDots(index: index),
                    ),
                  ),
                  _currentPage + 1 == contents.length
                      ? Padding(
                          padding: const EdgeInsets.all(30),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AboutYouScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: (width <= 550)
                                  ? const EdgeInsets.symmetric(
                                      horizontal: 100, vertical: 20)
                                  : EdgeInsets.symmetric(
                                      horizontal: width * 0.2, vertical: 25),
                              textStyle:
                                  TextStyle(fontSize: (width <= 550) ? 13 : 17),
                            ),
                            child: const Text("START NOW"),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _controller.jumpToPage(2);
                                },
                                style: TextButton.styleFrom(
                                  elevation: 0,
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: (width <= 550) ? 13 : 17,
                                  ),
                                ),
                                child: const Text(
                                  "SKIP",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _controller.nextPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  elevation: 0,
                                  padding: (width <= 550)
                                      ? const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 20)
                                      : const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 25),
                                  textStyle: TextStyle(
                                      fontSize: (width <= 550) ? 13 : 17),
                                ),
                                child: const Text("NEXT"),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}