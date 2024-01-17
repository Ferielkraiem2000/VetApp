import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
class FlipCardd extends StatefulWidget {
  final String url;

  const FlipCardd({Key? key, required this.url}) : super(key: key);

  @override
  _FlipCarddState createState() => _FlipCarddState();
}

class _FlipCarddState extends State<FlipCardd> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      front: Container(child: Image.network(widget.url))
      ,
    back: StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('animal')
        .where('imageurl', isEqualTo: widget.url).snapshots(),


    builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
    if (!snapshot.hasData ||
    snapshot.data!.docs.isEmpty) {
    return Text("Chargement en cours...");
    }
    final messages = snapshot.data!.docs;
    final firstMessage = messages.first;
    final messagenom = firstMessage.get('nom');
  
    final messagesexe = firstMessage.get('sexe');
    final messageage = firstMessage.get('age');

    return Container(
      color: Color.fromARGB(255, 188, 185, 173),
      child: Column(

        children: [Center(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Nom: '+messagenom,style: TextStyle(fontSize: 15,  ),),
        )),
          Center(child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text('Sexe: '+messagesexe),
          )),
          Center(child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text('Age: '+messageage),
          ))
]    ),
    );
    },
    ),

    );
  }
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





