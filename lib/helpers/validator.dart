bool isValidPhoneNumber(String? phoneNumber) {
  if (phoneNumber == null || phoneNumber.isEmpty) {
    return false;
  }
  RegExp regExp = RegExp(r'^\d{11}$');
  return regExp.hasMatch(phoneNumber);
}

bool isValidName(String? name) {
  if (name == null || name.isEmpty) {
    return false;
  }

  return name.length >= 2;
}

bool isValidIdNo(String? id) {
  if (id == null || id.isEmpty) {
    return false;
  }
  // Regular expression for Chinese ID card number validation
  RegExp regExp = RegExp(
    r'^\d{17}[\dXx]$',
    caseSensitive: false,
    multiLine: false,
  );

  if (!regExp.hasMatch(id)) {
    return false;
  }

  // Extract the last digit (verification code) and the first 17 digits
  String code = id.substring(17, 18).toUpperCase();
  String digits = id.substring(0, 17);

  // Calculate the verification code
  List<int> factors = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];

  List<String> verifyCodes = [
    '1',
    '0',
    'X',
    '9',
    '8',
    '7',
    '6',
    '5',
    '4',
    '3',
    '2'
  ];

  int sum = 0;
  for (int i = 0; i < 17; i++) {
    sum += int.parse(digits[i]) * factors[i];
  }

  int remainder = sum % 11;
  String calculatedCode = verifyCodes[remainder];

  // Check if the verification code matches
  return code == calculatedCode;
}
