
import 'dart:io' show Platform;
// This acts as like a settings.py in terms of purpose, it's where
// We set our constant or static variables;

const tokenBox = "NOTEPADTAKEN";
const rememberMeBox = "RememberMe";

const GOOGLE_ISSUER = 'https://accounts.google.com';

const GOOGLE_CLIENT_ID_IOS = '833450757511-nlsjvl786f2i7ocnnbfnmp59nu00vjt1.apps.googleusercontent.com';
const GOOGLE_REDIRECT_URI_IOS = 'com.googleusercontent.apps.833450757511-nlsjvl786f2i7ocnnbfnmp59nu00vjt1.apps.googleusercontent.com:/oauthredirect';

const GOOGLE_CLIENT_ID_ANDROID = '833450757511-nlsjvl786f2i7ocnnbfnmp59nu00vjt1.apps.googleusercontent.com';
const GOOGLE_REDIRECT_URI_ANDROID = 'com.googleusercontent.apps.833450757511-nlsjvl786f2i7ocnnbfnmp59nu00vjt1.apps.googleusercontent.com:/oauthredirect';


String clientID() {
  if(Platform.isAndroid) {
    return GOOGLE_CLIENT_ID_ANDROID;
  } else if (Platform.isIOS) {
    return GOOGLE_CLIENT_ID_IOS;
  }
  return '';
}

String redirectUrl() {
  if(Platform.isAndroid) {
    return GOOGLE_REDIRECT_URI_ANDROID;
  } else if (Platform.isIOS) {
    return GOOGLE_REDIRECT_URI_IOS;
  }
  return '';
}