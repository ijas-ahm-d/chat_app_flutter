import 'package:chat_app/user_auth/view_model/login_view_model.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

class ProviderList {
  static List<SingleChildWidget> provider = [
    ChangeNotifierProvider(create: (context) => LoginViewModel(),)
  ];
}
