class UserModel {
  String uId;
  String username;
  String email;
  String phone;
  String userImg;
  String nationality;
  String birthDate;
  String specialization;
  String experienceLevel;
  String currentWorkplace;
  List<String> skills;
  List<String> certificates;
  String resume; // رابط السيرة الذاتية

  UserModel({
    required this.uId,
    required this.username,
    required this.email,
    required this.phone,
    required this.userImg,
    required this.nationality,
    required this.birthDate,
    required this.specialization,
    required this.experienceLevel,
    required this.currentWorkplace,
    required this.skills,
    required this.certificates,
    required this.resume,
  });

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'username': username,
      'email': email,
      'phone': phone,
      'userImg': userImg,
      'nationality': nationality,
      'birthDate': birthDate,
      'specialization': specialization,
      'experienceLevel': experienceLevel,
      'currentWorkplace': currentWorkplace,
      'skills': skills,
      'certificates': certificates,
      'resume': resume,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json['uId'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      userImg: json['userImg'],
      nationality: json['nationality'],
      birthDate: json['birthDate'],
      specialization: json['specialization'],
      experienceLevel: json['experienceLevel'],
      currentWorkplace: json['currentWorkplace'],
      skills: List<String>.from(json['skills'] ?? []),
      certificates: List<String>.from(json['certificates'] ?? []),
      resume: json['resume'] ?? '',
    );
  }
}
