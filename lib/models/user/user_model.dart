class User {
  final int id;
  final String email;
  final String passWord;
  final String userName;
  final String fullName;
  final int isManager;
  final String numberPhone;
  User(
      {required this.id,
      required this.email,
      required this.passWord,
      required this.userName,
      required this.fullName,
      required this.isManager,
      required this.numberPhone});
  factory User.fromJson(Map<String, dynamic> data) => User(
        id: data['id'],
        email: data['email'],
        passWord: data['passWord'],
        userName: data['userName'],
        fullName: data['fullName'],
        numberPhone: data['numberPhone'],
        isManager: data['isManager'],
      );
  Map<String, dynamic> toMap() => {
        'id': id,
        'email': email,
        'passWord': passWord,
        'userName': userName,
        'fullName': fullName,
        'numberPhone': numberPhone,
        'isManager': isManager,
      };
}
