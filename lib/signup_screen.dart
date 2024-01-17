import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:finalprojet/login_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'Menu.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<StatefulWidget> createState() => _SignUpScreen_state();
}

class _SignUpScreen_state extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey0 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey5 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey4 = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isFormValid = false; //vérification de la validité du formulaire
  bool _passwordVisible = false; //visibilité du mdp
  String _email = 'nour@gmail.com';

  @override
  Widget build(BuildContext context) => initWidget();

  Widget initWidget() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
              children: [
                //pour l app bar
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
                              "S'inscrire",
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
                //nom
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 50),
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
                    key: _formKey0,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer votre nom';
                        }
                      },
                      controller: firstnameController,
                      cursorColor: Color(0xffF5591F),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Color(0xffF5591F),
                        ),
                        hintText: "Nom",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                //prénom
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                    key: _formKey5,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer votre prénom';
                        }
                      },
                      controller: lastnameController,
                      cursorColor: Color(0xffF5591F),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Color(0xffF5591F),
                        ),
                        hintText: "Prénom",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                //user
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                    key: _formKey1,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer votre  adresse e-mail';
                        } else if (EmailValidator.validate(value) == false) {
                          return 'Veuillez entrer une adresse e-mail valide';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      cursorColor: Color(0xffF5591F),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email_rounded,
                          color: Color(0xffF5591F),
                        ),
                        hintText: "Email: example@gmail.com",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                //mdp
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                    key: _formKey2,
                    child: TextFormField(
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return "Veuillez entrer une combinaison d\'au moins six chiffres, lettres et signes de ponctuation";
                        }
                      },
                      controller: passwordController,
                      cursorColor: Color(0xffF5591F),
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.vpn_key,
                          color: Color(0xffF5591F),
                        ),
                        hintText: "Mot de passe",
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

                      //controller: passwordController,
                    ),
                  ),
                ),

                //mdp_confirm
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
                    key: _formKey3,
                    child: TextFormField(
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return 'Veuillez confirmer votre mot de passe';
                        }
                        if (value != passwordController.text) {
                          return "Veuillez entrer deux mots de passe conformes";
                        }
                      },
                      controller: confirmPasswordController,
                      obscureText: !_passwordVisible,
                      cursorColor: Color(0xffF5591F),
                      decoration: InputDecoration(
                        focusColor: Color(0xffF5591F),
                        icon: Icon(
                          Icons.vpn_key,
                          color: Color(0xffF5591F),
                        ),
                        hintText: "Confirmer votre mot de passe",
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
                      //validator: (value) => validateConfirmPassword(value, passwordController.text),
                      //controller: passwordController,
                    ),
                  ),
                ),

                //phone
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
                    key: _formKey4,
                    child: TextFormField(
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return "Veuillez entrer votre numéro de téléphone ";
                        }
                      },
                      controller: phoneController,
                      cursorColor: Color(0xffF5591F),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(8),
                      ],
                      decoration: InputDecoration(
                        focusColor: Color(0xffF5591F),
                        icon: Icon(
                          Icons.phone,
                          color: Color(0xffF5591F),
                        ),
                        hintText: "Numéro de téléphone",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 50),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  /* decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [ Color(0xffF5591F),  Color(0xffF2861E)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(50),
                  ),*/

                  child: ElevatedButton(
                    onPressed: ()async {
                      if (firstnameController.text.isEmpty ||
                          lastnameController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          passwordController.text.isEmpty ||
                          confirmPasswordController.text.isEmpty ||
                          phoneController.text.isEmpty) {
                        _formKey0.currentState!.validate();
                        _formKey5.currentState!.validate();
                        _formKey1.currentState!.validate();
                        _formKey2.currentState!.validate();
                        _formKey3.currentState!.validate();
                        _formKey4.currentState!.validate();
                      } else {

                        if (passwordController.text != confirmPasswordController.text) {
                          _formKey0.currentState!.validate();
                          _formKey5.currentState!.validate();
                          _formKey1.currentState!.validate();
                          _formKey2.currentState!.validate();
                          _formKey3.currentState!.validate();
                          _formKey4.currentState!.validate();
                          setState(() {
                            isFormValid = true;
                          });
                        } else {
                          FirebaseFirestore.instance.collection('Users').where('email',isEqualTo: emailController.text).get().then((QuerySnapshot query) async {

                     if(query.docs.isEmpty){ FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text)
                              .then((result) {
    if (result != null) {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(result.user!.uid)
        .set({
    'email': emailController.text,
    'firstname':firstnameController.text,
    'lastname':lastnameController.text,
    'phone':phoneController.text,
    'password':passwordController.text
    });}


                       });
                     final items_adpo=await geturl_adop();

                     Navigator.pushReplacement(context, MaterialPageRoute (
                         builder: (BuildContext context) => Menu(items:[],name: firstnameController.text+lastnameController.text,email:emailController.text,items_adop:items_adpo,)));}
                     else{
                       ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                           content: Text(
                               'Cet utilisateur existe déjà'),
                         ),
                       );
                            };
                          });


                        }
                      }

                    },
                    child: Text(
                      'S\'inscrire',
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
                ),

                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Avez vous déjà un compte? ", style:TextStyle(color: Colors.grey[600])),
                      GestureDetector(
                        child: Text(
                          "Se connecter maintenant",
                          style: TextStyle(
                              color: Color(0xffF5591F),
                              fontWeight: FontWeight.bold,
                              fontSize: 11.5),
                        ),
                        onTap: () {
                          // Write Tap Code Here.
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                      )
                    ],
                  ),
                )
              ],
            )));
  }


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
}
