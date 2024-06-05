import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

class HeaderTetxt extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const HeaderTetxt(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconButton? icon;
  final bool isPassword;
  final Function(String?)? validator;
  final TextInputType keyboradtype;
  final TextInputAction textInputAcxtion;
  final Function(String)? onChanged;
  final double? borderRadius;
  final Color? fillColor;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.isPassword = false,
    this.validator,
    required this.keyboradtype,
    required this.textInputAcxtion,
    this.borderRadius,
    this.onChanged,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validator as String? Function(String?)?,
      keyboardType: keyboradtype,
      textInputAction: textInputAcxtion,
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: icon,
          filled: true,
          fillColor: fillColor ?? Colors.grey[200],
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius ?? 10)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius ?? 10))),
    );
  }
}

class ElevatedButtons extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color bgcolor;
  final Color txtcolors;

  const ElevatedButtons(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.bgcolor,
      required this.txtcolors});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.95,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: bgcolor,
        ),
        child: Text(
          text,
          style: TextStyle(color: txtcolors, fontSize: 16),
        ),
      ),
    );
  }
}

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Forget Passwrod ?",
        style: TextStyle(color: Color(0xff9c28b1)),
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't Have Account?"),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Register",
            style: TextStyle(color: Colors.pink),
          ),
        ),
      ],
    );
  }
}

class RowButtons extends StatelessWidget {
  const RowButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(border: Border.all(width: .09)),
            child: SignInButton.mini(
              elevation: 0,
              buttonType: ButtonType.facebook,
              btnColor: Colors.blue,
              onPressed: () {},
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(border: Border.all(width: .09)),
            child: SignInButton.mini(
              elevation: 0,
              buttonType: ButtonType.google,
              onPressed: () {},
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(border: Border.all(width: .09)),
            child: SignInButton.mini(
              elevation: 0,
              buttonType: ButtonType.apple,
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
