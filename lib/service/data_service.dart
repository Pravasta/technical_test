import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:technical_test/features/login_register/model/user.dart';

class DataService {
  final CollectionReference dataReference =
      FirebaseFirestore.instance.collection('users');

  Future<List<UserModel>> fecthData() async {
    try {
      final snapshot = await dataReference.get();

      List<UserModel> dataModel = snapshot.docs
          .map(
            (e) => UserModel.fromJson(e.id, e.data() as Map<String, dynamic>),
          )
          .toList();

      return dataModel;
    } catch (e) {
      rethrow;
    }
  }
}
