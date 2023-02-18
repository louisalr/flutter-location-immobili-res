import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/share/location_style.dart';

import '../models/habitation.dart';
import 'BottomNavigationBarWidget.dart';

class ResaLocation extends StatefulWidget {
  final Habitation habitation;
  const ResaLocation({Key? key, required this.habitation}) : super(key: key);

  @override
  State<ResaLocation> createState() => _ResaLocationState();
}

class _ResaLocationState extends State<ResaLocation> {
  DateTime dateDebut = DateTime.now();
  DateTime dateFin = DateTime.now();
  String nbPersonnes = '1';
  //liste d'options payantes sélectionnables
  List<OptionPayanteCheck> optionPayanteChecks = [];
  //used for the dropdown selector
  List<int> nbPersonnesList = <int>[1, 2, 3, 4, 5, 6, 7, 8];

  int selectedNbPersonnes = 1; //by default the number of person is one

  bool areOptionsLoaded =
      false; //by default the options aren't loaded in optionPayantesChecks

  var format = NumberFormat("### €");

  double prixTotal = 0;

  Widget _buildDates() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
            onTap: dateTimeRangePicker, child: Text(DateFormat.yMMMd().format(dateDebut))),
        const CircleAvatar(child: Icon(Icons.arrow_circle_right)),
        GestureDetector(
            onTap: dateTimeRangePicker, child: Text(DateFormat.yMMMd().format(dateFin)))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _loadOptionsPayantes();

    return Scaffold(
      appBar: AppBar(title: const Text('Réservation')),
      body: ListView(
        padding: const EdgeInsets.all(4.0),
        children: [
          _buildResume(),
          _buildDates(),
          _buildNbPersonnes(),
          _buildOptionsPayantes(context),
          totalWidget(),
          _buildRentButton(),
        ],
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(0),
    );
  }

  _loadOptionsPayantes() {
    if (!areOptionsLoaded) {
      for (var option in widget.habitation.optionpayantes) {
        optionPayanteChecks.add(OptionPayanteCheck(
            option.id, option.libelle, false,
            description: option.description, prix: option.prix));
      }
      prixTotal = widget.habitation.prixmois;
      areOptionsLoaded = true;
    }
  }

  _buildResume() {
    return ListTile(
      leading: Icon(Icons.house),
      title: Text(widget.habitation.libelle),
      subtitle: Text(widget.habitation.adresse),
    );
  }

  _buildNbPersonnes() {
    return Row(
      children: [
        Text("Nombre de personnes"),
        const Padding(padding: EdgeInsets.only(left: 10.0)),
        DropdownButton(
          value: selectedNbPersonnes,
          items: nbPersonnesList.map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedNbPersonnes = value!;
            });
          },
        )
      ],
    );
  }

  _buildOptionsPayantes(context) {
    return Column(
      children: Iterable.generate(
        optionPayanteChecks.length,
        (i) => CheckboxListTile(
          title: Text(
              "${widget.habitation.optionpayantes[i].libelle} (${widget.habitation.optionpayantes[i].prix} €)"),
          subtitle: Text(optionPayanteChecks[i].description),
          value: optionPayanteChecks[i].checked,
          selected: optionPayanteChecks[i].checked,
          onChanged: (bool? value) {
            setState(() {
              optionPayanteChecks[i].checked = value!;
              //ternary operation to update the total price
              prixTotal = value
                  ? prixTotal += optionPayanteChecks[i].prix
                  : prixTotal -= optionPayanteChecks[i].prix;
            });
          },
        ),
      ).toList(),
    );
  }

  totalWidget() {
    //Replace avec un row
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue)),
      child: Center(child: Text(prixTotal.toString())),
    );
  }

  _buildRentButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: LocationStyle.backgroundColorPurple),
      onPressed: () {},
      child: const Text('Louer'),
    );
  }

  dateTimeRangePicker() async {
    DateTimeRange? datePicked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 2),
        initialDateRange: DateTimeRange(start: dateDebut, end: dateFin),
        cancelText: 'Annnuler',
        confirmText: 'Valider',
        locale: const Locale("fr", "FR"));
        if (datePicked != null){
          setState(() {
            dateDebut = datePicked.start;
            dateFin = datePicked.end;
          });
        }
  }
}
