import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalprojet/formAnimal.dart';
import 'package:flutter/material.dart';
import 'BottomNavBar.dart';
import 'CircularMenu.dart';
import 'package:floating_menu_panel/floating_menu_panel.dart';
import 'AnimauxEnAdoption.dart';
import 'SwipeVideos.dart';
import 'MyAnimals.dart';

int i = 4;
var map = {0: 'assets/tn.jpg', 1: 'assets/tn.jpg', 2: 'assets/tn.jpg'};


class Menu extends StatefulWidget {

  Menu({super.key, required this.items,required this.name, required this.email,required this.items_adop});
  final List<String> items ;
  final List<String> items_adop;
final String email;
  final String name ;


  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String name ='';

  @override
  void initState() {
    super.initState();
    name= widget.name;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFFF7924A),
          leadingWidth: 100,
          toolbarHeight: 130,
          leading: circularMenu(),
          actions:[
        Padding(
        padding: EdgeInsets.only(right: 45.0, top: 45),
      child: Text(
         name,
        style:
        TextStyle(color: Colors.black, fontWeight: FontWeight.w900,fontSize: 20, fontStyle: FontStyle.italic),
      ),
    )
    ]

          ),

        bottomNavigationBar: BottomNavBar(),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25, right: 4),
                    child: SizedBox(
                      height: 500,
                      child: ListView(
                        children: [
                          Container(
                            height: 120,
                            child: Column(
                              children: [
                                const Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.only(top:10.0,left: 8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Mes Animaux',
                                      style: TextStyle(
                                          fontFamily: 'RobotoMono',
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),

                                  ),
                                )),

                                Expanded(
                                    child: MyAnimals(
                                  item: widget.items,
                                )),
                              ],
                            ),
                          ),
                          Container(
                            height: 250,
                            child:  Column(
                              children: [
                                Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 20, left: 8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Animaux en Adoption',
                                          style: TextStyle(

                                              fontFamily: 'RobotoMono',
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    )),
                                Expanded(
                                  flex: 2,
                                  child: AnimalsOnAdoption(
                                      items:widget.items_adop),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 300,
                            child: Column(
                              children: [
                                const Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.only(top: 30, left: 8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Documentaire',
                                      style: TextStyle(
                                          fontFamily: 'RobotoMono',
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                )),
                                Expanded(
                                  child: SwipePage(),
                                  flex: 3,
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    // Center is a layout widget. It takes a single child and positions it
                    // in the middle of the parent.
                    children: [
                      FloatingMenuPanel(
                        panelState: PanelState.closed,
                        panelOpenOffset: 10,
                        borderWidth: 1,
                        iconSize: 30,
                        positionLeft: 300,
                        positionTop: 200,
                        dockOffset: 10,
                        panelIcon: Icons.pets_sharp,
                        contentColor: Color.fromARGB(255, 255, 255, 255),
                        backgroundColor:
                        Color(0xFFF7924A),
                        size: 50,
                        onPressed: (index) {
                          if (index == 0) {
                        Navigator.pushReplacement(context,MaterialPageRoute (
                          builder: (BuildContext context) =>  FormAnimal(),
                        ),) ;
                          }
                          if (index == 2) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Choisir l\'animal à mettre en adoption ' , style: TextStyle(fontSize: 15),),
                                  content: Container(
                                    width: 200,
                                    height: 40,
                                    child: Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: widget.items.length,
                                        itemBuilder: (BuildContext ctxt, int index) {
                                          // ignore: prefer_const_constructors
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: GestureDetector(
                                              onTap: ()async {
                                                FirebaseFirestore.instance
                                                    .collection('animal')
                                                    .where('imageurl', isEqualTo: widget.items[index])
                                                    .get()
                                                    .then((QuerySnapshot querySnapshot) {
                                                  querySnapshot.docs.forEach((doc) {
                                                    FirebaseFirestore.instance
                                                        .collection('animal')
                                                        .doc(doc.id)
                                                        .update({'est_adopte': true})
                                                        .then((value) => print("Mise à jour réussie"))
                                                        .catchError((error) => print("Erreur lors de la mise à jour: $error"));
                                                  });
                                                });

                                                List<String> l=await geturl_adop();

                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext context) =>
                                                            Menu(items: widget.items, name: widget.name,email: widget.email,items_adop: l,)));
                                              },
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(widget.items[index]),
                                                radius: 30.0, // rayon du cercle
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Annuler'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }

                          if(index==1){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Choisir l\'animal à supprimer ' , style: TextStyle(fontSize: 15),),
                                  content: Container(
                                    width: 200,
                                    height: 40,
                                    child: Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: widget.items.length,
                                        itemBuilder: (BuildContext ctxt, int index) {
                                          // ignore: prefer_const_constructors
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: GestureDetector(
                                              onTap: () async {


                                                FirebaseFirestore.instance
                                                    .collection('animal')
                                                    .where('imageurl', isEqualTo: widget.items[index])
                                                    .get()
                                                    .then((QuerySnapshot querySnapshot) {
                                                  querySnapshot.docs.forEach((doc) {
                                                    doc.reference.delete()
                                                        .then((value) async {
                                                      widget.items.removeAt(index);
                                                      List<String> l=await geturl_adop();

                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext context) =>
                                                                  Menu(items: widget.items, name: widget.name,email: widget.email,items_adop: l,)));

                                                    })
                                                        .catchError((error) {
                                                      print("Erreur lors de la suppression du document : $error");
                                                    });
                                                  });
                                                });

// Effectuer une requête pour récupérer les données correspondantes à votre condition
                                                 /* FirebaseFirestore.instance
                                                      .collection('animal')
                                                      .where('imageurl', isEqualTo: widget.items[index])
                                                      .get()

                                                      .then((QuerySnapshot querySnapshot) {
                                                    querySnapshot.docs[0].reference.delete();
                                                          //.then((value) => print("Mise à jour réussie"))
                                                          //.catchError((error) => print("Erreur lors de la mise à jour: $error"));

                                                  });*/


                                                },
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(widget.items[index]),
                                                radius: 30.0, // rayon du cercle
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Annuler'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        buttons: const [
                          Icons.add,
                          Icons.delete_forever,
                          Icons.publish_rounded
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
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


