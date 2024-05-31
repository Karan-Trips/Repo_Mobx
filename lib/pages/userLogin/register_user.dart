// ignore_for_file: use_build_context_synchronously

import 'package:apistsk/model/UserData/userModel/user_model.dart';
import 'package:apistsk/validation/user_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/UserData/UserMobx/user_mobx.dart';
import '../../model/Widgets/textformfield.dart';
import '../../model/mobxModel/user_mobx.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final GlobalKey<FormState> loginkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  void _submitForm() async {
    if (loginkey.currentState!.validate()) {
      var user =
          UserSave(email: emailController.text, password: passController.text);

      try {
        await userStore
            .createUser(user)
            .then((value) => Navigator.pushReplacementNamed(context, '/login'))
            .catchError((error) {
          return '$error';
        });
        debugPrint('User saved: ${user.email}');

        formStore.clearEmail();
        passController.clear();

        Fluttertoast.showToast(
          msg: "Form Submitted",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } catch (error) {
        debugPrint('Error creating user: $error');
        Fluttertoast.showToast(
          msg: "Failed to submit form",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(393, 851),
      splitScreenMode: false,
    );

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Form(
                key: loginkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/logo.gif",
                      height: 230.h,
                    ),
                    const HeaderTetxt(
                      text: "Register here",
                      fontSize: 33.0,
                      fontWeight: FontWeight.bold,
                    ),
                    const HeaderTetxt(
                      fontWeight: FontWeight.normal,
                      text: "Please enter detail below to continue",
                      fontSize: 12.0,
                    ),
                    SizedBox(height: 20.h),
                    Observer(
                      builder: (_) => AppTextField(
                        controller: emailController,
                        hintText: "Enter email",
                        icon: formStore.email.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  formStore.clearEmail();
                                  emailController.clear();
                                },
                                icon: const Icon(Icons.clear),
                              )
                            : null,
                        isPassword: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          } else if (!value.isValidEmail()) {
                            return "Enter the valid email";
                          }
                          return null;
                        },
                        keyboradtype: TextInputType.emailAddress,
                        textInputAcxtion: TextInputAction.next,
                        onChanged: (value) {
                          formStore.setEmail(value);
                        },
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Observer(
                      builder: (_) => AppTextField(
                        controller: passController,
                        hintText: " Enter password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }

                          if (value.length < 4) {
                            return "Password must be at least 8 characters long";
                          }

                          if (value != confirmPassController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        icon: IconButton(
                          onPressed: formStore.togglePasswordVisibility,
                          icon: Icon(
                            formStore.passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        isPassword: !formStore.passwordVisible,
                        keyboradtype: TextInputType.visiblePassword,
                        textInputAcxtion: TextInputAction.next,
                        onChanged: (value) {
                          formStore.setPassword(value);
                        },
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Observer(
                      builder: (_) => AppTextField(
                        controller: confirmPassController,
                        hintText: " Confirm password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }

                          if (value.length < 4) {
                            return "Password must be at least 8 characters long";
                          }

                          if (value != passController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        icon: IconButton(
                          onPressed: formStore.toggleConfirmPasswordVisibility,
                          icon: Icon(
                            formStore.confirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        isPassword: !formStore.confirmPasswordVisible,
                        keyboradtype: TextInputType.visiblePassword,
                        textInputAcxtion: TextInputAction.done,
                        onChanged: (value) {
                          formStore.setConfirmPassword(value);
                        },
                      ),
                    ),
                    Align(
                      heightFactor: 1.5,
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {},
                        child: const HeaderTetxt(
                          text: "Forget Password?",
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: 25.h),
                    ElevatedButtons(
                      onPressed: _submitForm,
                      text: "Register ",
                      bgcolor: Colors.pink,
                      txtcolors: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
