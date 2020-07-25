import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_firecore/services/services.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController pengontrol = TextEditingController();
  TextEditingController pengontrol2 = TextEditingController();
  String nomor, vercationId, smsCode;
  bool codeSent = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                fillColor: Colors.red[50],
                filled: true,
                prefix: Icon(Icons.phone),
                hintText: "nomor",
                /* prefixText: "kata :",
                prefixStyle: TextStyle(
                  color:Colors.amber,
                )*/
              ),
              onChanged: (value) {
                setState(() {
                  this.nomor = value;
                });
              },
              controller: pengontrol,
            ),
             codeSent ? Padding(
               padding: const EdgeInsets.all(8.0),
               child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.red[50],
                  filled: true,
                  hintText: "enter otp",
                  /* prefixText: "kata :",
                  prefixStyle: TextStyle(
                    color:Colors.amber,
                  )*/
                ),
                onChanged: (value) {
                  setState(() {
                    this.smsCode = value;
                  });
                },
                 controller: pengontrol2,
            ),
             ):Container(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: codeSent ? Text("Verify"):Text("Login"),
                onPressed: () {
                  codeSent ? AuthServices().signInWithOTP(smsCode, vercationId):verifyPhone(nomor);
                },
              ),
            )
          ],
        )),
      ),
    );
  }

  Future<void> verifyPhone(nomor) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthServices().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.vercationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.vercationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: nomor,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
