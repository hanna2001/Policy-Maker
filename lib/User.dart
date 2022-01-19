class User {
  String phone;
  String companyName;
  String email;
  String expiryDate;
  String imei;
  String logoUrl;
  String userName;
  String website;

  User(
      {this.phone,
      this.companyName,
      this.email,
      this.expiryDate,
      this.imei,
      this.logoUrl,
      this.userName,
      this.website});

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
        phone: json["Phone"] as String,
        companyName: json["CompanyName"] as String,
        email: json["Email"] as String,
        expiryDate: json["ExpiryDate"] as String,
        imei: json["IMEI"] as String,
        logoUrl: json["Logo"] as String,
        userName: json["Username"] as String,
        website: json["Website"] as String);
  }
}
