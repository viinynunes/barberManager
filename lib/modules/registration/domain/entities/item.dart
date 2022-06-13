import 'package:barbar_manager/modules/registration/domain/entities/department.dart';
import 'package:barbar_manager/modules/registration/domain/entities/establishment.dart';

class Item {
  String id;
  String name;
  String description;
  double price;
  String imgUrl;
  DateTime registrationDate;
  bool enabled;

  Department department;
  Establishment establishment;

  Item(this.id, this.name, this.description, this.price, this.imgUrl, this.registrationDate,
      this.enabled, this.department, this.establishment);
}
