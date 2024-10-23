import 'package:crafty_bay/data/model/profile.dart';

class ReadProfileData {
  String? msg;
  Profile? data;

  ReadProfileData({this.msg, this.data});

  ReadProfileData.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? new Profile.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}


