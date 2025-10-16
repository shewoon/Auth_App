import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();


  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return _handleAuthException(e);

    }
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password' :
        return 'Wrong password provided';
      case 'email-already-in-use':
        return 'An Account already exist with email';
      case 'invalid-email':
        return 'The Email address is invalid';
      case 'weak-password':
        return 'The password is too weak';
      case 'Operation -not-allowed':
        return 'Operation not allowed. Please contact Chat-gpt';
      case 'user-disabled':
        return 'This user account has been disabled';
       default:
         return 'An error occured. Please Try Again!.';
    }
  }

}