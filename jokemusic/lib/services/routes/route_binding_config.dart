
import '../../pages/login/login_binding.dart';
import '../../pages/profile/controllers/user_info_controller.dart';
import '../../pages/profile/controllers/account_safe_controller.dart';
import '../../pages/profile/controllers/audit_result_controller.dart';
import '../../pages/profile/controllers/change_password_controller.dart';
import '../../pages/profile/controllers/user_editor_controller.dart';

abstract class RouteBinding {
  static final login = LoginBinding();
  static final auditResult = AuditResultBinding();
  static final userEditor = UserEditorBinding();
  static final userInfo = UserInfoBinding();
  static final accountSafe = AccountSafeBinding();
  static final changePassword = ChangePasswordBinding();
}