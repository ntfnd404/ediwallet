import 'package:http/http.dart' as http;

Future<http.Response> fetchFromServer(String path, String body) async {
  return await http
      .post(
        Uri.parse('https://edison.group/cstest/hs/' + path),
        headers: {
          "Accept": "application/json",
          "Authorization": "Basic bnRmbmQ6dmZuYmttbGY="
        },
        body: body,
      )
      .then((responce) => responce);
}
