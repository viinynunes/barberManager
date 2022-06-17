import 'package:barbar_manager/modules/registration/domain/entities/establishment.dart';

class User {
  String id;
  String fullName;
  String email;
  String password;
  bool enabled;

  Establishment establishment;

  User(this.id, this.fullName, this.email, this.password, this.establishment,
      this.enabled);
}
