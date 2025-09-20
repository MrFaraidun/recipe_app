class User {
  final String id;
  final String name;
  final String imagePath;
  final int recipes;
  final int following;
  final int followers;
  final List<String>? myRecipes;
  final List<String>? likedRecipes;

  const User({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.recipes,
    required this.following,
    required this.followers,
    this.myRecipes,
    this.likedRecipes,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      imagePath: json['imagePath'] as String,
      recipes: json['recipes'] as int,
      following: json['following'] as int,
      followers: json['followers'] as int,
      myRecipes: json['myRecipes']?.cast<String>(),
      likedRecipes: json['likedRecipes']?.cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
      'recipes': recipes,
      'following': following,
      'followers': followers,
      'myRecipes': myRecipes,
      'likedRecipes': likedRecipes,
    };
  }
}
