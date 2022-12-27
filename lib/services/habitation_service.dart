import 'package:location/models/typehabitat.dart';

import '../models/habitation.dart';

class HabitationService{
  var _typehabitats = [TypeHabitat(1, "Maison"), TypeHabitat(2, "Appartement")];

  var _habitations = List.generate(30, (index) {
    bool maison = index%3==0;
    return Habitation(
      index,
      maison ? TypeHabitat(1, "Maison") : TypeHabitat(2, "Appartement"),
      maison ? "maison.png" : "appartement.png",
      "${maison ? 'Maison' : 'Appartement'} ${index}", "Rue ${index}",
      2 + index%3, 2 + index%2,
        (maison ? 100 :50) + index,
        ((maison ? 600 : 400) + index).toDouble()
    );
  });

  List<TypeHabitat> getTypeHabitats(){
    return _typehabitats;
  }

  List<Habitation> getHabitationsTop10(){
    return _habitations
        .where((element) => element.id%2 == 1)
        .take(10)
        .toList();
  }

  List<Habitation> getMaisons(){
    return _getHabitations(isHouse: true);
  }

  List<Habitation> getAppartements(){
    return _getHabitations(isHouse: false);
  }

  List<Habitation> _getHabitations({bool isHouse = true}){
    return _habitations
        .where((element) => element.typeHabitat.id == (isHouse ? 1 : 2))
        .toList();
  }
}