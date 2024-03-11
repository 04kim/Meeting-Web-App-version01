import 'package:shared_preferences/shared_preferences.dart';
import 'package:meeting_app/app/share/states.dart';

// Class to handle loading user data from shared preferences
class AuthFunctions {
  static LoadUserDataResult loadUserEmailPassword(
      SignInFormState state, SharedPreferences sharedPreferences) {
    try {
      // Get the value of "remember_me" key, default to false
      final rememberMeValue = sharedPreferences.getBool('remember_me') ?? false;

      if (rememberMeValue) {
        // Get the saved email if "remember_me" is true
        final savedEmail = sharedPreferences.getString('email') ?? '';
        // Return a LoadUserDataResult object with loaded data
        return LoadUserDataResult(savedEmail, rememberMeValue);
      } else {
        // Return a LoadUserDataResult object with default values
        return LoadUserDataResult('', false);
      }
    } catch (e) {
      print('Error loading user data: $e');
      // Return a LoadUserDataResult object with default values in case of an error
      return LoadUserDataResult('', false);
    }
  }
}

// Class to hold the result of loading user data
class LoadUserDataResult {
  final String email;
  final bool rememberMe;

  LoadUserDataResult(this.email, this.rememberMe);
}
