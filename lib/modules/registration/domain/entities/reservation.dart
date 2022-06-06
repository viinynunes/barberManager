import 'package:barbar_manager/modules/registration/domain/entities/department.dart';
import 'package:barbar_manager/modules/registration/domain/entities/item.dart';

class Reservation extends Item {
  final DateTime reservationDate;

  Reservation(
      String id,
      String name,
      String description,
      double price,
      String imgUrl,
      DateTime registrationDate,
      bool enabled,
      Department department,
      this.reservationDate)
      : super(id, name, description, price, imgUrl, registrationDate, enabled,
            department);
}
