class CustomerModel {
  int id;
  String firstName;
  String lastName;
  String emailId;
  String mobileNo;
  int status;
  String createdAt;

  CustomerModel({
    this.id,
    this.firstName,
    this.lastName,
    this.emailId,
    this.mobileNo,
    this.status,
    this.createdAt,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> customerJson) {
    return CustomerModel(
      id: customerJson['id'],
      firstName: customerJson['first_name'],
      lastName: customerJson['last_name'],
      emailId: customerJson['email_id'],
      mobileNo: customerJson['mobile_no'],
      status: customerJson['status'],
      createdAt: customerJson['created_at'],
    );
  }
}