class Flashcard {
  final String front;
  final String back;
  final DateTime createdAt;

  Flashcard({
    required this.front,
    required this.back,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  @override
  String toString() {
    return 'Flashcard(front: $front, back: $back)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Flashcard &&
        other.front == front &&
        other.back == back;
  }

  @override
  int get hashCode => front.hashCode ^ back.hashCode;
}