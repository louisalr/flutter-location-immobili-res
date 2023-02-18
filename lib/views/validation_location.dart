import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BottomNavigationBarWidget.dart';

class ValidationLocation extends StatefulWidget {
  const ValidationLocation({Key? key}) : super(key: key);
  static const routeName = '/validation-location';

  @override
  State<ValidationLocation> createState() => _ValidationLocationState();
}

class _ValidationLocationState extends State<ValidationLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Validation Location')),
      body: Text('Confirmation ok'),
      bottomNavigationBar: BottomNavigationBarWidget(0),
    );
  }
}
