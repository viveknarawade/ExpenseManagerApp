class User {
  String userId;
  String userName;
  String email;
  String avatar;
 String accessToken;
  String refreshToken;

  User(this.userId, this.userName, this.email, this.avatar, this.accessToken,
      this.refreshToken);

  String getAccessToken() {
    return accessToken;
  }

  String getRefreshToken() {
    return refreshToken;
  }

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
