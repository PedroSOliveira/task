// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

// class GoogleAuthController {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   signInWithGoogle() async {
//     final GoogleSignInAccount? user = await GoogleSignIn().signIn();

//     final GoogleSignInAuthentication googleAuth = await user!.authentication;

//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     return await auth.signInWithCredential(credential);
//   }
// }
