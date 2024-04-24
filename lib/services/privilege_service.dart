import 'package:piaoxingqiu/helpers/headers.dart';
import 'package:piaoxingqiu/services/shared_prefrences_service.dart';

class PrivilegeService {
  Map<String, String> getHeaders() {
    String? accessToken = SharedPreferencesService().accessToken;
    return createHeaders(accessToken);
  }
}
