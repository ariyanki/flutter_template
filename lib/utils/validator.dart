import '../../../i18n/strings.g.dart';

enum ValidatorResult { empty, invalid, valid, other }

class ValidatorHelper {
  static const emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const emailDirectorRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const phoneNumberRegex = r"^8\w{7,14}$";
  static const numberRegex = r"^[0-9\-\+]{5,16}$";
  static const positiveNumber = r"[1-9][0-9]*";
  static const onlyAlphabet = r"^[a-zA-Z| ]+$";
  static const justAlphabetAndNumber = r'^[a-zA-Z0-9| ]+$';
  static const alphanumericCapital = r'^[A-Z0-9]+$';
  static const passwordRegex =
      r'(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|])(?=.*[0-9])(?=.*[a-z]).{8,15}$';
  static const otpRegex = r"^[0-9\-\+]{6}$";

  static ValidatorResult validateEmail(String? input) {
    if (input == null || input.trim().isEmpty) {
      return ValidatorResult.empty;
    }
    return RegExp(emailRegex).hasMatch(input)
        ? ValidatorResult.valid
        : ValidatorResult.invalid;
  }

  static ValidatorResult validateEmailDirector(String? input) {
    if (input == null || input.trim().isEmpty) {
      return ValidatorResult.empty;
    }
    return RegExp(emailDirectorRegex).hasMatch(input)
        ? ValidatorResult.valid
        : ValidatorResult.invalid;
  }

  static ValidatorResult validatePhoneNumber(String? input) {
    if (input == null || input.trim().isEmpty) {
      return ValidatorResult.empty;
    }
    return RegExp(phoneNumberRegex).hasMatch(input)
        ? ValidatorResult.valid
        : ValidatorResult.invalid;
  }

  static ValidatorResult validateNumber(String? input) {
    if (input == null || input.isEmpty) {
      return ValidatorResult.empty;
    }
    return RegExp(numberRegex).hasMatch(input)
        ? ValidatorResult.valid
        : ValidatorResult.invalid;
  }

  static ValidatorResult validateCurrency(String? input) {
    if (input == null || input.trim().isEmpty) {
      return ValidatorResult.empty;
    }
    if (input.contains('-') || input == '0') {
      return ValidatorResult.invalid;
    }
    return ValidatorResult.valid;
  }

  static ValidatorResult validatePassword(String? input,
      [int minLength = 8, int maxLength = 15]) {
    if (input == null || input.trim().isEmpty) {
      return ValidatorResult.empty;
    }
    return RegExp(passwordRegex).hasMatch(input)
        ? ValidatorResult.valid
        : ValidatorResult.invalid;
  }

  static ValidatorResult validateNewPassword(
      String? oldPassword, String? newPassword) {
    if (oldPassword == null ||
        oldPassword.trim().isEmpty ||
        newPassword == null ||
        newPassword.trim().isEmpty) {
      return ValidatorResult.empty;
    }
    if (!RegExp(passwordRegex).hasMatch(newPassword)) {
      return ValidatorResult.invalid;
    }
    if (oldPassword == newPassword) {
      return ValidatorResult.other;
    }
    return ValidatorResult.valid;
  }

  static ValidatorResult validateConfirmPassword(
      String? password, String? confirmPassword) {
    if (password == null ||
        password.trim().isEmpty ||
        confirmPassword == null ||
        confirmPassword.trim().isEmpty) {
      return ValidatorResult.empty;
    }
    if (!RegExp(passwordRegex).hasMatch(confirmPassword)) {
      return ValidatorResult.invalid;
    }
    if (password == confirmPassword) {
      return ValidatorResult.valid;
    }
    return ValidatorResult.other;
  }

  static ValidatorResult validateCommon(String? input) {
    if (input == null || input.trim().isEmpty) {
      return ValidatorResult.empty;
    }
    return ValidatorResult.valid;
  }

  static ValidatorResult validateStringOnlyAlphabet(String? input) {
    if (input == null || input.trim().isEmpty) {
      return ValidatorResult.empty;
    }
    if (!RegExp(onlyAlphabet).hasMatch(input)) {
      return ValidatorResult.invalid;
    }
    return ValidatorResult.valid;
  }

  static ValidatorResult validateOTP(String? input) {
    if (input == null || input.trim().isEmpty) {
      return ValidatorResult.empty;
    }
    if (!RegExp(otpRegex).hasMatch(input)) {
      return ValidatorResult.invalid;
    }
    return ValidatorResult.valid;
  }

  static ValidatorResult validateTransactionLimit(String? input) {
    final value = input != null && input.isNotEmpty
        ? int.parse(input.split(",").join(''))
        : 0;
    if (input == null || input.trim().isEmpty) {
      return ValidatorResult.empty;
    } else if (int.parse(input.split(",").join('')) > 999999999 || value == 0) {
      return ValidatorResult.invalid;
    }
    return ValidatorResult.valid;
  }

  static ValidatorResult validateOpeningVccCompanyRevenue(String? input) {
    final value = input != null && input.isNotEmpty
        ? int.parse(input.split(",").join(''))
        : 0;
    if (input == null || input.trim().isEmpty) {
      return ValidatorResult.empty;
    } else if (value > 999999999999999 || value < 1) {
      return ValidatorResult.invalid;
    }
    return ValidatorResult.valid;
  }

  static ValidatorResult validateVccBillPayment(
      String? input, int minimumValue, int maximumValue) {
    final value = input != null && input.isNotEmpty
        ? int.parse(input.split(",").join(''))
        : 0;
    if (input == null || input.trim().isEmpty) {
      return ValidatorResult.empty;
    } else if (value < minimumValue || value > maximumValue) {
      return ValidatorResult.invalid;
    }
    return ValidatorResult.valid;
  }

  static ValidatorResult validateAccountNumber(String? input) {
    if (input == null || input.isEmpty) {
      return ValidatorResult.empty;
    }
    if (input.length < 9) {
      return ValidatorResult.invalid;
    }
    return ValidatorResult.valid;
  }

  static ValidatorResult validateTransferAmount(String? input) {
    if (input == null || input.isEmpty) {
      return ValidatorResult.empty;
    }
    final amount = int.tryParse(input.replaceAll(RegExp(r','), ''));
    if (amount == null || amount == 0) {
      return ValidatorResult.invalid;
    }
    return ValidatorResult.valid;
  }
}

class TextFieldValidatorHelper {
  static validateRequired(value) {
    final validatorResult = ValidatorHelper.validateCommon(value);
    if (validatorResult == ValidatorResult.empty) {
      return t.common_.error_.generalRequired;
    }
    if (validatorResult == ValidatorResult.invalid) {
      return t.common_.error_.generalInvalid;
    }
    return null;
  }
}
