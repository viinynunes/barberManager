import 'package:barbar_manager/modules/registration/domain/entities/item.dart';

class Department {
  final String id;
  final String name;
  final String description;
  final bool enabled;

  final List<Item> _itemList = [];

  Department(this.id, this.name, this.description, this.enabled);

  addItem(Item item) => _itemList.add(item);

  removeItem(Item item) => _itemList.remove(item);
}
