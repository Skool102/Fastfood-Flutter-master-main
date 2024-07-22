import 'package:fastfood/connect/config/storage/sso_storage_data.dart';

class UserDataComponent {
  UserDataComponent();

  Future<String?> getAppToken() {
    return SSOStorageData.getToken();
  }

  Future<void> setAppToken(String token) {
    return SSOStorageData.setToken(token);
  }

  Future<void> setAppUser(String user) {
    return SSOStorageData.setUser(user);
  }

  Future getAppUser() {
    return SSOStorageData.getUser();
  }

  Future<void> removeAppToken() {
    return SSOStorageData.removeToken();
  }

  Future<String> getEncrptedAuthToken() {
    return SSOStorageData.getEncrptedAuthToken();
  }

  Future<void> setEncrptedAuthToken(String encrptedAuthtoken) {
    return SSOStorageData.setEncrptedAuthToken(encrptedAuthtoken);
  }
}
