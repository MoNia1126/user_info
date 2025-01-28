import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirebaseModel {
  final String? id;
  final String? name;
  final int? age;
  final String? hobby;

  UserFirebaseModel({
    this.id,
    this.name,
    this.age,
    this.hobby,
  });

  factory UserFirebaseModel.fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    return UserFirebaseModel(
      id: doc.id,
      name: data['name'],
      age: data['age'],
      hobby: data['hobby'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (age != null) "age": age,
      if (hobby != null) "hobby": hobby,
    };
  }
}
