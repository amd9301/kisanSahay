import 'package:flutter/material.dart';
import 'package:kisan_sahay/widgets/titlebar.dart';


enum MobileVerificationState{
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,

}


class PhoneLogin extends StatefulWidget {

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {

  final currentState= MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  final phoneController = TextEditingController();
  final otpController=TextEditingController();
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
              onPressed: (){},
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
            onPressed: (){},
            child: Text("Verify"),
            //color:Colors.blueGrey
            autofocus: true,
          ),

          Spacer(),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child:  currentState==MobileVerificationState.SHOW_MOBILE_FORM_STATE?
        getMobileFormWidget(context):
        getOtpFormWidget(context),
        padding: const EdgeInsets.all(16),
      )

    );
  }



}
