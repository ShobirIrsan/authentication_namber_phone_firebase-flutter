part of 'services.dart';

class AuthServices {
  // handleAuth
  handleAuth() {
    return StreamBuilder(
      stream : FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot){
        if(snapshot.hasData){
          return Home();
        }
        else{
          return Login();
        }
      },
    );
  }

  signOut(){
    FirebaseAuth.instance.signOut();
  }

  signIn(AuthCredential authCreds){
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verId){
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
      verificationId: verId, smsCode: smsCode);
      signIn(authCreds);
  }
}
