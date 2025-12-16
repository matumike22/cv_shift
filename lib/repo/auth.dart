import 'package:cv_shift/repo/custom_exceptio_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final _auth = FirebaseAuth.instance;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw customAuthException(e);
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw customAuthException(e);
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Stream<User?> authState() => _auth.authStateChanges();

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw 'Couldn\'t log out. Please try again later!';
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw customAuthException(e);
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<void> verifyPasswordResetCode(String code) async {
    try {
      await _auth.verifyPasswordResetCode(code);
    } on FirebaseAuthException catch (e) {
      throw customAuthException(e);
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<void> verifyEmail() async {
    try {
      final user = _auth.currentUser;
      await user!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw customAuthException(e);
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<void> sendEmailChangeLink(String email) async {
    try {
      final user = _auth.currentUser;
      await user!.verifyBeforeUpdateEmail(email);
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }
}
