import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Use minimal scopes for better privacy and UX
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',   // Grants access to the user's email address
      'profile', // Grants access to basic profile info (name, photo URL)
    ],
  );

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // These are the core identity tokens
      print("ID Token: ${googleAuth.idToken}");

      return googleUser;
    } catch (e) {
      print("Sign-in failed: $e");
      return null;
    }
  }
}
