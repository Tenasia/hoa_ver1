

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<GoogleSignInAccount?> signInGoogle() async {
  try {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        ///TODO: put scopes app will use
      ],
    );
    /// if previously signed in, it will sign in silently
    /// if not, the sign-in dialog/login page will pop up
    GoogleSignInAccount? googleUser =
        await googleSignIn.signInSilently() ?? await googleSignIn.signIn();

    return googleUser;
  } catch (e) {
    debugPrint(e.toString());
    return null;
  }
}

Future<void> googleSignOut() async {
  GoogleSignIn googleSignIn = GoogleSignIn();
  await googleSignIn.signOut();
}