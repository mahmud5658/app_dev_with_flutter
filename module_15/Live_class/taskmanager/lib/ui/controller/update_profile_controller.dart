import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/model/user_model.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/url.dart';
import 'package:taskmanager/ui/controller/auth_controller.dart';

class UpdateProfileController extends GetxController {
  bool isSuccess = false;
  XFile? _selectedImage;
  XFile? get selectedImage => _selectedImage;
  bool _updateInProgress = false;
  bool get updateInProgress => _updateInProgress;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> pickProfileImage() async {
    ImagePicker imagePicker = ImagePicker();
    final XFile? result =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      _selectedImage = result;
      update();
    }
  }

  Future<bool> updateProfile(
      email, firstName, lastName, mobile, password) async {
    String encodedPhoto = AuthController.userData?.photo ?? '';
    _updateInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };
    if (password != null) {
      requestBody['password'] = password;
    }
    if (_selectedImage != null) {
      File file = File(_selectedImage!.path);

      encodedPhoto = base64Encode(file.readAsBytesSync());

      requestBody['photo'] = encodedPhoto;
    }
    final NetworkResponse response =
        await NetworkCaller.postRequest(Urls.profileUpdate, body: requestBody);
    if (response.isSuccess) {
      isSuccess = true;
      UserModel userModel = UserModel(
        email: email,
        firstName: firstName,
        lastName: lastName,
        mobile: mobile,
        photo: encodedPhoto,
      );
      await AuthController.saveUserData(userModel);
    } else {
      _errorMessage = response.errorMessage ?? "failed try again";
    }

    _updateInProgress = false;
    update();

    return isSuccess;
  }
}
