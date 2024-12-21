 
 

import '../entities/user.dart';

abstract class AuthRepository {
  Future< User?> login(String email, String password);
  Future<void> register(String email, String password);
  Future<void> logout();
   Future<User?> getCurrentUser(); 
    Future<void> deleteAccount(); 
     Future<void> reauthenticate(String email, String password); 
}
