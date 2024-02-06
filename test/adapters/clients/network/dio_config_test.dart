import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:mantra_mobile/app/core/enum/product_type.dart';
import 'package:mantra_mobile/app/core/model/user_credentials.dart';
import 'package:mantra_mobile/app/data/repository/user_credentials_repository.dart';
import 'package:mantra_mobile/app/network/dio_config.dart';
import 'package:mocktail/mocktail.dart';

import '../data/local/_mocks.dart';
import '../data/remote/_mocks.dart';
import '../modules/_mocks.dart';

void main() {
  final mockUserCredentialsRepository = MockUserCredentialsRepository();
  const accessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9';

  setUpAll(() {
    registerFallbackValue(FakeUserCredentials());
    Get.put(Logger());
    Get.put<UserCredentialsRepository>(mockUserCredentialsRepository);
    Get.put<DioConfigure>(MockDioConfigure());
    when(() => mockUserCredentialsRepository.getCredentials()).thenReturn(
      const UserCredentials(isFirstLaunch: false, accessToken: accessToken),
    );
  });

  group('MyGiro test', () {
    late DioConfigure dioConfigure;
    late ProductType productType;
    setUp(() {
      dioConfigure = DioConfigure();
      productType = ProductType.MyGiro;
    });
    test('removeOtp', () {
      dioConfigure.removeOtp(productType);
      expect(
        dioConfigure.dioGiro.options.headers['X-Mantra-OTP'],
        null,
      );
    });
    test('addOtp', () {
      dioConfigure.addOtp('123456', productType);
      expect(
        dioConfigure.dioGiro.options.headers['X-Mantra-OTP'] == '123456',
        true,
      );
    });
    test('updateToken', () {
      expect(
        dioConfigure.dioGiro.options.headers['Authorization'] ==
            'Bearer $accessToken',
        true,
      );
    });
  });

  group('VCC test', () {
    late DioConfigure dioConfigure;
    late ProductType productType;
    setUp(() {
      dioConfigure = DioConfigure();
      productType = ProductType.VCC;
    });
    test('removeOtp', () {
      dioConfigure.removeOtp(productType);
      expect(
        dioConfigure.dioVcc.options.headers['X-Mantra-OTP'],
        null,
      );
    });
    test('addOtp', () {
      dioConfigure.addOtp('123456', productType);
      expect(
        dioConfigure.dioVcc.options.headers['X-Mantra-OTP'] == '123456',
        true,
      );
    });
    test('updateToken', () {
      expect(
        dioConfigure.dioVcc.options.headers['Authorization'] ==
            'Bearer $accessToken',
        true,
      );
    });
  });

  group('Prepaid test', () {
    late DioConfigure dioConfigure;
    late ProductType productType;
    setUp(() {
      dioConfigure = DioConfigure();
      productType = ProductType.Prepaid;
    });
    test('removeOtp', () {
      dioConfigure.removeOtp(productType);
      expect(
        dioConfigure.dioPrepaid.options.headers['X-Mantra-OTP'],
        null,
      );
    });
    test('addOtp', () {
      dioConfigure.addOtp('123456', productType);
      expect(
        dioConfigure.dioPrepaid.options.headers['X-Mantra-OTP'] == '123456',
        true,
      );
    });
    test('updateToken', () {
      expect(
        dioConfigure.dioPrepaid.options.headers['Authorization'] ==
            'Bearer $accessToken',
        true,
      );
    });
  });
}
