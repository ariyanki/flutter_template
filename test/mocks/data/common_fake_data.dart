
import 'package:flutter_template/ports/clients/dto/common/message.dart';

class CommonFakeData {
  static const successMessage = Message(
    isSuccess: true,
    transactionId: "31b098ae-9a01-4597-886a-54b2f3c7e862",
    timestamp: 1641882967983,
    detail: "All passed",
    description: "",
  );
  static const failureMessage = Message(
    isSuccess: false,
    transactionId: "31b098ae-9a01-4597-886a-54b2f3c7e862",
    timestamp: 1641882967983,
    detail: "All passed",
    description: "",
  );
  static const permissions = [
    {
      "actions": ["View", "Create"],
      "resource": "transaction"
    }
  ];
}
