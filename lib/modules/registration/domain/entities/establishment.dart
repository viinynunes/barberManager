import 'package:barbar_manager/modules/registration/domain/entities/user.dart';

class Establishment {
  final String id;
  final String name;
  final String email;
  final String description;
  final String imgUrl;
  final DateTime? openTime;
  final DateTime? closeTime;

  final List<User> _userList = [];

  Establishment(this.id, this.name, this.email, this.description, this.imgUrl, this.openTime, this.closeTime);

  addUser(User user) => _userList.add(user);

  removeUser(User user) => _userList.remove(user);
}
