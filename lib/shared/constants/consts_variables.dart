import 'package:health_tracker/data/models/onboarding_model.dart';
import 'package:health_tracker/shared/constants/assets_path.dart';

enum Sex { male, female }

List<OnBoardingModel> onboardinglist = const [
  OnBoardingModel(
    img: MyAssets.onboradingone,
    title: 'Manage Your Task',
    description:
        'With This Small App You Can Orgnize All Your Tasks and Duties In A One Single App.',
  ),
  OnBoardingModel(
    img: MyAssets.onboradingtwo,
    title: 'Plan Your Day',
    description: 'Add A Task And The App Will Remind You.',
  ),
  OnBoardingModel(
    img: MyAssets.onboradingthree,
    title: 'Accomplish Your Goals ',
    description: 'Track Your Activities And Accomplish Your Goals.',
  ),
];