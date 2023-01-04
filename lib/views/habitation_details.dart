import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/models/habitation.dart';
import 'package:location/share/habitation_features_widget.dart';
import 'package:location/share/habitation_option.dart';
import 'package:location/share/location_style.dart';
import 'package:location/share/locaton_text_style.dart';

class HabitationDetails extends StatefulWidget {
  final Habitation _habitation;

  const HabitationDetails(this._habitation, {Key? key}) : super(key: key);

  @override
  State<HabitationDetails> createState() => _HabitationDetailsState();
}

class _HabitationDetailsState extends State<HabitationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._habitation.libelle),
      ),
      body: ListView(
        padding: EdgeInsets.all(4.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              'assets/images/locations/${widget._habitation.image}',
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(widget._habitation.adresse),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HabitationOption(Icons.group, "${widget._habitation.nbpersonnes} personnes"),
              HabitationOption(Icons.bed, "${widget._habitation.chambres} chambres"),
              HabitationOption(Icons.fit_screen, "${widget._habitation.superficie} m²")
            ],
          ),
          HabitationFeaturesWidget(widget._habitation),
          _buildDivider("Inclus"),
          _buildItems(),
          _buildDivider("Options"),
          _buildOptionsPayantes(),
          _buildRentButton(),
        ],
      ),
    );
  }

  _buildDivider(String text) {
    return Row(
        children: [
          const SizedBox(width: 8),
          Text(text, style: LocationTextStyle.subTitleBoldTextStyle),
          const Expanded(
              child: Divider(
                height: 36,
                indent: 10.0,
              )
          ),
        ]
    );
  }
  
  _buildItems(){
    var width = (MediaQuery.of(context).size.width / 2) - 15;

    return Wrap(
      spacing: 2.0,
      children: Iterable.generate(
        widget._habitation.options.length,
          (i) => Container(
            padding: EdgeInsets.only(left: 15.0),
            margin: EdgeInsets.all(2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget._habitation.options[i].libelle),
                Text(widget._habitation.options[i].description,
                style: LocationTextStyle.regularGreyTextStyle,)
              ],
            ),
          ),
      ).toList(),
    );
  }

  _buildOptionsPayantes(){
    var width = (MediaQuery.of(context).size.width / 2) - 15;

    return Wrap(
      spacing: 2.0,
      children: Iterable.generate(
        widget._habitation.options.length,
            (i) => Container(
          padding: EdgeInsets.only(left: 15.0),
          margin: EdgeInsets.all(2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget._habitation.optionpayantes[i].libelle),
              Text(widget._habitation.optionpayantes[i].prix.toString(),
                style: LocationTextStyle.regularGreyTextStyle,)
            ],
          ),
        ),
      ).toList(),
    );
  }

  _buildRentButton(){
    var format = NumberFormat("### €");

    return Container(
      decoration: BoxDecoration(
        color: LocationStyle.backgroundColorPurple,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              format.format(widget._habitation.prixmois),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {
                print('Louer habitation');
              },
              child: Text('Louer'),
            ),
          ),
        ],
      )
    );
  }
}
