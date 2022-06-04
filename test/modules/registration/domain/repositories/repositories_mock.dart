import 'package:barbar_manager/modules/registration/domain/repositories/client_repository.dart';
import 'package:barbar_manager/modules/registration/domain/repositories/department_repository.dart';
import 'package:barbar_manager/modules/registration/domain/repositories/establishment_repository.dart';
import 'package:barbar_manager/modules/registration/domain/repositories/item_repository.dart';
import 'package:barbar_manager/modules/registration/domain/repositories/user_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([ClientRepository, UserRepository, EstablishmentRepository, DepartmentRepository, ItemRepository])
main(){}