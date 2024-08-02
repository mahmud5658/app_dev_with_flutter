import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/model/user_model.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/url.dart';
import 'package:taskmanager/ui/controller/auth_controller.dart';
import 'package:taskmanager/ui/widgets/background_widgets.dart';
import 'package:taskmanager/ui/widgets/profile_app_bar.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? _selectedImage;
  bool _updateInProgress = false;

  @override
  void initState() {
    super.initState();
    final userData = AuthController.userData!;
    _emailController.text = userData.email ?? '';
    _firstNameController.text = userData.firstName ?? '';
    _lastNameController.text = userData.lastName ?? '';
    _mobileController.text = userData.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context, true),
      body: BackgroundWidget(
          child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Text(
                    'Update Profile',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  _buildPhotPicker(),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.grey.shade400)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _firstNameController,
                    decoration: InputDecoration(
                        hintText: "First Name",
                        hintStyle: TextStyle(color: Colors.grey.shade400)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _lastNameController,
                    decoration: InputDecoration(
                        hintText: "Last Name",
                        hintStyle: TextStyle(color: Colors.grey.shade400)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _mobileController,
                    decoration: InputDecoration(
                        hintText: "Mobile",
                        hintStyle: TextStyle(color: Colors.grey.shade400)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey.shade400)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible: _updateInProgress==false,
                    replacement:  const Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                        onPressed: () {
                          updateProfile();
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined)),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
  }

  Widget _buildPhotPicker() {
    return GestureDetector(
      onTap: _pickProfileImage,
      child: Container(
          width: double.maxFinite,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: 100,
                height: 48,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8)),
                    color: Colors.grey),
                child: const Text(
                  'Photo',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Text(
                _selectedImage?.name ?? 'No image selected',
                maxLines: 1,
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              ))
            ],
          )),
    );
  }

  Future<void> _pickProfileImage() async {
    ImagePicker imagePicker = ImagePicker();
    final XFile? result =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      _selectedImage = result;
      if (mounted) {
        setState(() {
          _selectedImage = result;
        });
      }
    }
  }

  Future<void> updateProfile() async {
    String encodedPhoto = AuthController.userData?.photo ?? '';
    if (mounted) {
      setState(() {
        _updateInProgress = true;
      });
    }
    Map<String, dynamic> requestBody = {
      "email": _emailController.text.trim(),
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
    };
    if (_passwordController.text.isNotEmpty) {
      requestBody['password'] = _passwordController.text;
    }
    if (_selectedImage != null) {
      File file = File(_selectedImage!.path);

      encodedPhoto = base64Encode(file.readAsBytesSync());

      requestBody['photo'] = encodedPhoto;
    }
    final NetworkResponse response =
        await NetworkCaller.postRequest(Urls.profileUpdate, body: requestBody);
    if (response.isSuccess) {
      UserModel userModel = UserModel(
        email: _emailController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        mobile: _mobileController.text.trim(),
        photo: encodedPhoto,
      );
      await AuthController.saveUserData(userModel);
       if (mounted) {
        showSnackBarMessage(
          context,'Profile Updated',
        );
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,'Profile update failed! try again',
        );
      }
    }
        if (mounted) {
      setState(() {
        _updateInProgress = false;
      });
    }
  }
}
