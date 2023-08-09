// :))))))))))))))))))))))))
String mapBackendOutput({required backendRespond}) {
  if (backendRespond.trim() == "custom user with this email already exists.") {
    return "emailAlreadyExists";
  } else if (backendRespond.trim() == "This password is too common.") {
    return "commonPassword";
  } else if (backendRespond.trim() == "This password is entirely numeric.") {
    return "numericalPassword";
  } else if (backendRespond.trim() ==
      "The password is too similar to the email.") {
    return "passwordTooSimilar";
  } else if (backendRespond.trim() ==
      "No active account found with the given credentials") {
    print("here");
    return "noActiveAcc";
  } else {
    print("here1");
    return "errorHasOccurred";
  }
}
