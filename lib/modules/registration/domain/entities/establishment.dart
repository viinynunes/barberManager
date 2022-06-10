import 'package:barbar_manager/modules/registration/domain/entities/user.dart';

class Establishment {
  String id;
  String name;
  String email;
  String description;
  String imgUrl;
  DateTime? openTime;
  DateTime? closeTime;

  List<User> userList = [];

  Establishment(this.id, this.name, this.email, this.description, this.imgUrl, this.openTime, this.closeTime);

  addUser(User user) => userList.add(user);

  removeUser(User user) => userList.remove(user);
}
