import 'package:apistsk/data/UserMobx/user_mobx.dart';
import 'package:apistsk/data/userModel/user_model.dart';
import 'package:apistsk/validation/user_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/Exception/exception_model.dart';
import '../../Widgets/textformfield.dart';
import '../../model/FormMobx/form_mobx.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  final GlobalKey<FormState> loginkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  // final FancyPasswordController passwordController = FancyPasswordController();
  final TextEditingController passController = TextEditingController();

  void _submitForm() {
    if (loginkey.currentState!.validate()) {
      var userLogin =
          UserSave(email: emailController.text, password: passController.text)
              .toJson();
      // print(userLogin.toString());

      userStore
          .loginUser(userLogin)
          .then((value) => Navigator.pushNamed(context, '/home'))
          .catchError((error) {
        showToast(error.toString());
        return '$error';
      });

      formStore.clearEmail();
      passController.clear();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();

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
                      "assets/images/login.gif",
                      height: 230.h,
                    ),
                    const HeaderTetxt(
                      text: "Login",
                      fontSize: 33.0,
                      fontWeight: FontWeight.bold,
                    ),
                    const HeaderTetxt(
                      fontWeight: FontWeight.normal,
                      text: "Please enter detail below to continue",
                      fontSize: 12.0,
                    ),
                    SizedBox(height: 20.h),
                    Observer(builder: (_) {
                      return AppTextField(
                        controller: emailController,
                        hintText: "Enter email",
                        icon: emailController.text.isNotEmpty
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
                      );
                    }),
                    SizedBox(height: 25.h),
                    Observer(builder: (_) {
                      return AppTextField(
                        controller: passController,
                        hintText: " Enter password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }

                          if (value.length < 4) {
                            return "Password must be at least 4 characters long";
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
                        textInputAcxtion: TextInputAction.done,
                        onChanged: (value) {},
                      );
                    }),
                    // FancyPasswordField(
                    //   decoration: InputDecoration(
                    //     hintText: 'Enter Password',
                    //     filled: true,
                    //     fillColor: Colors.grey[200],
                    //     enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide.none,
                    //         borderRadius: BorderRadius.circular(10)),
                    //     focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide.none,
                    //         borderRadius: BorderRadius.circular(10)),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //   ),
                    //   passwordController: passwordController,
                    //   autocorrect: true,
                    //   validator: (value) {
                    //     return passwordController.areAllRulesValidated
                    //         ? null
                    //         : 'Not Validated';
                    //   },
                    // ),
                    SizedBox(height: 25.h),
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
                      text: "Login",
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
