import 'package:crafty_bay/data/model/create_profile_data.dart';
import 'package:crafty_bay/data/model/profile.dart';
import 'package:crafty_bay/data/state_holders/profile_info_cache_controller.dart';
import 'package:crafty_bay/presentation/UI/screens/email_identification_screen.dart';
import 'package:crafty_bay/presentation/UI/widgets/bottom_popup_message.dart';
import 'package:crafty_bay/presentation/UI/widgets/button_loading_indicator.dart';
import 'package:crafty_bay/presentation/utils/input_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/state_holders/create_profile_controller.dart';
import '../widgets/app_logo.dart';

class SetProfile extends StatefulWidget {
  const SetProfile({super.key, required this.heading, this.readProfileData});
  final String heading;
  final Profile? readProfileData;

  @override
  State<SetProfile> createState() => _SetProfileState();
}

class _SetProfileState extends State<SetProfile> {
  @override
  void initState() {
    super.initState();
    _tECFirstName.text = widget.readProfileData?.cusName?.split(' ')[0]??'';
    _tECLastName.text = widget.readProfileData?.cusName?.split(' ')[1]??'';
    _tECMobile.text = widget.readProfileData?.cusPhone??'';
    _tECFaxNumber.text = widget.readProfileData?.cusFax??'';
    _tECCity.text = widget.readProfileData?.cusCity??'';
    _tECPostCode.text = widget.readProfileData?.cusPostcode??'';
    _tECState.text = widget.readProfileData?.cusState??'';
    _tECCountry.text = widget.readProfileData?.cusCountry??'';
    _tECShippingAddress.text = widget.readProfileData?.shipAdd??'';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.sizeOf(context).height / 20,
              left: 26,
              right: 26,
              bottom: MediaQuery.sizeOf(context).height / 20,),
          child: Form(
            key: _theFormKey,
            child: Column(
              children: [
                const AppLogo(logoSize: 100),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.heading,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Get started with us with your details',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black87),
                  controller: _tECFirstName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? i) {
                    if (i != null) {
                      if (i.trim().isEmpty) {
                        return 'Kindly enter your first name!';
                      }
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(hintText: 'First Name'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black87),
                  controller: _tECLastName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? i) {
                    if (i != null) {
                      if (i.trim().isEmpty) {
                        return 'Kindly enter your last name!';
                      }
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(hintText: 'Last Name'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black87),
                  controller: _tECMobile,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? i) {
                    if (i != null) {
                      if (i.trim().isEmpty) {
                        return 'Kindly enter your phone number!';
                      } else if (InputValidator.phoneNumberValidator
                              .hasMatch(i) ==
                          false) {
                        return 'Please enter a valid phone number!';
                      }
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Mobile'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black87),
                  controller: _tECFaxNumber,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? i) {
                    if (i != null) {
                      if (i.trim().isEmpty) {
                        return 'Kindly share your fax number!';
                      }
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Fax'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black87),
                  controller: _tECCity,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? i) {
                    if (i != null) {
                      if (i.trim().isEmpty) {
                        return 'Kindly share your city name!';
                      }
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(hintText: 'City'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black87),
                  controller: _tECPostCode,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? i) {
                    if (i != null) {
                      if (i.trim().isEmpty) {
                        return 'Kindly share your post code!';
                      }
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Post Code'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black87),
                  controller: _tECState,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? i) {
                    if (i != null) {
                      if (i.trim().isEmpty) {
                        return 'Kindly share your state name!';
                      }
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(hintText: 'State'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black87),
                  controller: _tECCountry,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? i) {
                    if (i != null) {
                      if (i.trim().isEmpty) {
                        return 'Kindly share the name of your country!';
                      }
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(hintText: 'Country'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black87),
                  controller: _tECShippingAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? i) {
                    if (i != null) {
                      if (i.trim().isEmpty) {
                        return 'Kindly share your shipping address!';
                      }
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  maxLines: 3,
                  keyboardType: TextInputType.text,
                  decoration:
                      const InputDecoration(hintText: 'Shipping Address'),
                ),
                const SizedBox(
                  height: 15,
                ),
                GetBuilder<CreateProfileController>(
                  builder: (controller) {
                    return Visibility(
                      visible: !controller.loading,
                      replacement: const ButtonLoadingIndicator(),
                      child: ElevatedButton(
                        onPressed: () async{
                          if (_theFormKey.currentState!.validate()) {
                            CreateProfileData profileData = CreateProfileData(
                              cusName: '${_tECFirstName.text.trim()} ${_tECLastName.text.trim()}',
                              cusPhone: _tECMobile.text,
                              cusCity: _tECCity.text,
                              shipAdd: _tECShippingAddress.text,
                              shipCity: _tECCity.text,
                              shipCountry: _tECCountry.text,
                              shipName: '${_tECFirstName.text} ${_tECLastName.text}',
                              shipPhone: _tECMobile.text,
                              shipPostcode: _tECPostCode.text,
                              shipState: _tECState.text,
                              cusAdd: _tECShippingAddress.text,
                              cusCountry: _tECCountry.text,
                              cusFax: _tECFaxNumber.text,
                              cusPostcode: _tECPostCode.text,
                              cusState: _tECState.text
                            );
                            bool created =await controller.createProfile(profileData);
                            if(created){
                              bottomPopUpMessage(context, 'Profile updated!');
                              await ProfileInfoCacheController.updateProfile(profileData: Profile(
                                  cusName: '${_tECFirstName.text.trim()} ${_tECLastName.text.trim()}',
                                  cusPhone: _tECMobile.text,
                                  cusCity: _tECCity.text,
                                  shipAdd: _tECShippingAddress.text,
                                  shipCity: _tECCity.text,
                                  shipCountry: _tECCountry.text,
                                  shipName: '${_tECFirstName.text} ${_tECLastName.text}',
                                  shipPhone: _tECMobile.text,
                                  shipPostcode: _tECPostCode.text,
                                  shipState: _tECState.text,
                                  cusAdd: _tECShippingAddress.text,
                                  cusCountry: _tECCountry.text,
                                  cusFax: _tECFaxNumber.text,
                                  cusPostcode: _tECPostCode.text,
                                  cusState: _tECState.text
                              ));
                              Get.back();
                            }else{
                              bottomPopUpMessage(context, controller.errorMessage, showError: true);
                              Get.off(()=>const EmailIdentificationScreen());
                            }
                          }
                        },
                        child: Text(
                          'Completed',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                      ),
                    );
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //---------------------------------------Functions---------------------------------------

  //---------------------------------------Variable----------------------------------------
  final GlobalKey<FormState> _theFormKey = GlobalKey<FormState>();
  final TextEditingController _tECFirstName = TextEditingController();
  final TextEditingController _tECLastName = TextEditingController();
  final TextEditingController _tECMobile = TextEditingController();
  final TextEditingController _tECCity = TextEditingController();
  final TextEditingController _tECState = TextEditingController();
  final TextEditingController _tECCountry = TextEditingController();
  final TextEditingController _tECPostCode = TextEditingController();
  final TextEditingController _tECFaxNumber = TextEditingController();
  final TextEditingController _tECShippingAddress = TextEditingController();
}
