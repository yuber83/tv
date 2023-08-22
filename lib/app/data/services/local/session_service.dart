import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'sessionId';
const _accountKey = 'accountId';

class SessionService {
  SessionService(this._flutterSecureStorage);

  final FlutterSecureStorage _flutterSecureStorage;

  Future<String?> get sessionId => _flutterSecureStorage.read(key: _key);

  Future<String?> get accountId => _flutterSecureStorage.read(key: _accountKey);

  Future<void> saveSessionId(String sessionId) => _flutterSecureStorage.write(
        key: _key,
        value: sessionId,
      );

  Future<void> saveAccountId(String id) => _flutterSecureStorage.write(
        key: _accountKey,
        value: id,
      );

  Future<void> singOut() => _flutterSecureStorage.deleteAll();
}
