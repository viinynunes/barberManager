import 'package:barbar_manager/modules/registration/domain/entities/establishment.dart';

class User {
  final String id;
  final String fullName;
  final String email;
  final String password;
  final bool enabled;

  final Establishment establishment;

  User(this.id, this.fullName, this.email, this.password, this.establishment,
      this.enabled);
}
