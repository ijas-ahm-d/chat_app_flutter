
import 'package:chat_app/user_auth/components/common_button.dart';
import 'package:chat_app/user_auth/components/text_form_field.dart';
import 'package:chat_app/user_auth/view_model/login_view_model.dart';
import 'package:chat_app/utils/global_colors.dart';
import 'package:chat_app/utils/global_values.dart';
import 'package:chat_app/utils/routes/navigations.dart';
import 'package:chat_app/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoginViewModel>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kwhite,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode curentFocus = FocusScope.of(context);
          if (!curentFocus.hasPrimaryFocus) {
            curentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 80,
            ),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "TEAM-TALK",
                    style: TextStyles.onText(
                      22,
                      FontWeight.bold,
                      AppColors.appColor,
                    ),
                  ),
                  AppSizes.kHeight10,
                  Text(
                    "Login Now to see what they are talking!",
                    style: TextStyles.onText(
                      14,
                      FontWeight.normal,
                      Colors.black,
                    ),
                  ),
                  AppSizes.kHeight10,
                  Image.asset("assets/images/login.png"),
                  AppSizes.kHeight30,
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: TextFormWidget(
                        isEmail: true,
                        prefixIcon: const Icon(Icons.email),
                        controller: provider.emailController,
                        hintText: "Email",
                        keyType: TextInputType.emailAddress,
                        size: size),
                  ),
                  AppSizes.kHeight30,
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: TextFormWidget(
                        isPassword: true,
                        prefixIcon: const Icon(Icons.lock),
                        controller: provider.passwordController,
                        hintText: "Password",
                        keyType: TextInputType.name,
                        size: size),
                  ),
                  AppSizes.kHeight50,
                  CommonButton(
                    onTap: provider.isLoading
                        ? () {}
                        : () async {
                            if (_formkey.currentState!.validate()) {
                            
                              await provider.login(context);
                            }
                          },
                    color: AppColors.kblack2,
                      size:const Size(200, 50),
                    child: provider.isLoading
                        ? const CircularProgressIndicator(
                            strokeWidth: 2,
                          )
                        : Text(
                            "Login",
                            style: TextStyles.onText(
                              14,
                              FontWeight.w600,
                              AppColors.kwhite,
                            ),
                          ),
                        
                  ),
                  AppSizes.kHeight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don’t have an account?",
                        style: TextStyle(color: AppColors.kblack),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(Navigations.signupScreen);
                        },
                        child: const Text(
                          "Register Now",
                          style: TextStyle(
                            color: AppColors.spGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
