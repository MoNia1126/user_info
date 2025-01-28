import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_user_info/models/user_firebase_model.dart';

class UserFirebaseServices {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser(UserFirebaseModel user) async {
    try {
      await _userCollection.add(user.toFirestore());
    } catch (e) {
      throw Exception('Error adding user: $e');
    }
  }

  Stream<List<UserFirebaseModel>> getUsers() {
    return _userCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserFirebaseModel.fromFirestore(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>);
      }).toList();
    });
  }

  Future<void> deleteUser(String id) async {
    try {
      await _userCollection.doc(id).delete();
    } catch (e) {
      throw Exception('Error deleting user: $e');
    }
  }
}
