class UserData {
  String? userid;
  String? firstName;
  String? lastName;
  String? email;
  String? pswd;
  String? phone;
  String? address;
  String? address2;
  String? city;
  String? state;
  String? zip;
  String? country;
  String? paymentMethod;
  String? cardNumber;
  String? cardName;
  String? cardExpirity;
  String? cvv;
  String? createdDate;
  String? type;
  String? pickupType;

  String get fullName => '${firstName ?? ''} ${lastName ?? ''}';

  String get fullAddress =>
      '${address ?? ''} ${address2 ?? ''} ${city ?? ''} ${state ?? ''} ${country ?? ''} - ${zip ?? ''}';

  bool get isPickUpDriver => pickupType == '1';

  bool get isDeliveryDriver => pickupType == '2';

  bool get isBothDriverType => pickupType == '3';

  UserData.empty();

  UserData(
      {this.userid,
      this.firstName,
      this.lastName,
      this.email,
      this.pswd,
      this.phone,
      this.address,
      this.address2,
      this.city,
      this.state,
      this.zip,
      this.country,
      this.paymentMethod,
      this.cardNumber,
      this.cardName,
      this.cardExpirity,
      this.cvv,
      this.pickupType,
      this.createdDate,
      this.type});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        userid: json['userid'] as String,
        firstName: json['first_name'] as String,
        lastName: json['last_name'] as String,
        email: json['email'] as String,
        pswd: json['pswd'] as String,
        phone: json['phone'] as String,
        address: json['address'] as String,
        address2: json['address_2'] == null ? '' : json['address_2'] as String,
        city: json['city'] as String,
        state: json['state'] as String,
        zip: json['zip'] as String,
        pickupType:
            json['pickup_type'] == null ? '' : json['pickup_type'] as String,
        country: json['country'] == null ? '' : json['country'] as String,
        paymentMethod: json['payment_method'] == null
            ? ''
            : json['payment_method'] as String,
        cardNumber:
            json['card_number'] == null ? '' : json['card_number'] as String,
        cardName: json['card_name'] == null ? '' : json['card_name'] as String,
        cardExpirity: json['card_expirity'] == null
            ? ''
            : json['card_expirity'] as String,
        cvv: json['cvv'] == null ? '' : json['cvv'] as String,
        createdDate:
            json['created_date'] == null ? '' : json['created_date'] as String,
        type: json['type'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userid'] = userid;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['pswd'] = pswd;
    data['phone'] = phone;
    data['address'] = address;
    data['address_2'] = address2;
    data['city'] = city;
    data['state'] = state;
    data['zip'] = zip;
    data['country'] = country;
    data['payment_method'] = paymentMethod;
    data['card_number'] = cardNumber;
    data['card_name'] = cardName;
    data['card_expirity'] = cardExpirity;
    data['cvv'] = cvv;
    data['created_date'] = createdDate;
    data['type'] = type;
    data['pickup_type'] = pickupType;
    return data;
  }
}
