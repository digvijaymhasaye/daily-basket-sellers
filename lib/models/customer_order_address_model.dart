class CustomerOrderAddressModel {
  int id;
  int orderId;
  int type;
  String firstName;
  String lastName;
  String mobileNo;
  String addressLine1;
  String addressLine2;
  String city;
  String state;
  String postalCode;

  CustomerOrderAddressModel({
    this.id,
    this.orderId,
    this.type,
    this.firstName,
    this.lastName,
    this.mobileNo,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.postalCode,
  });

  factory CustomerOrderAddressModel.fromJson(Map<String, dynamic> customerJson) {
    return CustomerOrderAddressModel(
      id: customerJson['id'],
      orderId: customerJson['order_id'],
      type: customerJson['type'],
      firstName: customerJson['first_name'],
      lastName: customerJson['last_name'],
      mobileNo: customerJson['mobile_no'],
      addressLine1: customerJson['address_line_1'],
      addressLine2: customerJson['address_line_2'],
      city: customerJson['city'],
      state: customerJson['state'],
      postalCode: customerJson['postal_code'],
    );
  }
}