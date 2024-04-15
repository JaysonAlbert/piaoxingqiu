bool isValidPhoneNumber(String? phoneNumber) {
  if (phoneNumber == null || phoneNumber.isEmpty) {
    return false;
  }
  RegExp regExp = RegExp(r'^\d{11}$');
  return regExp.hasMatch(phoneNumber);
}
