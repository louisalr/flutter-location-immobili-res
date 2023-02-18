import 'package:location/models/habitations_data.dart';

import '../models/habitation.dart';
import '../models/typehabitat.dart';
import '../models/typehabitat_data.dart';

class HabitationService{
  var _typehabitats;
  var _habitations;

  HabitationService(){
    _typehabitats = TypeHabitatData.buildList();
    _habitations = HabitationsData.buildList();
  }

  /// Get all types of habitat
  List<TypeHabitat> getTypeHabitats() {
    return _typehabitats;
  }

  /// Get the top 10 habitations
  List<Habitation> getHabitationsTop10() {
    return _habitations
        .where((habitation) => habitation.id%2 == 1)
        .take(10)
        .toList();
  }

  /// Get all habitations of maison type
  List<Habitation> getMaisons() {
    return _getHabitations(isHouse: true);
  }

  /// Get all habitations of appartements type
  List<Habitation> getAppartements() {
    return _getHabitations(isHouse: false);
  }

  Habitation getHabitationById(int habitationId) {
    return _habitations
        .where((habitation) => habitation.id == habitationId)
        .first;
  }


  /// Get habitations depending on the type habitat (appartement, maison)
  List<Habitation> _getHabitations({bool isHouse = true})  {
    return _habitations
        .where((habitation) => habitation.typeHabitat.id == (isHouse ? 1 : 2))
        .toList();
  }
}