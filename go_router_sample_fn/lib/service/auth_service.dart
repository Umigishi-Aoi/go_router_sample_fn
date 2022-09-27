import 'package:firebase_auth/firebase_auth.dart';

/// The service to handle authentication.
/// 
/// "ja"
/// 
/// 認証周りの処理を行うサービス。
class AuthService {
  const AuthService();

  /// The method to get login status.
  /// For go_router v5 redirection, I want to get login status asynchronously.
  /// So I wait 1 second and get login status.
  /// 
  /// "ja"
  /// 
  /// ログイン状態を取得するメソッド
  /// go_router v5のリダイレクトのために非同期でログイン状態を取得したいので、
  /// 1秒待ってログイン状態を取得する。
  Future<bool> isLogin() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return FirebaseAuth.instance.currentUser != null;
  }

  /// The method to login anonymously.
  /// 
  /// "ja"
  /// 
  /// 匿名ログインするメソッド
  Future<void> loginAnonymously() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  /// The method to logout.
  /// 
  /// "ja"
  /// 
  /// ログアウトするメソッド
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
