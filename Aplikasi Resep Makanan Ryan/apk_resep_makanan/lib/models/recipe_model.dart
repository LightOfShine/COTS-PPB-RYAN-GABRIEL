class Recipe {
  final int? id;
  final String title;
  final String category;
  final String ingredients;
  final String steps;
  final String note;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Recipe({
    this.id,
    required this.title,
    required this.category,
    required this.ingredients,
    required this.steps,
    required this.note,
    this.createdAt,
    this.updatedAt,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      ingredients: json['ingredients'],
      steps: json['steps'],
      note: json['note'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'ingredients': ingredients,
      'steps': steps,
      'note': note,
    };
  }

  Recipe copyWith({
    int? id,
    String? title,
    String? category,
    String? ingredients,
    String? steps,
    String? note,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      note: note ?? this.note,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}