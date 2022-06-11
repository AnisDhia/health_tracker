class Exercise {
  late final String name;
  late final String force;
  late final String level;
  late final String mechanic;
  late final String equipment;
  late final List<String> primaryMuscles;
  late final List<String> secondaryMuscles;
  late final List<String> instructions;
  late final List<dynamic> imgs;
  late final String category;

  Exercise(
      {required this.name,
      required this.force,
      required this.level,
      required this.mechanic,
      required this.equipment,
      required this.primaryMuscles,
      required this.secondaryMuscles,
      required this.instructions,
      required this.imgs,
      required this.category});

  Exercise.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    force = json['force'];
    level = json['level'];
    mechanic = json['mechanic']??'';
    equipment = json['equipment'] ?? 'body only';
    primaryMuscles = json['primaryMuscles'].cast<String>();
    secondaryMuscles = json['secondaryMuscles'].cast<String>();
    instructions = json['instructions'].cast<String>();
    imgs = json['img'] ?? [];
    category = json['category'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = name;
  //   data['force'] = force;
  //   data['level'] = level;
  //   data['mechanic'] = mechanic;
  //   data['equipment'] = equipment;
  //   data['primaryMuscles'] = primaryMuscles;
  //   data['secondaryMuscles'] = secondaryMuscles;
  //   data['instructions'] = instructions;
  //    data['img'] = imgUrl.map((v) => v.toJson()).toList();
  //   data['category'] = category;
  //   return data;
  // }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['force'] = force;
    data['level'] = level;
    data['mechanic'] = mechanic;
    data['equipment'] = equipment;
    data['primaryMuscles'] = primaryMuscles;
    data['secondaryMuscles'] = secondaryMuscles;
    data['instructions'] = instructions;
    data['img'] = imgs;
    data['category'] = category;
    return data;
  }
}
