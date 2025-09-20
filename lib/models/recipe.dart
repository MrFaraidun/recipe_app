class Recipe {
  final String title;
  final String author;
  final String imageUrl;
  final String category;
  final String duration;
  final String? description;
  final List<String>? ingredients;
  final List<String>? steps;
  final int? likes;
  final String? authorImageUrl;

  Recipe({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.category,
    required this.duration,
    this.description,
    this.ingredients,
    this.steps,
    this.likes,
    this.authorImageUrl,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'] as String,
      author: json['author'] as String,
      imageUrl: json['imageUrl'] as String,
      category: json['category'] as String,
      duration: json['duration'] as String,
      description: json['description'] as String?,
      ingredients: json['ingredients']?.cast<String>(),
      steps: json['steps']?.cast<String>(),
      likes: json['likes'] as int?,
      authorImageUrl: json['authorImageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'imageUrl': imageUrl,
      'category': category,
      'duration': duration,
      'description': description,
      'ingredients': ingredients,
      'steps': steps,
      'likes': likes,
      'authorImageUrl': authorImageUrl,
    };
  }
}
