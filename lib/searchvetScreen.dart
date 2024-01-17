import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Menu.dart';


class SearchVet extends StatefulWidget {
  const SearchVet({super.key});
  @override
  State<SearchVet> createState() => _SearchVetState();
}

class _SearchVetState extends State<SearchVet>
    with SingleTickerProviderStateMixin {
  String text = 'VETERINAIRE\n          A PROXIMITE';
  final List<Color?> colors = [
    Colors.orange[200],
    Colors.orange[300],
    Colors.orange[400],
    Colors.orange[500],
    Colors.orange[600],
    Colors.orange[700],
    Colors.orange[800],
  ];

  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  String? selectedGovernorate;
  String? selectedRegion;
  List<String> Governorates = [
    "Tunis",
    "Ben Arous",
    "Ariana",
    "Bizerte",
    "Nabeul",
    "Kairouan",
    "Beja",
    "Siliana",
    "Sidi Bouzid",
    "Kef",
    "Gafsa",
    "Sousse",
    "Monastir",
    "Sfax",
    "Médenine",
    "Gabes"
  ];
  Map<String, List<String>> RegionsByGovernorate = {
    "Tunis": [
      "Grand Tunis",
      "La Marsa",
      "Carthage Byrsa",
      "Les Berges du Lac",
      "Le Bardo"
    ],
    "Ben Arous": ["El Mourouj 1", "Fouchana"],
    "Ariana": ["Ariana", "Mnihla", "Ennasr", "El Menzah 6"],
    "Bizerte": ["Bizerte", "Sidi Salem", "Ras Jebel"],
    "Nabeul": ["Nabeul", "Soliman", "Menzel Temime", "Grombalia"],
    "Kairouan": ["El Batan", "Sbikha"],
    "Beja": ["Beja"],
    "Siliana": ["Makthar", "Siliana"],
    "Sidi Bouzid": ["Sidi Bouzid"],
    "Kef": ["Le Kef"],
    "Gafsa": ["Gafsa"],
    "Sousse": ["Sahloul"],
    "Monastir": ["Jemmel", "Sayada"],
    "Sfax": ["Sakiet Eddaier", "Sidi Abbes"],
    "Médenine": ["Médenine Centre", "Djerba"],
    "Gabes": ["El Hamma"]
  };

//map

  Map<String, LatLng> regionCoords = {
    "Grand Tunis": LatLng(36.83613729110853, 10.173024627638675),
    'Mnihla': LatLng(36.85556500942655, 10.11720110851024),
    "Ennasr": LatLng(36.865679466895465, 10.16409802556685),
    "Les Berges du Lac": LatLng(36.845134571090085, 10.271079569312903),
    "El Mourouj 1": LatLng(36.7389645324402, 10.208727905478048),
    "Sahloul": LatLng(35.835677170073026, 10.600147432345148),
    "Sakiet Eddaier": LatLng(34.809471175285275, 10.787483361418197),
    "Sidi Salem": LatLng(37.28759568273884, 9.871025786647866),
    "Médenine Centre": LatLng(333.35236635116357, 10.493822539791317),
    "Beja": LatLng(36.71803778264981, 9.194079628375185),
    "Makthar": LatLng(36.84710057793559, 11.092014649278324),
    "Siliana": LatLng(36.078583116878605, 9.367957712987643),
    "Bizerte": LatLng(37.267986927615794, 9.867745269396638),
    "La Marsa": LatLng(36.88415015331476, 10.330363261908282),
    "Nabeul": LatLng(36.45741775706902, 10.73216187704027),
    "El Batan": LatLng(35.71311787092796, 10.000483991248924),
    "Ariana": LatLng(36.85457392739724, 10.18621994673115),
    "Ras Jebel": LatLng(37.217292861074604, 10.129974050071716),
    "Jemmel": LatLng(35.62236268282746, 10.760967584590361),
    "Sidi Bouzid": LatLng(35.05109001860143, 9.492148263464035),
    "Djerba": LatLng(33.86863293068535, 10.85113333718184),
    "El Hamma": LatLng(33.9720637028972, 10.04444189300176),
    "Carthage Byrsa": LatLng(36.84909959994538, 10.322242838596836),
    "La Marsa": LatLng(36.88415015331476, 10.330363261908282),
    "Grombalia": LatLng(36.59663225507202, 10.498092554379355),
    "Le Bardo": LatLng(36.81216981820436, 10.141420275977012),
    "Sbikha": LatLng(35.679547383325804, 10.085457176664669),
    "Soliman": LatLng(36.70730747858727, 10.421046105731609),
    "El Menzah 6": LatLng(36.844598982633805, 10.166528623257339),
    "Sayada": LatLng(35.77947216036918, 10.825242374926802),
    "Fouchana": LatLng(36.70952485042659, 10.176546393069831),
    "Menzel Temime": LatLng(36.7907758397109, 10.989192034874346),
    "Sidi Abbes": LatLng(34.76033999581263, 10.692238182712067),
    "Le Kef": LatLng(36.15586203391974, 8.698231006902427),
    "Gafsa": LatLng(34.434235909465336, 8.781118512940054),

  };
  Map<String, String> infosvet = {
    "Grand Tunis": " Dr Hanen Driss \n 71 287 930 \n Tunis,GrandTunis",
    "Mnihla": "Dr Marouan Zayati \n 71 556 865 \n Ariana,Mnihla",
    "Ennasr": "Dr Wajih Kaddour  \n 71 811 144 \n Ariana,Ennasr ",
    "Les Berges du Lac": "Dr Olfa Kilani  \n 70 290 334 \n Tunis,Les Berges du Lac  ",
    "El Mourouj 1": "Dr Maroua Ghali \n 23 367 002 \n BenArous,El Mourouj 1",
    "Sahloul": "Dr Hajer Achech \n 73 820 812 \n Sousse,Sahloul",
    "Sakiet Eddaier": "Dr Mohammed Ghorbel  \n 31 500 548 \n Sfax,Sakiet Eddaier",
    "Sidi Salem": "Dr Ons Blanco \n  29 409 646  \n Bizerte,Sidi Salem",
    "Médenine Centre": "Dr Emna Temri \n 97 335 354 \n  Médenine,Médenine",
    "Beja": "Dr Nahla Kouki \n 96 041 072 \n Beja,Beja",
    "Makthar": "Dr Ben slimen Mohammed \n 98 286 944 \n Makther ,Siliana",
    "Siliana": "Dr Maher Hasni \n 97 372 436 \n Siliana, Siliana",
    "Bizerte": "Dr Chetouane Nourane \n 93 171 230 \n Bizerte,Bizerte",
    "La Marsa": "Dr Benmloukazakaria \n 71 892 222 \n Tunis,La Marsa",
    "Nabeul": "Dr Mohamed Ali Kammoun \n 21 162 524 \n Nabeul,Nabeul",
    "El Batan": "Dr Chaima Mahdouani \n 77 320 099  \n Kairouan,El Batan ",
    "Ariana": "Dr Sarra Missaoui  \n 71 713 011  \n Ariana,Ariana",
    "Ras Jebel": "Dr Walid Sahli  \n 98 959 922 \n Bizerte ,Ras Jebel",
    "Jemmel": "Dr Zeramdini Bechir \n73 487 390 \n Monastir , Jemmel  ",
    "Sidi Bouzid": "Dr Gharbi Tlili \n 76 633 782 \n Sidi Bouzid , Sidi Bouzid   ",
    "Djerba": "Dr Chaouch mourad \n 22 806 828  \n Médenine,Djerba Houmet Essouk",
    "El Hamma": "Dr Bouzouaia asma \n 71 740 664 \n Gabes, El Hamma ",
    "Carthage Byrsa": " Dr Kharmachi sameh \n 71 276 775  \n Tunis, Carthage Byrsa ",
    "La Marsa": "Dr Ben mlouka Zakaria \n 71 892 222 \n Tunis, La Marsa  ",
    "Grombalia": "Dr Ben Romdhan Habib \n 72 255 941  \n Nabeul ,Grombalia  ",
    "Le Bardo": "Dr Seifeddine Issaoui \n 23 423 765 \n Tunis ,Le Bardo",
    "Sbikha": "Dr Zarai Adel \n 77 365 815  \n Karirouan,Sbikha",
    "Soliman": "Dr Sghayer Abdelmajid  \n 72 392 854 \n Nabeul ,Soliman ",
    "El Menzah 6": "clinique vétérinaire \n 71 754 013 \n Ariana ,El Menzah 6",
    "Sayada": "Dr  Ktari Med Yassine \n 95 778 775 \n Monastir ,Sayada  ",
    "Fouchana": "Dr Ben mustapha Rachid \n 71 401 494 \n Ben arous, Fouchana ",
    "Menzel Temime": "Dr Ben hamda Abdelatif \n 72 344 765  \n Nabeul, Menzel Temime   ",
    "Sidi Abbes": "Dr Belhaj Habib \n 74 426 015 \n Sfax ,Sidi Abbes",
    "Le Kef": "Dr Hassan Balti  \n 98 227 847 \n Le Kef, Le Kef",
    "Gafsa": "Dr Boujezza rached\n99 852 863\nGafsa, Gafsa "
  };
  late GoogleMapController _mapController;
  final _scrollController = ScrollController();
  bool _showInfoWindow = false;
  late List<String> souschaine =infosvet[selectedRegion]!.split('\n');


  void onSearchPressed() {
    if (selectedRegion != null) {
      LatLng coords = regionCoords[selectedRegion]!;
      if (coords != null) {
        _mapController.animateCamera(CameraUpdate.newLatLng(coords));
      }
    }
  }


  //changement de couleur bouton
  Color _buttonColor = Colors.white;
  Color _buttonTextColor = const Color(0xFFF7924A);

  void _changeButtonColor() {
    setState(() {
      _buttonColor = const Color(0xFFF7924A);
      _buttonTextColor = Colors.white;
    });
  }

//animation local
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )
      ..repeat(reverse: true);
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 0.2),
    ).animate(_controller);
    //places = GoogleMapsPlaces(apiKey: "votre clé d'API");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //validation de formulaire

  void _validateForm() {
    if (selectedGovernorate == null || selectedRegion == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Veuillez sélectionner une option dans les deux listes déroulantes!'),
        ),
      );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            AppBar(leading: IconButton(onPressed: () async {
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
                icon:Icon(Icons.arrow_back,color: Colors.black)),backgroundColor: Colors.transparent,elevation: 0.0,),
            Container(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Transform.translate(
                      offset: Offset(-30, 120),
                      child: RichText(
                        text: TextSpan(
                          children: List.generate(
                            text.length,
                                (index) =>
                                TextSpan(
                                  text: text[index],
                                  style: TextStyle(
                                    color: colors[index % colors.length],
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(120, 30),
                      child: SlideTransition(
                        position: _offsetAnimation,
                        child: Image.asset("assets/images/local.png",
                            width: 120, height: 120),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xFFF7924A),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFF7924A),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            focusColor: Color(0xFFF7924A),
                          ),
                          dropdownColor: Color(0xFFF7924A),
                          icon: Icon(Icons.arrow_drop_down),
                          iconEnabledColor: Colors.white,
                          iconSize: 36,
                          isExpanded: true,
                          value: selectedGovernorate,
                          onChanged: (newValue) {
                            setState(() {
                              selectedGovernorate = newValue;
                            });
                          },
                          items: Governorates.map((g) {
                            return DropdownMenuItem(
                              value: g,
                              child: Text(
                                g,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            "Sélectionner un gouvernorat",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xFFF7924A),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFF7924A),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            focusColor: Color(0xFFF7924A),
                          ),
                          dropdownColor: Color(0xFFF7924A),
                          icon: Icon(Icons.arrow_drop_down),
                          iconEnabledColor: Colors.white,
                          iconSize: 36,
                          value: selectedRegion,
                          onChanged: (value) {
                            setState(() {
                              selectedRegion = value;
                            });
                          },
                          items: RegionsByGovernorate[selectedGovernorate]
                              ?.map((r) {
                            return DropdownMenuItem(
                              value: r,
                              child: Text(
                                r,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            "Sélectionner une région",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(85),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            _changeButtonColor();
                            _validateForm();

                            onSearchPressed;

                            if (selectedRegion != null &&
                                selectedGovernorate != null) {
                              _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            }
                          },
                          child: SingleChildScrollView(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.search),
                                const SizedBox(width: 10),
                                const Text('Rechercher'),
                              ],
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _buttonColor,
                            foregroundColor: _buttonTextColor,
                            fixedSize: const Size(200, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 177),

                    Container(
                      width: double.infinity,
                      height: 695,
                      child: GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(34.0, 9.0), zoom: 6.0),
                          onMapCreated: (controller) {
                            setState(() {
                              _mapController = controller;
                            });
                          },
                          markers: selectedRegion != null
                              ? {
                            Marker(
                              markerId: MarkerId(selectedRegion!),
                              position: regionCoords[selectedRegion]!,

                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5),
                                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)
                                          ,side:BorderSide(color:Colors.orange,width: 2.0)),

                                      title: Text(''),
                                      content:Container(
                                        height:180,
                                        child:   Column(
                                          children: [
                                            Icon(Icons.person), Text(souschaine[0]),
                                            SizedBox(height:20),
                                            Icon(Icons.phone),Text(souschaine[1]),
                                            SizedBox(height:20),
                                            Icon(Icons.place),Text(souschaine[2]),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text('OK',style:TextStyle(color: Colors.orange)),
                                        ),
                                      ],
                                    );
                                  },
                                );

                              },
                            ),



                          }
                              : {}

                      ),
                    ),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

