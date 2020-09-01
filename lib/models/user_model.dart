class UserModel {
  int id;
  String firstName;
  String lastName;
  String emailId;
  String token;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.emailId,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> categoryJson) {
    return UserModel(
      id: categoryJson['id'],
      firstName: categoryJson['first_name'],
      lastName: categoryJson['last_name'],
      token: categoryJson['token'],
    );
  }
}