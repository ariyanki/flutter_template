import 'package:flutter_test/flutter_test.dart';
import 'package:mantra_mobile/app/network/endpoint.dart';
import 'package:mantra_mobile/flavors/flavors.dart';

void main() {
  FlavorConfigs.appFlavor;
  group('Endpoints', () {
    test('DEV', () {
      FlavorConfigs.appFlavor = Flavor.DEV;
      expect(FlavorConfigs.isDEV, true);
      expect(FlavorConfigs.isUAT, false);
      expect(FlavorConfigs.isPROD, false);
      Endpoints(Flavor.DEV);
    });
    test('UAT', () {
      FlavorConfigs.appFlavor = Flavor.UAT;
      expect(FlavorConfigs.isUAT, true);
      expect(FlavorConfigs.isDEV, false);
      expect(FlavorConfigs.isPROD, false);
      Endpoints(Flavor.UAT);
    });
     test('PROD', () {
      FlavorConfigs.appFlavor = Flavor.PROD;
      expect(FlavorConfigs.isPROD, true);
      expect(FlavorConfigs.isDEV, false);
      expect(FlavorConfigs.isUAT, false);
      Endpoints(Flavor.PROD);
    });
  });
}
