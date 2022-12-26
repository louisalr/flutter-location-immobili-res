import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/models/habitation.dart';
import 'package:location/models/typehabitat.dart';
import 'package:location/share/location_style.dart';
import 'package:location/share/locaton_text_style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Locations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({Key? key, required this.title}) : super(key: key);

  var _typehabitats = [TypeHabitat(1, "Maison"), TypeHabitat(2, "Appartement")];
  var _habitations = [
    Habitation(1, "maison.png", "Maison méditerranéenne",
        "12 Rue du Coq qui chante", 3, 92, 600),
    Habitation(2, "appartement.png", "Appartement neuf", "Rue de la soif", 1,
        50, 555),
    Habitation(3, "appartement.png", "Appartement 1", "Rue 1", 1, 51, 401),
    Habitation(4, "appartement.png", "Appartement 2", "Rue 2", 1, 52, 402),
    Habitation(5, "maison.png", "Maison 1", "Rue M1", 3, 101, 701),
    Habitation(6, "maison.png", "Maison 2", "Rue M2", 3, 102, 702),
  ];


  //to set the icon accordingly of the place type
  _buildHabitat(TypeHabitat typeHabitat){
    var icon = Icons.house;
    switch(typeHabitat.id){
      case 2:
        icon = Icons.apartment;
        break;
      default:
        icon = Icons.home;
    }

    return Expanded(
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: LocationStyle.backgroundColorPurple,
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              SizedBox(width: 5),
              Text(
                typeHabitat.libelle,
                style: LocationTextStyle.regularWhiteTextStyle,
              )
            ],
          )
        )
    );
  }


  //returns type_habitats declared : maison, appartement
  _buildTypeHabitat(){
    return Container(
      height: 100,
      child: Row(
        // centered and spaced correctly
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_typehabitats.length, (index) => _buildHabitat(
          _typehabitats[index])
        ),
      )
    );
  }

  _buildRow(Habitation habitation, BuildContext context){
    var format = NumberFormat("### €");

    return Container(
      width: 240,
      margin: EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              'assets/images/locations/${habitation.image}',
              fit: BoxFit.fitWidth,
            ),
          ),
          Text(
            habitation.libelle,
            style: LocationTextStyle.regularTextStyle,
          ),
          Row(
            children: [
              Icon(Icons.location_on_outlined),
              Text(
                habitation.adresse,
                style: LocationTextStyle.regularTextStyle,
              ),
            ],
          ),
          Text(
            format.format(habitation.prixmois),
            style: LocationTextStyle.boldTextStyle,
          ),
        ],
      )
    );
  }

  _buildDerniereLocation(BuildContext context){
    return Container(
      height: 240,
      child: ListView.builder(
          itemCount: _habitations.length,
          itemExtent: 220, //height of each element
          itemBuilder: (context, index) =>
            _buildRow(_habitations[index], context),
          scrollDirection: Axis.horizontal
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            _buildTypeHabitat(),
            SizedBox(height: 20),
            _buildDerniereLocation(context),
          ],
        )
      ),
    );
  }
}
