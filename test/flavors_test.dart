import 'package:flutter_template/flavors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  FlavorConfigs.appFlavor;
  group('Test FlavorConfigs IAM', () {
    test('DEV', () {
      FlavorConfigs.appFlavor = Flavor.DEV;
      expect(FlavorConfigs.isDEV, true);
      expect(FlavorConfigs.isUAT, false);
      expect(FlavorConfigs.isPROD, false);
      expect(FlavorConfigs.baseURLIAM, FlavorConfigs.DEV_URL_IAM);
    });
    test('UAT', () {
      FlavorConfigs.appFlavor = Flavor.UAT;
      expect(FlavorConfigs.isDEV, false);
      expect(FlavorConfigs.isUAT, true);
      expect(FlavorConfigs.isPROD, false);
      expect(FlavorConfigs.baseURLIAM, FlavorConfigs.UAT_URL_IAM);
    });
    test('PROD', () {
      FlavorConfigs.appFlavor = Flavor.PROD;
      expect(FlavorConfigs.isDEV, false);
      expect(FlavorConfigs.isUAT, false);
      expect(FlavorConfigs.isPROD, true);
      expect(FlavorConfigs.baseURLIAM, FlavorConfigs.PRODUCTION_URL_IAM);
    });
    test('App Flavor DEV dev', () {
      FlavorConfigs.appFlavor = Flavor.DEV;
      expect(FlavorConfigs.name, 'DEV');
    });
    test('App Flavor UAT', () {
      FlavorConfigs.appFlavor = Flavor.UAT;
      expect(FlavorConfigs.name, 'UAT');
    });
    test('App Flavor PROD', () {
      FlavorConfigs.appFlavor = Flavor.PROD;
      expect(FlavorConfigs.name, 'PROD');
    });
    test('APP TITLE DEV', () {
      FlavorConfigs.appFlavor = Flavor.DEV;
      expect(FlavorConfigs.title, '${FlavorConfigs.appName} DEV');
    });
    test('APP TITLE UAT', () {
      FlavorConfigs.appFlavor = Flavor.UAT;
      expect(FlavorConfigs.title, '${FlavorConfigs.appName} UAT');
    });
    test('APP NAME PROD', () {
      FlavorConfigs.appFlavor = Flavor.PROD;
      expect(FlavorConfigs.title, FlavorConfigs.appName);
    });
  });
}
