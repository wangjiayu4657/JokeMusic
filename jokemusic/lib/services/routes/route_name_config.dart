import 'package:jokemusic/pages/profile/photo_browser_page.dart';

import '../../pages/main/main_page.dart';
import '../../pages/login/login_view.dart';
import '../../pages/Home/home_page.dart';
import '../../pages/Home/widgets/home_search.dart';
import '../../pages/publish/publish_page.dart';
import '../../pages/video/video_page.dart';
import '../../pages/Profile/user_info_editor_page.dart';
import '../../pages/Profile/user_info_page.dart';
import '../../pages/message/message_page.dart';
import '../../pages/profile/account_safe_page.dart';
import '../../pages/profile/audit_result_page.dart';
import '../../pages/profile/change_password_page.dart';
import '../../pages/profile/feedback_page.dart';
import '../../pages/profile/profile_page.dart';
import '../../pages/profile/reset_password_page.dart';
import '../../pages/profile/setting_page.dart';
import '../../pages/profile/user_editor_page.dart';

abstract class RouteName {
  static const main = MainPage.routeName;
  static const login = LoginPage.routeName;
  static const home = HomePage.routeName;
  static const search = HomeSearch.routeName;
  static const video = VideoPage.routeName;
  static const publish = PublishPage.routeName;
  static const message = MessagePage.routeName;
  static const profile = ProfilePage.routeName;
  static const feedback = FeedbackPage.routeName;
  static const auditResult = AuditResultPage.routeName;
  static const userEditor = UserEditorPage.routeName;
  static const setting = SettingPage.routeName;
  static const userInfo = UserInfoPage.routeName;
  static const userInfoEditor = UserInfoEditorPage.routeName;
  static const accountSafe = AccountSafePage.routeName;
  static const resetPassword = ResetPasswordPage.routeName;
  static const changePassword = ChangePasswordPage.routeName;
  static const photoBrowser = PhotoBrowserPage.routeName;
}