class User {
  final String imagePath, name, email, about; 
  final bool isDarkMode;

  const User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
    required this.isDarkMode,
  });

  User copy({
    String? imagePath, name, email, about,
    bool? isDarkTheme,
  }) =>
    User(
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      email: email ?? this.email,
      about: about ?? this.about,
      isDarkMode: isDarkTheme ?? this.isDarkMode,
    );

  static User fromJson(Map<String, dynamic> json) => User(
    imagePath: json['imagePath'],
    name: json['name'],
    email: json['email'],
    about: json['about'],
    isDarkMode: json['isDarkMode'],
  );
  
  Map<String, dynamic> toJson() => {
    'imagePath': imagePath,
    'name': name,
    'email': email,
    'about': about,
    'isDarkMode': isDarkMode,
  };
}