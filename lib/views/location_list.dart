import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/services/location_service.dart';

import '../services/habitation_service.dart';
import 'BottomNavigationBarWidget.dart';
import 'package:location/models/location.dart';

class LocationList extends StatefulWidget {
  final LocationService locationService = LocationService();
  final HabitationService habitationService = HabitationService();
  late List<Location> _locations;
  static const routeName = '/location-list';

  LocationList({Key? key}) : super(key: key) {
    _locations = locationService.getLocations();
  }

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {

  //get all the locations
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes locations'),
      ),
      body: ListView.builder(
      itemCount: widget._locations.length,
      itemBuilder: (context, index) =>
          _buildRow(widget._locations[index], context),
      itemExtent: 150,
    ),
      bottomNavigationBar: const BottomNavigationBarWidget(2),
    );
  }

  Widget _buildRow(Location location, BuildContext context){
    return Card(
      elevation: 5,
      child: Column(
        children: [
          _nameAndPrice(location),
          _dates(location.dateDebut, location.dateFin),
          _facture(location.facture)
        ]
      ),
    );
  }

  Widget _nameAndPrice(Location location){
    var format = NumberFormat("### €");
    var habitation = widget.habitationService.getHabitationById(location.id);
    return Row(
      children: [
        // Right
        Expanded(
          flex: 3,
          child: ListTile(
            title: Text(habitation.libelle),
            subtitle: Text(habitation.adresse),
          ),
        ),
        // Left
        Expanded(
          flex: 1,
          child: Text(
            format.format(500.00),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              fontSize: 22,
            ),
          ),
        ),
      ],
    );

  }

  Widget _dates(dateDebut, dateFin){
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(DateFormat.yMMMd().format(dateDebut)),
          const CircleAvatar(child: Icon(Icons.arrow_circle_right)),
          Text(DateFormat.yMMMd().format(dateFin))
        ],
    );
  }

  Widget _facture(facture){
    return Text("Ma facture");
  }
}
