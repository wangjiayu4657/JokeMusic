import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// import '../../tools/share/user_manager.dart';
import '../../pages/login/viewModels/login_view_model.dart';

class ProviderService  {
  static List<SingleChildWidget> providers = [
    // ChangeNotifierProvider(create: (context) => UserManager()),
    ChangeNotifierProvider(create: (ctx) => LoginViewModel()),
  ];
}