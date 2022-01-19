class Responses {
  String insurance;

  Responses({this.insurance});

  factory Responses.fromJson(Map<String, dynamic> json, int i) {
    if (i == 1) {
      return Responses(
        insurance: json["insurance_name"] as String,
      );
    } else if (i == 2) {
      return Responses(
        insurance: json["insurance_type"] as String,
      );
    } else if (i == 3) {
      return Responses(
        insurance: json["member_type"] as String,
      );
    } else if (i == 4) {
      return Responses(
        insurance: json["company_name"] as String,
      );
    } else if (i == 5) {
      return Responses(
        insurance: json["plan_name"] as String,
      );
    } else if (i == 6) {
      return Responses(
        insurance: json["sum_insured"] as String,
      );
    } else if (i == 7) {
      return Responses(
        insurance: json["premium_amount"] as String,
      );
    } else if (i == 8) {
      return Responses(
        insurance: json["plan_feature"] as String,
      );
    } else if (i == 9) {
      return Responses(
        insurance: json["plan_installments"] as String,
      );
    } else if (i == 10) {
      return Responses(
        insurance: json["plan_feature"] as String,
      );
    } else if (i == 11) {
      return Responses(
        insurance: json["parameter"] as String,
      );
    } else if (i == 12) {
      return Responses(
        insurance: json["premium_amount"] as String,
      );
    } else if (i == 15) {
      return Responses(
        insurance: json["answer"] as String,
      );
    }
  }
}
