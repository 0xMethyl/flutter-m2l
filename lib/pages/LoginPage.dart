import 'package:flutter/material.dart';
import 'package:flutterapp/produit.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor : Colors.white,
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _loginUI(context),
            ),
            inAsyncCall: isAPIcallProcess,
            opacity: 0.3,
            key: UniqueKey(),
          ),
      ),
    );
  }

  Widget _loginUI(BuildContext context){
    return SingleChildScrollView(
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          Icon(Icons.person_outlined, color:Colors.grey, size:50),
          SizedBox(height:13),
          Text(
            "Bienvenue",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Connectez-vous pour continuer",
            style: TextStyle(
              fontSize:18,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          FormHelper.inputFieldWidget(
            context, 
            "Email", 
            "Email", 
            (onValidateVal){
              if(onValidateVal.isEmpty){
                return "L'email ne peut être vide";
              }
              return null;
            }, 
            (onSaved){
              email = onSaved;
            },
            borderFocusColor: Colors.white,
            borderColor: Colors.red,
            textColor: Colors.red,
            hintColor: Colors.white.withOpacity(0.8),
            borderRadius: 10
            ),
            Padding(
              padding: const EdgeInsets.only(top:10),
              child:  FormHelper.inputFieldWidget(
                context, 
                "Mot_de_passe", 
                "mot de passe", 
                (onValidateVal){
                  if(onValidateVal.isEmpty){
                    return "Le mot de passe ne peut être vide";
                  }
                  return null;
                }, 
                (onSaved){
                  password = onSaved;
                },
                borderFocusColor: Colors.white,
                borderColor: Colors.red,
                textColor: Colors.red,
                hintColor: Colors.red.withOpacity(0.8),
                borderRadius: 10,
                ),
                
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: FormHelper.submitButton(
                "login", 
                (){
                  dynamic validate = globalFormKey.currentState?.validate();
                  if(validate != null && validate){
                    globalFormKey.currentState?.save();
                    produit.Login(context, email, password);         
                  }             
                },
                btnColor: Colors.red,
                borderColor: Colors.white,
                txtColor: Colors.white,
                borderRadius: 10
               ) ,
            )
            
          ]
        ),
      );
  }
}