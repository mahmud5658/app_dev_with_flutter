import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/ui/controller/auth_controller.dart';
import 'package:taskmanager/ui/controller/update_profile_controller.dart';
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

  final UpdateProfileController updateProfileController =
      Get.find<UpdateProfileController>();

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
                  GetBuilder<UpdateProfileController>(
                      builder: (updateProfileController) {
                    return Visibility(
                      visible:
                          updateProfileController.updateInProgress == false,
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                          onPressed: () {
                            updateProfile();
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined)),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  Widget _buildPhotPicker() {
    return GestureDetector(
      onTap: updateProfileController.pickProfileImage,
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
              Expanded(child: GetBuilder<UpdateProfileController>(builder: (updateProfileController) {
                return Text(
                  updateProfileController.selectedImage?.name ??
                      'No image selected',
                  maxLines: 1,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                );
              }))
            ],
          )),
    );
  }

  void updateProfile() async {
    final result = await updateProfileController.updateProfile(
        _emailController.text.trim(),
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        _mobileController.text.trim(),
        _passwordController.text);
    if (result == false) {
      if (mounted) {
        showSnackBarMessage(context, updateProfileController.errorMessage);
      }
    }
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
}
