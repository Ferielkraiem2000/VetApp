import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalprojet/formanimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'Menu.dart';
import 'formanimal.dart';





final Map<String?, List<Vaccine>?> vaccines = {
  "Chat": [
    Vaccine('RCP', ['2\nmois', '2.5\nmois'], false),
    Vaccine('Antirabique', ['3\nmois'], false),
    Vaccine('RCP+\nAntirabique', ['12\nmois', '14\nmois'], false),
    Vaccine(
        'Anthelmintique',
        [
          '15\njours',
          '1\nmois',
          '1.5\nmois',
          '2\nmois',
          '2.5\nmois',
          '4.5\nmois',
          '6.5\nmois',
          '8.5\nmois',
          '11.5\nmois'
        ],
        false),
    Vaccine(
        'Fiponile',
        [
          '2\nmois',
          '3\nmois',
          '4\nmois',
          '5\nmois',
          '6\nmois',
          '7\nmois',
          '8\nmois',
          '9\nmois',
          '10\nmois',
          '11\nmois',
          '12\nmois'
        ],
        false)
  ],
  "Chien": [
    Vaccine('P', ['1.5\nmois '], false),
    Vaccine(
        'CHPPI,L', ['2\nmois', '3\nmois', '6.5\nmois', '11\nmois'], false),
    Vaccine('Antirabique', ['3 mois', '11 mois'], false),
    Vaccine(
        'Anthelmintique',
        [
          '15\njours',
          '1\nmois',
          '1.5\nmois',
          '2\nmois',
          '2.5\nmois',
          '4.5\nmois',
          '6.5\nmois',
          '8.5\nmois',
          '11.5\nmois'
        ],
        false),
    Vaccine(
        'Fiponile',
        [
          '2\nmois',
          '3\nmois',
          '4\nmois',
          '5\nmois',
          '6\nmois',
          '7\nmois',
          '8\nmois',
          '9\nmois',
          '10\nmois',
          '11\nmois',
          '12\nmois'
        ],
        false),
    Vaccine('collier Scallibor', ['2\nmois', '8\nmois'], false)
  ],
  /*"Cheval": [
      Vaccine('Grippe équine', 'inactivated'),
      Vaccine('Tétanos', ''),
      Vaccine('Rhino-pneumonie équine', 'inactivated')]*/
};



class VaccineTableScreen extends StatefulWidget {

final String url;
VaccineTableScreen({super.key,required this.url});

  @override
  _VaccineTableScreenState createState() => _VaccineTableScreenState();
}

class Vaccine {
  String name;
  List<String> age;
  bool isActive = false;
  Vaccine(this.name, this.age, this.isActive);
}

class _VaccineTableScreenState extends State<VaccineTableScreen> {
  bool isClicked = false;


  final List<String> col = [
    '15\njours',
    '1\nmois',
    '1.5\nmois',
    '2\nmois',
    '2.5\nmois',
    '3\nmois',
    '4\nmois',
    '4.5\nmois',
    '5\nmois',
    '6\nmois',
    '6.5\nmois',
    '7\nmois',
    '8\nmois',
    '8.5\nmois',
    '9\nmois',
    '10\nmois',
    '11\nmois',
    '11.5\nmois',
    '12\nmois',
    '14\nmois'
  ];

  String? selectedAge;

  //late String? selectedSpecies = 'Chat';
  final FirebaseStorage storage = FirebaseStorage.instance;
  late String messageesp;
  bool isSelected = false;

  //String? msgurl;

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic> ?? {};

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(leading: IconButton(onPressed: () async {
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
        }, icon: Icon(Icons.arrow_back, color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [


                Container(
                  width: 510,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        // offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 800, sigmaY: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.orange.shade800,
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('animal')
                              .where('imageurl', isEqualTo: widget.url)
                              .snapshots(),


                          builder: (context, snapshot) {
                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return Text("Chargement en cours...");
                            }
                            final messages = snapshot.data!.docs;
                            final firstMessage = messages.first;
                            final messagenom = firstMessage.get('nom');
                            final messageespece = firstMessage.get('espece');


                            messageesp = messageespece;

                            final messagerace = firstMessage.get('race');
                            final messagesexe = firstMessage.get('sexe');
                            final messageage = firstMessage.get('age');

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                DecoratedBox(

                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade100,


                                  ),
                                  child: Container(

                                    width: 400,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      messagenom.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                    width: 300,
                                    height: 300,
                                    child: Image.network(

                                      widget.url,)),

                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.pets,
                                        color: Colors.orange.shade800,
                                        size: 25),
                                    Text(
                                      ' Espèce: $messageespece',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.category,
                                        color: Colors.orange.shade800,
                                        size: 25),
                                    Text(
                                      ' Race: $messagerace',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(messagesexe == 'Mâle'
                                        ? Icons.male
                                        : Icons.female,
                                        color: Colors.orange.shade800,
                                        size: 25),
                                    Text(
                                      ' Sexe: $messagesexe',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.calendar_today,
                                        color: Colors.orange.shade800,
                                        size: 25),
                                    Text(
                                      ' Age: $messageage',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              0.0, 20, 0.0, 50),
                                          backgroundColor: Colors.transparent,
                                          content: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 5.0, sigmaY: 5.0),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Column(
                                                children: [

                                                  Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .only(
                                                          left: 0.1, top: 150),
                                                      child: Container(
                                                        height: 100,
                                                        child: DataTable(
                                                          dataRowMaxHeight: 48,
                                                          columnSpacing: 0,
                                                          dataRowColor: MaterialStateColor
                                                              .resolveWith(
                                                                  (states) =>
                                                              Colors.orange),
                                                          columns: _buildColumns(),
                                                          rows: _buildRows() as List <DataRow>,
                                                          headingRowColor: MaterialStateColor
                                                              .resolveWith(
                                                                  (states) =>
                                                              Colors.orange),
                                                          headingTextStyle: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontSize: 16.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Text('Consulter le carnet des vaccins',
                                    style: TextStyle(
                                        color: Colors.orange.shade800,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.orange.shade800,
                                        decorationThickness: 2.0,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  /*Future<String> getImageURL() async {
    Reference ref = storage.ref().child('images/1681568428234.jpg');
    String imageURL = await ref.getDownloadURL();
    return imageURL;
  }*/
  List<DataColumn> _buildColumns() {
    final columns = <DataColumn>[
      DataColumn(
        label: Text('Vaccin'),
      ),
    ];
    for (String i in col) {
      final columnLabel = Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          '${i}',
          style: TextStyle(fontSize: 12),
        ),
      );
      final column = DataColumn(label: columnLabel);
      columns.add(column);
    }
    return columns;
  }


  List<DataRow>? _buildRows() {
    final rows = <DataRow>[];
    if (vaccines[messageesp] != null) {
      for (final vaccine in vaccines[messageesp]!) {
        final cells = <DataCell>[
          DataCell(
            Container(
              width: 100,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  vaccine.name,
                ),
              ),
            ),
          ),
        ];
        //var newCell = null;
        var cell;

        for (String i in col) {
          cell = DataCell(
              Container(
                width: 30,
                height: 60,
                child: vaccines[messageesp]!.any((v) => v.name == vaccine.name && v.age.contains(i))


                    ? GestureDetector(
                  onTap: () {
                    setState(() {
                      if(selectedAge==i){
                        selectedAge=null;
                        vaccine.isActive = false;}
                      else {selectedAge=i;
                      vaccine.isActive=true;
                      }

                    });
                  },
                  child: Center(
                    child: vaccine.isActive && selectedAge==i
                        ? Icon( vaccine.isActive?
                    Icons.check : null ,
                      color: Colors.black,
                    )
                        : Image.asset('assets/images/ser.png'),
                  ),
                )
                    : null,
              )
          );
          cells.add(cell);
        }

        final row = DataRow(cells: cells);
        rows.add(row);
      }
    }
    return rows;
  }

  bool coresspondance(age1, nom1) {
    var l = [];
    for (var vac in vaccines['Chien']!) {
      if (vac.name == nom1) {
        l = vac.age;
      }
    }
    if (l.contains(age1)) {
      return true;
    } else {
      return false;
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