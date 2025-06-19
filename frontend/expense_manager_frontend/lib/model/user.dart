class User {
  String userId;
  String userName;
  String email;
  String avatar;

  User(this.userId, this.userName, this.email, this.avatar);

  String getUserId() {
    return userId;
  }

  String getUserName() {
    return userName;
  }

  String getUserEmail() {
    return email;
  }

  String getUserAvatar() {
    return avatar;
  }
}
