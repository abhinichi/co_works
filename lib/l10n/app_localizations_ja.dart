// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'CoWork メンバーログイン';

  @override
  String get appName => 'CoWork';

  @override
  String get memberLogin => 'メンバーログイン';

  @override
  String get loginHeader => 'ログイン';

  @override
  String get loginSubtitle => '資格情報を入力してログインしてください。';

  @override
  String get userIdLabel => 'ユーザーID';

  @override
  String get passwordLabel => 'パスワード';

  @override
  String get rememberMe => 'ログイン状態を保持する';

  @override
  String get forgotPassword => 'パスワードをお忘れですか？';

  @override
  String get signInButton => 'サインイン';

  @override
  String get userIdRequired => 'ユーザーIDを入力してください';

  @override
  String get userIdInvalid => '有効なメールアドレスを入力してください';

  @override
  String get passwordRequired => 'パスワードを入力してください';

  @override
  String get passwordInvalid => 'パスワードは6文字以上で入力してください';

  @override
  String get dontHaveAccount => 'アカウントをお持ちでないですか？ ';

  @override
  String get contactAdmin => '管理者に問い合わせる';

  @override
  String get helpCenter => 'ヘルプセンター';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get copyrightText =>
      '© 2026 CoWork Management Systems. All rights reserved.';

  @override
  String signingInAs(String email) {
    return '$email としてサインイン中...';
  }

  @override
  String get forgotPasswordClicked => 'パスワード再設定リンクがクリックされました';

  @override
  String get contactAdminClicked => '管理者への問い合わせがクリックされました';

  @override
  String get forgotPasswordTitle => 'パスワードをお忘れの場合';

  @override
  String get forgotPasswordInstruction =>
      '登録済みのユーザーIDまたはメールアドレスを入力して、再設定の指示を受け取ってください。';

  @override
  String get emailOrUserIdLabel => 'メールアドレスまたはユーザーID';

  @override
  String get emailOrUserIdPlaceholder => '例: naren@nichi.com';

  @override
  String get sendResetLinkLabel => 'リセットリンクを送信';

  @override
  String get backToLogin => 'ログインに戻る';

  @override
  String get termsOfUse => '利用規約';

  @override
  String resetLinkSent(String email) {
    return '$email にリセットリンクを送信しました';
  }
}
