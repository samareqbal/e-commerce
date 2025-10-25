import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:upstore/data/repositories/user/user_repository.dart';
import 'package:upstore/features/authentication/screens/login/login.dart';
import 'package:upstore/features/authentication/screens/onboarding/onboarding.dart';
import 'package:upstore/features/authentication/screens/signup/verify_email.dart';
import 'package:upstore/features/personalization/controllers/user_controller.dart';
import 'package:upstore/navigation_menu.dart';
import 'package:upstore/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:upstore/utils/exceptions/firebase_exceptions.dart';
import 'package:upstore/utils/exceptions/format_exceptions.dart';
import 'package:upstore/utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final localStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  @override
  void onReady() {
    super.onReady();
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  void screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      if (user.emailVerified) {
        //if verified go to navigation menu
        Get.offAll(() => NavigationMenu());

        //user specific
        await GetStorage.init(user.uid);
      } else {
        // verify email if not verified but account is created
        Get.offAll(() => VerifyEmailScreen(email: user.email));
      }
    } else {
      localStorage.writeIfNull('isFirstTime', true);

      localStorage.read('isFirstTime') != true
          ? Get.offAll(() => LoginScreen())
          : Get.offAll(() => OnboardingScreen());
    }
  }

  ///Authentication with email and password
  Future<UserCredential> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw SFormatExceptions();
    } on PlatformException catch (e) {
      throw SPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///Login with email and password
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw SFormatExceptions();
    } on PlatformException catch (e) {
      throw SPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///login with google
  Future<UserCredential> googleSignIn() async {
    try {

      ///show popup to select google account
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      ///Get auth details from request
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth!.idToken,
        accessToken: googleAuth.accessToken
      );


      UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential;

    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw SFormatExceptions();
    } on PlatformException catch (e) {
      throw SPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Send mail for verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw SFormatExceptions();
    } on PlatformException catch (e) {
      throw SPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Send mail for reset password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw SFormatExceptions();
    } on PlatformException catch (e) {
      throw SPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Re Authenticate
  Future<void> reAuthenticateUserWithEmailAndPassword(String email, String password) async {
    try {
      
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
      
      await currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw SFormatExceptions();
    } on PlatformException catch (e) {
      throw SPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///Logout user
  Future<void> logout() async{
    try {

      await FirebaseAuth.instance.signOut();

      // Sign out and disconnect from Google Sign-In
      final GoogleSignIn googleSignIn = GoogleSignIn();

      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.disconnect();
      }
      Get.offAll(() => LoginScreen());

    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw SFormatExceptions();
    } on PlatformException catch (e) {
      throw SPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///Delete account
  Future<void> deleteAccount() async{
    try {

      await UserRepository.instance.removeUserRecord(currentUser!.uid);

      if(UserController.instance.user.value.publicId.isNotEmpty){
        await UserRepository.instance.deleteImage(UserController.instance.user.value.publicId);
      }

      await _auth.currentUser!.delete();

    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw SFormatExceptions();
    } on PlatformException catch (e) {
      throw SPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


}
