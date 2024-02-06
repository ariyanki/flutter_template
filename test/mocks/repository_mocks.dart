import 'package:flutter_template/ports/clients/i_auth_client.dart';
import 'package:flutter_template/ports/repository/dto/user_credentials.dart';
import 'package:flutter_template/ports/repository/i_user_accounts_repository.dart';
import 'package:flutter_template/ports/repository/i_user_credential_repository.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mocktail/mocktail.dart';

class FakeUserCredentials extends Fake implements UserCredentials {}

class MockUserCredentialsRepository extends Mock implements IUserCredentialsRepository {}

class MockUserAccountsRepository extends Mock implements IUserAccountsRepository {}
