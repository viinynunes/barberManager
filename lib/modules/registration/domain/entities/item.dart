import 'package:barbar_manager/modules/registration/domain/entities/department.dart';

class Item {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imgUrl;

  final Department department;

  Item(this.id, this.name, this.description, this.price, this.imgUrl,
      this.department);
}
