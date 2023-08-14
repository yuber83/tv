import '../../domain/models/user.dart';
import '../../domain/repositories/account_repository.dart';
import '../services/local/session_service.dart';
import '../services/remote/account_api.dart';

class AccountRepositoryImpl implements AccountRepository {
  AccountRepositoryImpl(this._accountApi, this._sessionService);

  final SessionService _sessionService;
  final AccountAPI _accountApi;
  @override
  Future<User?> getUserData() async {
    return _accountApi.getAccount(await _sessionService.sessionId ?? '');
  }
}
