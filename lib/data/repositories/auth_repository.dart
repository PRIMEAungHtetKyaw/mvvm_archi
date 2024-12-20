 
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user.dart' as user_model;
import '../../domain/repositories/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final  FirebaseAuth _firebaseAuth;

  FirebaseAuthRepository(this._firebaseAuth);

  @override
  Future<user_model.User?> login(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    return user != null ? user_model.User(email: user.email!) : null;
  }

  @override
  Future<void> register(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<user_model.User?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return user_model.User(email: user.email!);
    }
    return null;
  }
}