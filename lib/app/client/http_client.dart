import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future get(String url);
}

class HttpClient implements IHttpClient {
  final httpClient = http.Client();
  @override
  Future get(String url) async {
    return httpClient.get(Uri.parse(url));
  }
}
