import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterapp/produit.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  
  late Future<List> _bookList;
  @override 
  void initState() {

    super.initState();
    _bookList = produit.getAllProduit();
  }
  int selectedIndex = 1;
  final Widget _myContacts = const MyContacts();
  final Widget _myProfile = const MyProfile();
  
  @override
  Widget build(BuildContext context) {
    if(ModalRoute.of(context)!.settings.arguments != null){
      Object? arg = ModalRoute.of(context)!.settings.arguments;
      var newProduit= jsonDecode(arg.toString());
       setState(() {
         _bookList = _bookList.then<List>((value) {return [newProduit, ...value];});
      });
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("North Sport - Administration"),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: FutureBuilder<List>(
          future: _bookList,
          builder: (context, snapshot){
            if(snapshot.hasData){
              
              print(snapshot.data![0]['client_nom']);
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, i){
                  var nomImage = snapshot.data![i]["produit_nom"];
                  return Card( 
                    child: ListTile( 
                      title: Text(snapshot.data![i]['produit_nom'], style: const TextStyle(fontSize: 30)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          
                          Text(snapshot.data![i]['produit_marque'], style: const TextStyle(fontSize: 20)),
                          
                          Image.asset(
                            'assets/images/'+nomImage.replaceAll(" ", "_")+'.png',
                            width: 50,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                      ]),
                    ),
                  );
                }
              );
            }
            else{
              return const Center(
                child: Text("Pas de données"),
              );
            }
          },
        ),
      ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          items: const[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Accueil",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Administration",
            )
          ],
          onTap: (int index) {
            onTapHandler(index);
          },
          
        ),
      );
    }
  Widget getBody( )  {
    if(selectedIndex == 0) {
      return _myContacts;
    } else {
      return _myProfile;
    }
  }

  void onTapHandler(int index)  {
    setState(() {
      selectedIndex = index;
    });
  }
}


class MyContacts extends StatelessWidget {
  const MyContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Test Redirection");
    Navigator.pushNamed(context, '/home');
    return const Center(child: Text("Accueil"));
  }
}



class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Navigator.pushNamed(context, '/admin');
    return const Center(child: Text("Administration"));
    
  }
}
