bool emailValidation(String email){
  var reg = RegExp(r"(?=.*[a-zA-Z0-9])+@\w+.\w{2,3}");
  if(reg.hasMatch(email)){
    return true;
  }
  return false;
}

bool passwordValidation(String password){
  var reg = RegExp(r"(?=.*[A-Z])+(?=.*[a-z0-9])+(?=.*\W)+");
  if(reg.hasMatch(password)){
    return true;
  }
  return false;
}

bool phoneNumberValidation(String phoneNumber){
  var reg = RegExp(r"\d{10}");
  if(reg.hasMatch(phoneNumber)){
    return true;
  }
  return false;
}