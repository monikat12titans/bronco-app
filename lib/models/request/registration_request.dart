class Registration {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phone;
  String? address;
  String? state;
  String? city;
  int? zip;
  int? type;

  Registration.empty();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['zip'] = zip;
    data['type'] = type;
    return data;
  }
}
