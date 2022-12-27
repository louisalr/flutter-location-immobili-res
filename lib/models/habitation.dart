import 'package:location/models/typehabitat.dart';

class Habitation {
  int id;
  TypeHabitat typeHabitat;
  String image;
  String libelle;
  String adresse;
  int chambres;
  int nbpersonnes;
  int superficie;
  double prixmois;

  Habitation(this.id, this.typeHabitat, this.image, this.libelle, this.adresse,
      this.chambres, this.nbpersonnes, this.superficie, this.prixmois);
}