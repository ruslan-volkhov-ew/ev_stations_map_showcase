import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'logger.dart';

class GoogleAuth {
  Future<User?> signInWithGoogle() async {
    final firebaseAuth = FirebaseAuth.instance;

    User? firebaseUser;
    GoogleSignInAccount? googleUser;

    try {
      final isSignedIn = await GoogleSignIn().isSignedIn();

      if (isSignedIn) {
        // if so, return the current user
        firebaseUser =
            FirebaseAuth.instanceFor(app: await Firebase.initializeApp())
                .currentUser;
      } else {
        if (kIsWeb) {
          // final GoogleAuthProvider authProvider = GoogleAuthProvider();

          try {
            final googleUser = await GoogleSignIn(
              clientId:
                  '18921772410-u536t0v0p70m8p50ma0mdiu8k8l35775.apps.googleusercontent.com',
              // Optional clientId
              // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
              scopes: <String>[
                'email',
                'https://www.googleapis.com/auth/contacts.readonly',
              ],
            ).signIn();

            final GoogleSignInAuthentication? googleAuth =
                await googleUser?.authentication;

            final credential = GoogleAuthProvider.credential(
              accessToken: googleAuth?.accessToken,
              idToken: googleAuth?.idToken,
            );

            firebaseUser = (await FirebaseAuth.instanceFor(
                        app: await Firebase.initializeApp())
                    .signInWithCredential(credential))
                .user;
            // final UserCredential userCredential =
            //     await firebaseAuth.signInWithPopup(authProvider);

            // firebaseUser = userCredential.user;
          } catch (e) {
            log.fine(e);
          }
        } else {
          googleUser = await GoogleSignIn().signIn();
          final GoogleSignInAuthentication? googleAuth =
              await googleUser?.authentication;

          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );

          firebaseUser = (await FirebaseAuth.instanceFor(
                      app: await Firebase.initializeApp())
                  .signInWithCredential(credential))
              .user;
        }
      }
      return firebaseUser;
    } on FirebaseAuthException catch (e) {
      throw Exception('Authorization error :${e.toString()}');
    }
  }

  Future<bool> signOutGoogle() async {
    bool isSignedOut;
    try {
      // ignore: unused_local_variable
      final googleUser = await GoogleSignIn().signOut();

      isSignedOut = true;
    } on FirebaseAuthException catch (e) {
      isSignedOut = false;
      throw Exception('Unauthorization error :${e.toString()}');
    }
    return isSignedOut;
  }
}
