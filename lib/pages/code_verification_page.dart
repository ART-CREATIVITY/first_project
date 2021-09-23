import 'package:country_code_picker/country_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/utils/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CodeVerificationPage extends StatefulWidget {
  final CountryCode code;
  final String phone;
  final String verificationId;
  final int resendToken;
  const CodeVerificationPage(
      {Key? key,
      required this.code,
      required this.phone,
      required this.verificationId,
      required this.resendToken})
      : super(key: key);

  @override
  _CodeVerificationPageState createState() => _CodeVerificationPageState();
}

class _CodeVerificationPageState extends State<CodeVerificationPage> {
  TextEditingController textEditingController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loading = false;
  AppPreferences? _preferences;

  @override
  void initState() {
    // TODO: implement initState
    print(widget.phone);
    print(widget.code);
    print(widget.verificationId);
    print(widget.resendToken);
    AppPreferences.init().then((value) => _preferences = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Login",
            style: TextStyle(fontSize: 26, color: Colors.black87),
          ),
        ),
        body: Center(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      // obscureText: true,
                      // obscuringCharacter: '*',
                      // obscuringWidget: FlutterLogo(
                      //   size: 24,
                      // ),
                      // blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v!.length < 3) {
                          return "I'm from validator";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) async {
                        print("Completed");
                        setState(() {
                          _loading = true;
                        });
                        try {
                          final AuthCredential credential =
                              PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: v,
                          );
                          UserCredential userCredential =
                              await auth.signInWithCredential(credential);
                          print('credential ===>>>$userCredential');
                          await _preferences!.saveLoginMode(true);
                          await _preferences!.saveFirebaseUid(userCredential.user!.uid);
                          setState(() {
                            _loading = false;
                            Navigator.pushNamedAndRemoveUntil(context, "home", (route) => false);
                          });
                        } catch (ex) {
                          setState(() {
                            _loading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: SnackBarAction(
                                  label: "Code incorrect", onPressed: () {

                              })));
                        }
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        // print(value);
                        // setState(() {
                        //   currentText = value;
                        // });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
                if(_loading) Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(),
                )
              ])),
        ));
  }
}
