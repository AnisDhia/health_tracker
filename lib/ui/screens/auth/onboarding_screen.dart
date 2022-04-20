import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker/shared/styles/themes.dart';
import 'package:health_tracker/ui/screens/auth/welcome_screen.dart';
import 'package:health_tracker/ui/widgets/custom_dots.dart';
import 'package:health_tracker/ui/widgets/mycustompainter.dart';
import 'package:health_tracker/ui/widgets/onboarding_item.dart';
import 'package:sizer/sizer.dart';
import 'package:health_tracker/bloc/onboarding/onboarding_cubit.dart';
import 'package:health_tracker/shared/constants/consts_variables.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnBoardingScreen> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemes.primary,
      body: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {},
        builder: (context, state) {
          OnboardingCubit cubit = BlocProvider.of(context);
          return SafeArea(
              child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                      width: 100.w,
                      height: 95.h,
                      color: MyThemes.primary,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _pageController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeIn);

                                    cubit.curruntindext > 0
                                        ? cubit.removefromindex()
                                        : null;
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text(
                                      'Back',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          ?.copyWith(
                                            fontSize: 13.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ),
                                CustomDots(myindex: cubit.curruntindext),
                                SizedBox(
                                  width: 10.w,
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    width: 100.w,
                    height: 90.h,
                    child: CustomPaint(
                      painter: const MycustomPainter(color: Colors.white),
                      child: SizedBox(
                        width: 80.w,
                        height: 50.h,
                        child: PageView.builder(
                          itemCount: onboardinglist.length,
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          itemBuilder: ((context, index) {
                            return OnBoardingItem(
                              index: index,
                              image: onboardinglist[index].img,
                              title: onboardinglist[index].title,
                              description: onboardinglist[index].description,
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                  cubit.curruntindext != onboardinglist.length - 1
                      ? Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: MyButton(
                                color: MyThemes.primary,
                                width: 19.w,
                                title: 'Skip',
                                
                                func: () {
                                  _pageController.animateToPage(
                                      onboardinglist.length - 1,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeOut);
                                  cubit.curruntindext <
                                          onboardinglist.length - 1
                                      ? cubit.skipindex()
                                      : null;
                                }),
                          ))
                      : Container(),
                  Positioned(
                    bottom: 10.h,
                    child: CircularButton(
                        color: Colors.pink.withOpacity(0.6),
                        width: 30.w,
                        icon: Icons.arrow_right_alt_sharp,
                        condition:
                            cubit.curruntindext != onboardinglist.length - 1,
                        func: () {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                          if (cubit.curruntindext < onboardinglist.length - 1) {
                            cubit.changeindex();
                          } else {
                            Navigator.pushReplacement(context,  MaterialPageRoute(
                                    builder: (context) => const WelcomeScreen()));
                            cubit.savepref('seen');
                          }
                        }),
                  ),
                ],
              ),
            ],
          ));
        },
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton(
      {Key? key,
      required this.color,
      required this.width,
      required this.title,
      required this.func})
      : super(key: key);

  final Color color;
  final double width;
  final String title;
  final Function() func;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: 0.1.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        color: color,
      ),
      child: MaterialButton(
        onPressed: func,
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline1
              ?.copyWith(fontSize: 11.sp, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  const CircularButton(
      {Key? key,
      required this.color,
      required this.width,
      required this.icon,
      required this.func,
      required this.condition})
      : super(key: key);

  final Color color;
  final double width;
  final IconData icon;
  final Function() func;
  final bool condition;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: MaterialButton(
          onPressed: func,
          child: Center(
            child: (condition)
                ? Icon(
                    icon,
                    color: Colors.white,
                    size: 30.sp,
                  )
                : Text(
                    'Begin',
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        ?.copyWith(fontSize: 9.sp, color: Colors.white),
                  ),
          ),
        ),
      ),
    );
  }
}

/*MaterialButton(
                      minWidth: 10.w,
                      height: 10.w,
                      padding: EdgeInsets.all(14.sp),
                      onPressed: () {},
                      shape: const CircleBorder(),
                      color: Colors.deepPurple,
                      elevation: 20,
                      child: Icon(
                        Icons.calendar_today,
                        color: Appcolors.white,
                        size: 25.sp,
                      ),
                    )*/
