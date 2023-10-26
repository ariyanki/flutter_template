import 'package:flutter/material.dart';
import 'package:flutter_template/app/base/base_view.dart';
import 'package:flutter_template/app/pages/landing/landing_controller.dart';

class LandingScreen extends BaseView<LandingController> {
  const LandingScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddFormView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              const Text(
                'AddFormView is working',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
