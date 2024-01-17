import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:im_stepper/stepper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'Menu.dart';
import 'vaccin.dart';

import 'package:firebase_app_check/firebase_app_check.dart';

final TextEditingController _ControllerAge = TextEditingController();
String? selectedEspeces;


class FormAnimal extends StatefulWidget {

  FormAnimal({super.key});

  get selectedespece {
    return selectedEspeces;
  }

  @override
  State<FormAnimal> createState() => _FormAnimalState();
}

class _FormAnimalState extends State<FormAnimal> {


  int activeStep = 0;
  int upperBound = 6;


  final TextEditingController _ControllerNom = TextEditingController();

  String? selectedSexe;

  String? selectedRace;

  List<String> Especes = ["Chien", "Chat", "Cheval"];
  List<String> Sexe = ["Mâle", "Femelle"];
  Map<String, List<String>> raceByEspeces = {
    "Chien": [
      "Berger Allemand",
      "Berger Malinois",
      "Lévrier Arabe",
      "Labrador",
      "Caniche",
      "Pitbul",
      "Saint Bernard"
    ],
    "Chat": ["Siamois", "Ragdoll", "Persan", "Bleu Russe", "Angora"],
    "Cheval": [
      "Frison",
      "Appaloosa",
      "Pottok",
      "Percheron",
      "Quarter Horse",
      "Haflinger"
    ],
  };
  Color _buttonColor0 = Colors.grey;
  Color _buttonColor1 = Colors.grey;
  Color _buttonColor2 = Colors.grey;
  Color _buttonColor3 = Colors.grey;
  Color _buttonColor4 = Colors.grey;

  File? _image = null;
  ImagePicker imagePicker = ImagePicker();

  void _afficherSnack() {
    setState(() {
      activeStep = activeStep;
    });
    const snack = SnackBar(
      content: Text("Veuillez remplir ce Champ !"),
      backgroundColor: Colors.black,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(leading: IconButton(onPressed: (

          ) async {
        final String email = "feriel@gmail.com";
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

                )));
        },
          icon:Icon(Icons.arrow_back,color: Colors.black)),backgroundColor: Colors.transparent,elevation: 0.0)
      ,key: GlobalKey<ScaffoldState>(),
      body: Padding(

        padding: const EdgeInsets.only(left: 8, top: 150),
        child: Column(
          children: [

            IconStepper(
              icons: [
                Icon(Icons.edit),
                Icon(Icons.pets),
                Icon(Icons.ac_unit),
                Icon(Icons.male),
                Icon(Icons.calendar_month),
                Icon(Icons.add_a_photo),
              ],
              enableStepTapping: false,
              activeStepColor: Colors.orange,
              activeStepBorderColor: Colors.black,
              lineColor: Colors.orange,
              stepColor: Colors.orange,
              stepRadius: 20,
              lineLength: 5,
              onStepReached: (index) {
                setState(() {
                  activeStep = index;
                });
              },
            ),
            Container(
                child: (activeStep == 0)
                    ? header1()
                    : (activeStep == 1)
                        ? header2()
                        : (activeStep == 2)
                            ? header3()
                            : (activeStep == 3)
                                ? header4()
                                : (activeStep == 4)
                                    ? header5()
                                    : (activeStep == 5)
                                        ? header6()
                                        : header1()),
            Container(
                child: (activeStep == 0)
                    ? nextButton0()
                    : (activeStep == 1)
                        ? nextButton1()
                        : (activeStep == 2)
                            ? nextButton2()
                            : (activeStep == 3)
                                ? nextButton3()
                                : (activeStep == 4)
                                    ? nextButton4()
                                    : (activeStep == 5)
                                        ? nextButton5()
                                        : header1())
          ],
        ),
      ),
    );
  }

  Widget nextButton0() {
    return ElevatedButton(
        onPressed: () async {
          if (activeStep < upperBound) {
            if (activeStep == 0 && _ControllerNom.text.isNotEmpty) {
              setState(() {
                activeStep++;
              });
            } else {
              _afficherSnack();
            }
          }
        },
        child: const Text('continuer'),
        style: ElevatedButton.styleFrom(
          backgroundColor: _buttonColor0,
        ));
  }

  Widget nextButton1() {
    return ElevatedButton(
        onPressed: () async {
          if (activeStep < upperBound) {
            if (activeStep == 1 && selectedEspeces != null) {
              setState(() {
                activeStep++;
              });
            } else {
              _afficherSnack();
            }
          }
        },
        child: const Text('continuer'),
        style: ElevatedButton.styleFrom(
          backgroundColor: _buttonColor1,
        ));
  }

  Widget nextButton2() {
    return ElevatedButton(
        onPressed: () async {
          if (activeStep < upperBound) {
            if (activeStep == 2 && selectedRace != null) {
              setState(() {
                activeStep++;
              });
            } else {
              _afficherSnack();
            }
          }
        },
        child: const Text('continuer'),
        style: ElevatedButton.styleFrom(
          backgroundColor: _buttonColor2,
        ));
  }

  Widget nextButton3() {
    return ElevatedButton(
        onPressed: () async {
          if (activeStep < upperBound) {
            if (activeStep == 3 && selectedSexe != null) {
              setState(() {
                activeStep++;
              });
            } else {
              _afficherSnack();
            }
          }
        },
        child: const Text('continuer'),
        style: ElevatedButton.styleFrom(
          backgroundColor: _buttonColor3,
        ));
  }

  Widget nextButton4() {
    return ElevatedButton(
        onPressed: () async {
          if (activeStep < upperBound) {
            if (activeStep == 4 && _ControllerAge.text.isNotEmpty) {
              setState(() {
                activeStep++;
              });
            } else {
              _afficherSnack();
            }
          }
        },
        child: const Text('continuer'),
        style: ElevatedButton.styleFrom(
          backgroundColor: _buttonColor4,
        ));
  }

  Widget nextButton5() {
    return ElevatedButton(
        onPressed: () async {
          _saveForm();
        },
        child: const Text('enregistrer'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
        ));
  }

  Widget header1() {
    return Container(
        margin: EdgeInsets.only(top: 30),
        child: TextFormField(
          autofocus: true,
          focusNode: FocusNode(),
          onTap: () {
            FocusNode().requestFocus();
          },
          onChanged: (text) {
            // Fonction qui se déclenche lorsque l'utilisateur commence à écrire
            setState(() {
              _buttonColor0 =
                  Colors.orange; // Changer la couleur du bouton en vert
            });
          },
          controller: _ControllerNom,
          cursorColor: Colors.orange,
          style: TextStyle(
            fontSize: 15.0,
          ),
          decoration: const InputDecoration(
            labelText: 'Quel est le nom de votre animal ? ',
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 50,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.orange,
                width: 2.0,
              ),
            ),
          ),
        ));
  }

  Widget header2() {
    return Column(
      children: [
        Text("Quel est l'espèce de votre animal ?",
            style: TextStyle(height: 5)),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            focusColor: Color(0xFFF7924A),
          ),
          dropdownColor: Colors.white,
          iconEnabledColor: Colors.orange,
          value: selectedEspeces,
          onChanged: (value) {
            setState(() {
              selectedEspeces = value;
              _buttonColor1 = Colors.orange;
            });
          },
          items: Especes.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: TextStyle(color: Colors.orange),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  Widget header3() {
    return Column(
      children: [
        Text("Quel est la race de votre animal ?", style: TextStyle(height: 5)),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            focusColor: Color(0xFFF7924A),
          ),
          dropdownColor: Colors.white,
          iconEnabledColor: Colors.orange,
          value: selectedRace,
          onChanged: (value) {
            setState(() {
              selectedRace = value;
              _buttonColor2 = Colors.orange;
            });
          },
          items: raceByEspeces[selectedEspeces]?.map((r) {
            return DropdownMenuItem(
              value: r,
              child: Text(
                r,
                style: TextStyle(color: Colors.orange),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  Widget header4() {

    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Text("Quel est le sexe de votre animal ?",
              style: TextStyle(height: 2)),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              focusColor: Color(0xFFF7924A),
            ),
            dropdownColor: Colors.white,
            iconEnabledColor: Colors.orange,
            value: selectedSexe,
            onChanged: (value) {
              setState(() {

                selectedSexe = value;

                _buttonColor3 = Colors.orange;
              });
            },
            items: Sexe.map((s) {
              return DropdownMenuItem(
                value: s,
                child: Text(
                  s,
                  style: TextStyle(color: Colors.orange),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget header5() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: TextField(
        autofocus: true,
        focusNode: FocusNode(),
        onTap: () {
          FocusNode().requestFocus();
        },
        onChanged: (text) {
          setState(() {
            _buttonColor4 = Colors.orange;
          });
        },
        controller: _ControllerAge,
        cursorColor: Colors.orange,
        style: TextStyle(
          fontSize: 15.0,
        ),
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 50,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2.0,
            ),
          ),
          labelText: "Quel est l'âge de votre animal ? ",
          labelStyle: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  /*void  _openCamera(BuildContext context) async {

    try {
      var image = await imagePicker.pickImage(source: ImageSource.camera);

      if (image != null) {
        setState(() {
          _image = File(image.path);
        });
        print("Image saved to _image variable: $_image");
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking image: $e");
    }

    Navigator.of(context).pop();
  }
  void _openGallary(BuildContext context) async {

    try {
      var image = await imagePicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _image = File(image.path);
        });
        print("Image saved to _image variable: $_image");
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
    Navigator.of(context).pop();

  }
*/
  void pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    try {
      var image = await imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _image = File(image.path);
        });
        print("Image saved to _image variable: $_image");
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }


  choiceImage() {
    if (selectedEspeces == 'Chat') {
      return AssetImage('assets/images/chat.jpg');
    } else if (selectedEspeces == 'Chien') {
      return AssetImage('assets/images/chien.jpg');
    } else if (selectedEspeces == 'Cheval') {
      return AssetImage('assets/images/cheval.jpg');
    }
  }

  Widget header6() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage:
                    _image == null ? choiceImage() : FileImage(_image!),
                radius: 80,
              ),
              GestureDetector(onTap: pickImage, child: Icon(Icons.camera_alt))
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _saveForm()  async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('images')
          .child(_ControllerNom.value.text! + '.jpg');
       final UploadTask uploadTask = ref.putFile(_image!);
    final TaskSnapshot downloadUrl = await uploadTask;
    final String url =( await downloadUrl.ref.getDownloadURL()).toString();

      FirebaseFirestore.instance.collection('animal').doc().set({
        'nom': _ControllerNom.value.text,
        'espece': selectedEspeces,
        'race': selectedRace,
        'sexe': selectedSexe,
        'age': _ControllerAge.value.text,
        'imageurl':url,
        'email':'feriel@gmail.com',
'est_adopte': false
      });
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => VaccineTableScreen(url:url,)));

    }
    catch (error) {
      print(error);
    }



  }

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
