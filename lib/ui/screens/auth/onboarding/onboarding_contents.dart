
class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents(
      {required this.title, required this.image, required this.desc});
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Track Your progress and stay fit",
    image: "assets/illustrations/Fitness tracker-amico_red.png",
    desc: "Remember to keep track of your fitness journey accomplishments.",
  ),
  OnboardingContents(
    title: "Join our awesome community!",
    image: "assets/illustrations/Coaches-amico_red.png",
    desc:
        "Connect and share your knowledge with fitness enthusiasts from around the world!.",
  ),
  OnboardingContents(
    title: "Action is the key to all success",
    image: "assets/illustrations/Timeline-amico_red.png",
    desc:
        "Let us help you achieve your fitness goals with our challenges, plans and healthy recipes!.",
  ),
];