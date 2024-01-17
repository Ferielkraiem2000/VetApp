import 'dart:io';
//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Menu.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false; //visibilité du mdp
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  final _formkey1 = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailcontroller.dispose();

    _passwordcontroller.dispose();

    super.dispose();
  }
  Future<String> getnom(email) async
  {final snapshot = await FirebaseFirestore.instance
      .collection('Users')
      .where('email', isEqualTo: email)
      .get();

  if (snapshot.docs.isNotEmpty) {
    final userDoc = snapshot.docs.first;
    final firstName = userDoc.get('firstname');
    final lastName = userDoc.get('lastname');
    final String name = '$firstName $lastName';
    return name;
  } else {
    throw Exception('Aucun utilisateur trouvé pour cet email.');
    return "" ;
  }}
  Future <List<String>> geturl_adop() async
  {    List<String> liste = [];
  final snapshot = await FirebaseFirestore.instance
      .collection('animal')
      .where('est_adopte', isEqualTo: true)
      .get();

  if (snapshot.docs.isNotEmpty) {
    final userDoc = snapshot.docs.forEach((element) { final url=element.get('imageurl');
    liste.add(url);});
    //  final firstName = userDoc.get('imageurl');
    return liste;}
  return [''];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
                    color: new Color(0xffF5591F),
                    gradient: LinearGradient(
                      colors: [(new Color(0xffF5591F)), new Color(0xffF2861E)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 50),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 7, bottom: 30),
                            alignment: Alignment.center,
                            child: Text(
                              "Se Connecter",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      )),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)),
                    ],
                  ),
                  child: Form(
                    key: _formkey1,
                    child: TextFormField(
                      controller: _emailcontroller,
                      cursorColor: Color(0xffF5591F),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Color(0xffF5591F),
                        ),
                        hintText: "Saisir votre nom d'utilisateur",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entre votre e-mail!';
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xffEEEEEE),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 20),
                          blurRadius: 100,
                          color: Color(0xffEEEEEE)),
                    ],
                  ),
                  child: Form(
                    key: _formkey2,
                    child: TextFormField(
                      controller: _passwordcontroller,
                      cursorColor: Color(0xffF5591F),
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        focusColor: Color(0xffF5591F),
                        icon: Icon(
                          Icons.vpn_key,
                          color: Color(0xffF5591F),
                        ),
                        hintText: "Saisir votre mot de passe",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible ? Icons.visibility_off : Icons.visibility,
                            color: Color(0xffF5591F),
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entre votre mot de passe!';
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formkey1.currentState!.validate() &&
                        _formkey2.currentState!.validate()) {
                      try {
                        var result = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                            email: _emailcontroller.text,
                            password: _passwordcontroller.text);
                        // Si la connexion réussit, vous pouvez rediriger l'utilisateur vers la page suivante
    final String email = _emailcontroller.text;
       final listeurl=await geturl(email);
       final listeurl_adop=await geturl_adop();
       print('okkk');
       print(listeurl);
       print('okkkkkkkkkk');
                        final name = await getnom(email);


    // ignore: use_build_context_synchronously
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => Menu(
    items: listeurl,
      name: name,
      email: email,
      items_adop:listeurl_adop

    )));}
                       on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          // Afficher un message d'erreur si l'utilisateur n'existe pas
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Email invalide!'),
                              backgroundColor: Colors.black,
                            ),
                          );
                        } else if (e.code == 'wrong-password') {
                          // Afficher un message d'erreur si le mot de passe est incorrect
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Mot de passe incorrect!'),
                              backgroundColor: Colors.black,
                            ),
                          );
                        } else {
                          // Afficher un message d'erreur générique pour les autres erreurs
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Nous n’avons pas trouvé de compte correspondant à ce que vous avez entré!'),
                              backgroundColor: Colors.black,
                            ),
                          );
                        }
                      } catch (e) {
                        // Afficher un message d'erreur générique pour toutes les autres erreurs
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Nous n’avons pas trouvé de compte correspondant à ce que vous avez entré!'),
                            backgroundColor: Colors.black,
                          ),
                        );
                      }
                    }
                  },
                  child: Text(
                    'Se connecter',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[700],
                    fixedSize: Size(350, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Vous n'avez pas de compte? ",
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SignUpScreen()));
                        },
                        child: Text("Créer un nouveau compte",
                          style: TextStyle(
                            color: Color(0xffF5591F),
                            fontWeight: FontWeight.bold,
                            fontSize: 10.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }

  Future <List<String>> geturl(email) async
  {    List<String> liste = [];
  final snapshot = await FirebaseFirestore.instance
      .collection('animal')
      .where('email', isEqualTo: email)

      .get();

  if (snapshot.docs.isNotEmpty) {
    final userDoc = snapshot.docs.forEach((element) { final url=element.get('imageurl');
    liste.add(url);});
  //  final firstName = userDoc.get('imageurl');
  return liste;}
  return [''];
  }
}
