import 'package:chat_app/user_auth/view_model/login_view_model.dart';
import 'package:chat_app/utils/global_colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFormWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyType;
  final bool isPassword;
  final bool isEmail;

  final bool isUser;
  final bool isObs;
  final Size size;
  final dynamic prefixIcon;
  const TextFormWidget({
    super.key,
    required this.prefixIcon,
    required this.controller,
    required this.hintText,
    required this.keyType,
    required this.size,
    this.isPassword = false,
    this.isEmail = false,
    this.isUser = false,
    this.isObs = false,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoginViewModel>();
    return TextFormField(
      controller: controller,
      keyboardType: keyType,
      validator: (value) {
        if (isUser) {
          if (value == null || value.isEmpty) {
            return "Username is required";
          }
        }

        if (isPassword) {
          if (value == null || value.isEmpty) {
            return "password is required";
          } else if (value.length < 8) {
            return "password must be 8 or more charecters";
          }
        }

        if (isEmail) {
          if (value != null && !EmailValidator.validate(value)) {
            return "Enter valid email";
          }
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(25, 107, 99, 255),
        filled: true,
        prefixIconColor: AppColors.kblack,
        prefixIcon: prefixIcon,
        suffixIconColor: AppColors.kblack,
        suffixIcon: isPassword
            ? IconButton(
                splashRadius: 4,
                onPressed: () {
                  context.read<LoginViewModel>().showPassword();
                },
                icon: provider.passwordVisibility
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              )
            : const SizedBox(),
        counterStyle: const TextStyle(color: AppColors.kwhite),
        hintText: hintText,
        // hintStyle: hintStyle,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15)),
      ),
      style: TextStyle(
        fontSize: size.width * 0.045,
        color: AppColors.kblack,
        fontWeight: FontWeight.bold,
      ),
      obscureText: isPassword ? provider.passwordVisibility : false,
    );
  }
}
