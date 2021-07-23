import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisan_sahay/HomePage.dart';

enum MobileVerificationState{
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,

}


class PhoneLogin extends StatefulWidget {

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {



  MobileVerificationState currentState= MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  final phoneController = TextEditingController();
  final otpController=TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  late String verificationId ;

  bool showLoading=false;


  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential)
  async {
    setState(()
    {
      showLoading=true;
    });
    try{
      final authCredential = await _auth.signInWithCredential(phoneAuthCredential);
      setState(()
      {
        showLoading=false;
      });
      if(authCredential?.user !=null)
        {
          Navigator.push(context,MaterialPageRoute(builder: (context)=> HomePage()));
        }
    } on FirebaseAuthException catch(e){
      setState(()
      {
        showLoading=false;
      });
      ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text("Some Error Occurred!"), duration: Duration(milliseconds: 300), ), );

    }
  }

  late String _phoneNo;
  getMobileFormWidget(context)
  {
      return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          children: [
            Spacer(),
            Text(
              "Login With Ph No",
              style: TextStyle(
                fontSize: 25.0
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              decoration:
              InputDecoration(labelText: 'Phone Number',prefixIcon: Icon(Icons.phone)),
              validator: (value) {
                if(value!.isEmpty){
                  return 'This field is required';
                }
              },

              onChanged: (value) => _phoneNo = value,
            ),
          SizedBox(height: 20,),
            ElevatedButton(

              onPressed: () async{
                setState(()
                {
                  showLoading=true;
                });
               await _auth.verifyPhoneNumber(
                    phoneNumber: "+91"+phoneController.text,
                    verificationCompleted: (phoneAuthCredential) async
                    {
                      setState(()
                      {
                        showLoading=false;
                      });
                      //signInWithPhoneAuthCredential(phoneAuthCredential);
                    },
                    verificationFailed: (verificationFailed) async
                    {
                      //_scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(verificationFailed.message)));
                      ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text(verificationFailed.message!), duration: Duration(milliseconds: 300), ), );
                    },
                    codeSent: (verificationId,resendingToken) async
                    {
                      setState(()
                      {
                         showLoading=false;
                         currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                         this.verificationId = verificationId;
                      });
                    },
                    codeAutoRetrievalTimeout: (verificationId) async
                    {

                    }
                );
              },
                child: Text("SEND"),
                //color:Colors.blueGrey
              autofocus: true,
            ),

            Spacer(),
          ],
        ),
      );
  }
  getOtpFormWidget(context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Column(
        children: [
          Spacer(),
          Text(
            "Enter the OTP",
            style: TextStyle(
                fontSize: 25.0
            ),
          ),
          SizedBox(height: 20,),
          TextFormField(
            controller: otpController,
            keyboardType: TextInputType.number,
            decoration:
            InputDecoration(labelText: 'OTP',prefixIcon: Icon(Icons.lock_outline)),
            validator: (value) {
              if(value!.isEmpty){
                return 'This field is required';
              }
            },

            onChanged: (value) => _phoneNo = value,
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () async{
              PhoneAuthCredential phoneAuthCredential= PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: otpController.text);
              signInWithPhoneAuthCredential(phoneAuthCredential);

            },
            child: Text("Verify"),
            //color:Colors.blueGrey
            autofocus: true,
          ),

          Spacer(),
        ],
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey= GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body:Container(
        child:  showLoading?Center(child:CircularProgressIndicator()):
        currentState==MobileVerificationState.SHOW_MOBILE_FORM_STATE?
        getMobileFormWidget(context):
        getOtpFormWidget(context),
        padding: const EdgeInsets.all(16),
      )

    );
  }




}
