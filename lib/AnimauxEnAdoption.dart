import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'Flip.dart';
import 'package:url_launcher/url_launcher.dart';
class AnimalsOnAdoption extends StatefulWidget {

  const AnimalsOnAdoption({super.key, required this.items});
  final List<String> items;



  @override
  State<AnimalsOnAdoption> createState() => _AnimalsOnAdoptionState();
}

class _AnimalsOnAdoptionState extends State<AnimalsOnAdoption> {
 final Liste=[];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 0),
      // implement GridView.builder
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 240,
              childAspectRatio: 1.2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 10),
          itemCount: widget.items.length,
          itemBuilder: (BuildContext ctx, index)  {
             get_info(widget.items[index]).then((value) => Liste.add(value));

            return Stack(children: [ FlipCardd(url: widget.items[index])
             /* FlipCard(
                direction: FlipDirection.HORIZONTAL,
                side: CardSide.FRONT,
                speed: 1000,
                onFlip: (){},
                onFlipDone: (status)  {

                },
                front:Container(child: Image.network(widget.items[index])),
                back: Container(
                  width: 150,
                  height: 770,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 163, 190, 190),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          style: TextStyle(
                              fontWeight: FontWeight.w900, letterSpacing: 0.5),
                          Liste[0],
                          textAlign: TextAlign.center,
                        ),
                        Text (
                            get_info(widget.items[index]).toString(),
                          textDirection: TextDirection.ltr,
                        ),
                        Text(
                          'age:35',
                          textDirection: TextDirection.ltr,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Text(
                            'age:35',
                            textDirection: TextDirection.ltr,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )*/,
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton.icon(
                        style: const ButtonStyle(
                            backgroundColor:
                            MaterialStatePropertyAll(Color(0xFFF7924A))),
                        label: const Text("call"),
                        onPressed: () async {
    final snapshot = await FirebaseFirestore.instance
        .collection('animal')
        .where('imageurl', isEqualTo: widget.items[index])
        .get();

    if (snapshot.docs.isNotEmpty) {
    final userDoc = snapshot.docs.first;
    final email = userDoc.get('email');
    final snapshot1 = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: email)
        .get();
    if (snapshot1.docs.isNotEmpty) {
      final userDoc1 = snapshot1.docs.first;
      final tel = userDoc1.get('phone').toString();
      call(tel);
    }
    } else {
            throw Exception('Aucun utilisateur trouvé pour cet email.');
            }
                        },
                        icon: const Icon(Icons.call))),
              ),
            ]);
          }),
    );
  }
  Future <List<String>> get_info(url) async
  {    List<String> liste = [];
  final snapshot = await FirebaseFirestore.instance
      .collection('animal')
      .where('imageurl', isEqualTo: url)
      .get();

  if (snapshot.docs.isNotEmpty) {
    final userDoc = snapshot.docs.forEach((element) { final nom=element.get('nom');final sexe=element.get('sexe');final age=element.get('age');
    liste.add(nom);
    liste.add(sexe);
    liste.add(age);});
    //  final firstName = userDoc.get('imageurl');
    return liste;}
  return [''];
  }
}Future<void> call(String telephonenumber)async{
  final Uri launchuri = Uri(scheme: 'tel',path: telephonenumber);
  await launchUrl(launchuri);
}