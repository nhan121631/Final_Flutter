import 'package:http/http.dart' as http;

class RemoteProfieService {
  var client = http.Client();

  void dispose() {
    client.close();
  }
}