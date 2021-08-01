enum userSex { male, female, unknown }
enum userType { traveler, admin }

class user {
  int userID = 0;
  String userPass = '';
  userType myType = userType.traveler;
  String profilePhoto = '';
  userSex mySex = userSex.male;
  user(
      {required this.userID,
      required this.userPass,
      this.mySex = userSex.male,
      this.myType = userType.traveler,
      this.profilePhoto = 'https://www.itying.com/images/flutter/1.png'});
}
/*set setProfilePhoto(String t) => profilePhoto = t;
  String get getProfilePhoto => profilePhoto;

  set setPass(String pass) => userPass = pass;
  String get getPass => userPass;

  set setUsertype(userType t) => myType = t;
  userType get getUserType => myType;

  int get getUserID => userID;

  set setUserSex(userSex s) => mySex = s;
  userSex get getUserSex => mySex;*/
