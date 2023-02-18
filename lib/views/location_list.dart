import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/services/location_service.dart';

import '../services/habitation_service.dart';
import 'BottomNavigationBarWidget.dart';
import 'package:location/models/location.dart';

class LocationList extends StatefulWidget {
  final HabitationService habitationService = HabitationService();
  static const routeName = '/location-list';

  LocationList({Key? key}) : super(key: key);

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  final LocationService service = LocationService();
  late Future<List<Location>> _locations;

  @override
  void initState() {
    super.initState();
    _locations = service.getLocations();
  }

  //get all the locations
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes locations'),
      ),
      body: Center(
        child: FutureBuilder(builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) =>
                    _buildRow(snapshot.data![index], context),
                itemExtent: 150,
              );
          }
          else if(snapshot.hasError){
            return Text('Une erreur est survenue lors du chargement des données');
          }
          else{
            return const SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              );
          }
        }, future: _locations),
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
