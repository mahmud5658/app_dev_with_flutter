import 'home_slider.dart';

class HomeSliderList {
  String? msg;
  List<HomeSlider>? homeSliders;

  HomeSliderList({this.msg, this.homeSliders});

  HomeSliderList.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      homeSliders = <HomeSlider>[];
      json['data'].forEach((v) {
        homeSliders!.add(new HomeSlider.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.homeSliders != null) {
      data['data'] = this.homeSliders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
