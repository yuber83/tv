import '../../../domain/models/user/user.dart';
import '../../http/http.dart';

class AccountAPI {
  AccountAPI(this._http);

  final Http _http;

  Future<User?> getAccount(String sessionId) async {
    final result = await _http.request('/account/9658257', headers: {
      'session_id': sessionId,
    }, onSuccess: (json) {
      return User.fromJson(json);
    });

    return result.when(
      left: (_) => null,
      right: (user) => user,
    );
  }
}
