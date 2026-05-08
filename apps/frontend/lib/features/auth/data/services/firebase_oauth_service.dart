import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:subflix/core/app/firebase_options.dart';

/// Handles Google sign-in and converts it into a Firebase ID token.
class FirebaseOAuthService {
  FirebaseOAuthService({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required Future<void> Function() initializeFirebase,
  }) : _firebaseAuth = firebaseAuth,
       _googleSignIn = googleSignIn,
       _initializeFirebase = initializeFirebase;

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final Future<void> Function() _initializeFirebase;
  Future<void>? _googleInitialization;

  Future<String> signInWithGoogleIdToken() async {
    try {
      await _initializeFirebase();
      _googleInitialization ??= _googleSignIn.initialize(
        clientId: DefaultFirebaseOptions.googleClientId,
        serverClientId: DefaultFirebaseOptions.serverClientId,
      );
      await _googleInitialization;
    } on Exception catch (error) {
      throw FirebaseOAuthException(
        'Firebase is not configured for this app yet. Add the documented FIREBASE_* and GOOGLE_* values before using Google sign-in.',
        cause: error,
      );
    }

    late final GoogleSignInAccount googleUser;
    try {
      googleUser = await _googleSignIn.authenticate();
    } on GoogleSignInException catch (error) {
      if (error.code == GoogleSignInExceptionCode.canceled) {
        throw const FirebaseOAuthCancelledException();
      }
      throw FirebaseOAuthException(
        error.description ?? 'Google sign-in failed.',
      );
    }

    final googleAuth = googleUser.authentication;
    final googleIdToken = googleAuth.idToken;
    if (googleIdToken == null || googleIdToken.trim().isEmpty) {
      throw const FirebaseOAuthException(
        'Google sign-in did not return an ID token.',
      );
    }

    final credential = GoogleAuthProvider.credential(idToken: googleIdToken);

    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    final firebaseIdToken = await userCredential.user?.getIdToken();

    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();

    if (firebaseIdToken == null || firebaseIdToken.trim().isEmpty) {
      throw const FirebaseOAuthException(
        'Firebase sign-in completed, but no Firebase ID token was returned.',
      );
    }

    return firebaseIdToken;
  }
}

class FirebaseOAuthException implements Exception {
  const FirebaseOAuthException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => message;
}

class FirebaseOAuthCancelledException extends FirebaseOAuthException {
  const FirebaseOAuthCancelledException()
    : super('Google sign-in was cancelled.');
}
