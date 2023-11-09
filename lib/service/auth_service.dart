import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:technical_test/common/routes/app_routes.dart';
import 'package:technical_test/features/login_register/view/login_page.dart';

import '../features/login_register/model/user.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<User?> get streamUser => auth.authStateChanges();

  Future<void> setUser(UserModel user) async {
    try {
      firestore.collection('users').doc(user.id).set({
        'id': user.id,
        'email': user.email,
        'name': user.name,
        'isVerified': user.isVerified,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      DocumentSnapshot snapshot =
          await firestore.collection('users').doc(id).get();
      return UserModel(
        id: id,
        email: snapshot['email'],
        name: snapshot['name'],
        isVerified: snapshot['isVerified'],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      UserModel user = UserModel(
        id: userCredential.user!.uid,
        email: email,
        name: name,
        isVerified: userCredential.user!.emailVerified,
      );

      await userCredential.user!.sendEmailVerification();

      await setUser(user);

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> signin(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user!.emailVerified == true) {
        firestore.collection('users').doc(userCredential.user!.uid).update({
          'isVerified': true,
        });

        UserModel user = await getUserById(userCredential.user!.uid);
        return user;
      } else {
        throw 'Email belum verifikasi';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided for that user.';
      }
      rethrow;
    } catch (e) {
      throw 'Email belum verifikasi';
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
    AppRoutes.toAndRemove(const LoginPage());
  }

  Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }
}
