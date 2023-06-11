class LogInResponse{
 late String access_token;
 late String token_type;
  late int expires_in;
  late Customer customer;

  LogInResponse.fromJson(Map<String,dynamic> json){
    access_token=json['access_token'];
    token_type=json['token_type'];
    expires_in=json['expires_in'];
    customer=Customer.fromJson(json['customer']);
  }
}
class Customer{
  late int id;
  late String name;
  late String phone;
  Customer.fromJson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    phone=json['phone'];
}
}