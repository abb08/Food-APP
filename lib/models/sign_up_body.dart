class SignUpBody {
  String name;
  String email;
  String password;
  String phone;

  SignUpBody(
      {required this.email,
      required this.name,
      required this.phone,
      required this.password});

//to convert the body to json so it could be sent to backend since json is just Map<String,dynamic>
  Map<String, dynamic> toJsion() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['f_name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    return data;
  }
}
