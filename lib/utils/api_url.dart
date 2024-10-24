const String _SERVER = 'http://server.schedule.com/api';
// const String _SERVER = '';

class ApiUrl {
  ApiUrl._();
  static _PublicApis public = _PublicApis();
  static _AuthApis auth = _AuthApis();
  static _UserApis user = _UserApis();
}

class _PublicApis {
  _PublicApis();

  String articles = '$_SERVER/articles'; // /id
  String tutorials = '$_SERVER/'; // /id
}

class _AuthApis {
  _AuthApis();

  String signIn = '$_SERVER/auth/login';
  String signUp = '$_SERVER/auth/register';
  String socialLogin = '$_SERVER/';

  String sendOtp = '$_SERVER/auth/forgot-password';
  String verifyCode = '$_SERVER/auth/check-otp';
  String resetPassword = '$_SERVER/auth/reset-password';

  String refreshToken = '$_SERVER/';
}

class _UserApis {
  _UserApis();

  String profile = '$_SERVER/auth/profile';
  String updateProfile = '$_SERVER/';

  String setTwoFactor = '$_SERVER/';
  String checkCurrentPassword = '$_SERVER/';
  String changePassword = '$_SERVER/';

  String signOut = '$_SERVER/auth/logout';
  String deleteAccount = '$_SERVER/';

  String sendAdditionalDetails = '$_SERVER/';
  String sendScanResult = '$_SERVER/';

  String savedArticles = '$_SERVER/users'; // /userId/articles

  String weeklyRecords = '$_SERVER/';
  String scanRecords = '$_SERVER/';
  String recordDetails = '$_SERVER/';
  String deleteRecord = '$_SERVER/';
}
