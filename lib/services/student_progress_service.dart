
class StudentProgressService {
  String levelUp(int points) {
    if (points <= 100) {
      return 'Junior';
    }

    if (points <= 500) {
      return 'Pleno';
    }

    return 'Sênior';
  }

  Map<String, dynamic> addPoints({
    required int currentPoints,
    required int pointsToAdd,
  }) {
    final updatedPoints = currentPoints + pointsToAdd;
    final updatedLevel = levelUp(updatedPoints);

    return {
      'points': updatedPoints,
      'level': updatedLevel,
    };
  }
}