class UsersModel {
    String? fullname;
    String? cccd;
    String? phone;
    String? email;
    String? address;
    int? age;
    String? gender;
    String? nation;
    String? education;
    int? numpeople;
    int? numfemale;
    String? job;
    int? income;
    String? usedservice;

  UsersModel({
    this.fullname,
    this.cccd,
    this.phone,
    this.email,
    this.address,
    this.age,
    this.gender,
    this.nation,
    this.education,
    this.numpeople,
    this.numfemale,
    this.job,
    this.income,
    this.usedservice,
  });

    // Phương thức toJson để chuyển đối tượng thành Map
  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'cccd': cccd,
      'phone': phone,
      'emai': email,
      'address': address,
      'age': age,
      'gender': gender,
      'nation': nation,
      'education': education,
      'numpeople': numpeople,
      'numfemale': numfemale,
      'job': job,
      'income': income,
      'usedservice': usedservice,
    };
  }
}