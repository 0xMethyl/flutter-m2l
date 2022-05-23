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
        backgroundColor : Colors.blue,
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 20,
              top: 90,
              bottom: 30
            ),
            child: Text("Connexion :", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white 
              ),
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
            borderColor: Colors.white,
            textColor: Colors.white,
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
                borderColor: Colors.white,
                textColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.8),
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