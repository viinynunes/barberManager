import 'package:barbar_manager/modules/registration/domain/entities/user.dart';

class Establishment {
  final String id;
  final String name;
  final String description;
  final String imgUrl;

  final List<User> userList = [];

  Establishment(this.id, this.name, this.description, this.imgUrl);

  addUser(User user) => userList.add(user);

  removeUser(User user) => userList.remove(user);
}
