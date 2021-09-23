import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _phoneController = TextEditingController();
  CountryCode ?_code;
  bool _loading = false;
  bool _waitingConfirm = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Phone",
                    prefixIcon: CountryCodePicker(
                      onChanged: (code) {
                        _code = code;
                      },
                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                      initialSelection: 'BJ',
                      favorite: ['+229', 'BJ'],
                      showFlagDialog: true,
                      comparator: (a, b) => b.name!.compareTo(a.name!),
                      //Get the country information relevant to the initial selection
                      onInit: (code) {
                        _code = code;
                      },
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Obligatoire';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: _waitingConfirm ? null : () {
                          _waitingConfirm = true;
                          setState(() {

                          });
                          confirmPhoneNumberDialog();

                        }, child: _loading ? CircularProgressIndicator() : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text("Envoyer",),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }

  confirmPhoneNumberDialog() {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Confirmation", style: TextStyle(fontWeight: FontWeight.w700),),
        content: Text("${_code!.dialCode} ${_phoneController.text}",),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
            _waitingConfirm = false;
            setState(() {

            });
          }, child: Text("Non", style: TextStyle(color: Colors.red),)),
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
            _loading = true;
            setState(() {

            });
            sendCode();
          }, child: Text("Oui")),
        ],
      );
    });
  }

  sendCode() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '${_code!.dialCode}${_phoneController.text}',
      verificationCompleted: (PhoneAuthCredential credential) {
        print("credential");
        print(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print("FirebaseAuthException");
        print(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        print("codeSent");
        print(verificationId);
        _loading = false;
        _waitingConfirm = false;
        setState(() {

        });
        Navigator.pushNamed(context, "login/verification",
            arguments: {"code": _code, "phone": _phoneController.text
              ,"verificationId": verificationId, "resendToken": resendToken});
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("codeAutoRetrievalTimeout");
        print(verificationId);
        _loading = false;
        _waitingConfirm = false;
        if(mounted)
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: SnackBarAction(
                  label: "Erreur d'envoi du code", onPressed: () {

              })));
        });
      },
    );
  }
}
