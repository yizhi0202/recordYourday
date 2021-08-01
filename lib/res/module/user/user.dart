enum userSex { male, female, unknown }
enum userType { traveler, admin }

class user {
  int userID = 0;
  String userPass = '';
  userType myType = userType.traveler;
  String profilePhoto = '';
  userSex mySex = userSex.male;
  String nickName = '';

  initUser(
      {required int userID,
      required String userPass,
      userSex mySex = userSex.male,
      userType myType = userType.traveler,
      String profilePhoto = 'https://www.itying.com/images/flutter/1.png',
      String nickname = ''}) {
    this.userID = userID;
    this.userPass = userPass;
    this.mySex = mySex;
    this.myType = myType;
    this.profilePhoto = profilePhoto;
    this.nickName = nickname;
  }

  set setProfilePhoto(String t) => profilePhoto = t;
  String get getProfilePhoto => profilePhoto;

  set setPass(String pass) => userPass = pass;
  String get getPass => userPass;

  set setUsertype(userType t) => myType = t;
  userType get getUserType => myType;

  int get getUserID => userID;

  set setUserSex(userSex s) => mySex = s;
  userSex get getUserSex => mySex;

  set setNickName(String name) => nickName = name;
  String get getNickName => nickName;
  // user(
  //     {required this.userID,
  // required this.userPass,
  // this.mySex = userSex.male,
  // this.myType = userType.traveler,
  // this.profilePhoto = 'https://www.itying.com/images/flutter/1.png'});
}
