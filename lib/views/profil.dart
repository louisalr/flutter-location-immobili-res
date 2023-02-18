import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BottomNavigationBarWidget.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  static const routeName = '/profil';

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Container(
        child: const Text('Profil à faire'),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(3),
    );
  }
}
