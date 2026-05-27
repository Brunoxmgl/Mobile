import 'package:cloud_firestore/cloud_firestore.dart';

class DailyActivityService {
  final FirebaseFirestore _firestore;

  DailyActivityService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getAtividadeDiaria() async {
    final hoje = DateTime.now();
    final inicioDoDia = DateTime(hoje.year, hoje.month, hoje.day);
    final fimDoDia = inicioDoDia.add(const Duration(days: 1));

    final snapshot = await _firestore
        .collection('atividades')
        .where(
          'dataDisponivel',
          isGreaterThanOrEqualTo: Timestamp.fromDate(inicioDoDia),
        )
        .where(
          'dataDisponivel',
          isLessThan: Timestamp.fromDate(fimDoDia),
        )
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    final atividade = snapshot.docs.first;

    return {
      'id': atividade.id,
      ...atividade.data(),
    };
  }
}