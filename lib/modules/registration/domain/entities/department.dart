import 'package:barbar_manager/modules/registration/domain/entities/item.dart';

class Department {
  String id;
  String name;
  String description;
  bool enabled;

  List<Item> itemList = [];

  Department(this.id, this.name, this.description, this.enabled);

  addItem(Item item) => itemList.add(item);

  removeItem(Item item) => itemList.remove(item);
}
