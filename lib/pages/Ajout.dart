import 'package:flutter/material.dart';
import 'package:flutterapp/produit.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class Ajout extends StatefulWidget {
  const Ajout({ Key? key }) : super(key: key);

  @override
  State<Ajout> createState() => _AjoutState();
}

class _AjoutState extends State<Ajout> {
  bool isAPIcallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? title;
  String? body;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        title: const Text("Nouveau produit"),
        ),
        backgroundColor : Colors.white,
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _AjoutUI(context),
            ),
            inAsyncCall: isAPIcallProcess,
            opacity: 0.3,
            key: UniqueKey(),
          ),
      ),
    );
  }
  Widget _AjoutUI(BuildContext context){
    return SingleChildScrollView(
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 20,
              top: 70,
              bottom: 30
            ),
            child: Text("Titre :", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.blue 
              ),
            ),
          ),
          FormHelper.inputFieldWidget(
            context, 
            "Title", 
            "Title", 
            (onValidateVal){
              if(onValidateVal.isEmpty){
                return "Le titre ne peut être vide";
              }
              return null;
            }, 
            (onSaved){
              title = onSaved;
            },
            borderFocusColor: Colors.blue,
            borderColor: Colors.blue,
            textColor: Colors.blue,
            hintColor: Colors.blue.withOpacity(0.8),
            borderRadius: 10
            ),
            const Padding(
              padding:  EdgeInsets.only(top:20,left: 20,),
              child:  Text("résumé :", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.blue 
              ),
            ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10),
              child:  FormHelper.inputFieldWidget(
                context, 
                "body", 
                "résumé", 
                (onValidateVal){
                  if(onValidateVal.isEmpty){
                    return "Le résumé ne peut être vide";
                  }
                  return null;
                }, 
                (onSaved){
                  body = onSaved;
                },
                borderFocusColor: Colors.blue,
                borderColor: Colors.blue,
                textColor: Colors.blue,
                hintColor: Colors.blue.withOpacity(0.8),
                borderRadius: 10,
                ),
                
                
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: FormHelper.submitButton(
                "Validez", 
                (){
                  dynamic validate = globalFormKey.currentState?.validate();
                  if(validate != null && validate){
                    globalFormKey.currentState?.save();
                    produit.ajout(context, title, body);
                  }             
                },
                btnColor: Colors.blue,
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