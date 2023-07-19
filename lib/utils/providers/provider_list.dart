import 'package:chat_app/home/view_model/home_view_model.dart';
import 'package:chat_app/user_auth/view_model/logged_view_model.dart';
import 'package:chat_app/user_auth/view_model/login_view_model.dart';
import 'package:chat_app/user_auth/view_model/signup_view_model.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

class ProviderList {
  static List<SingleChildWidget> provider = [
    ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => SignupViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => LoggedInViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
    ),
  ];
}
