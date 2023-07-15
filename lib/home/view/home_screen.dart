import 'package:chat_app/user_auth/view_model/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SignupViewModel>();
    return Scaffold(
      body: Center(
        child: TextButton(
            child: const Text("logout"),
            onPressed: () {
              provider.setLogOutStatus(context);
            }),
      ),
    );
  }
}
