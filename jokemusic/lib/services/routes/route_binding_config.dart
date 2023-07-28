import '../../pages/login/login_binding.dart';
import '../../pages/profile/controllers/user_info_controller.dart';
import '../../pages/profile/controllers/feedback_controller.dart';
import '../../pages/profile/controllers/account_safe_controller.dart';
import '../../pages/profile/controllers/audit_result_controller.dart';
import '../../pages/profile/controllers/change_password_controller.dart';
import '../../pages/profile/controllers/user_editor_controller.dart';
import '../../pages/profile/controllers/photo_browser_controller.dart';
import '../../pages/profile/controllers/reset_password_controller.dart';
import '../../pages/profile/controllers/profile_controller.dart';
import '../../pages/profile/controllers/setting_controller.dart';

abstract class RouteBinding {
  static final login = LoginBinding();
  static final auditResult = AuditResultBinding();
  static final userEditor = UserEditorBinding();
  static final userInfo = UserInfoBinding();
  static final feedback = FeedbackBinding();
  static final accountSafe = AccountSafeBinding();
  static final changePassword = ChangePasswordBinding();
  static final photoBrowser = PhotoBrowserBinding();
  static final resetPassword = ResetPasswordBinding();
  static final profile = ProfileBinding();
  static final setting = SettingBinding();

}