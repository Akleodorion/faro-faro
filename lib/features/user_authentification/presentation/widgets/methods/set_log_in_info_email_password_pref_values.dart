Map<String, dynamic> setLogInInfoEmailPasswordPrefValues(
    Map<dynamic, dynamic> values, logInInfo) {
  logInInfo["email"] = values["email"];
  logInInfo["password"] = values["password"];
  logInInfo["pref"] = values["pref"];
  return logInInfo;
}
