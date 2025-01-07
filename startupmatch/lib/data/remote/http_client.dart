import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class MyHttpClient {
  String token;
  String baseUrl;
  String lang;
  Map<String, String> headers = {
    "Accept": "application/json",
  };

  MyHttpClient({
    this.token = "undefined",
    required this.baseUrl,
    required this.lang,
  }) {
    if (token != "undefined") {
      headers = {
        "Accept": "application/json",
        "Authorization": token,
      };
    }
    lang = lang.replaceAll("_", "-").replaceAll("EN", "US");
  }

  void setToken(String newToken) {
    token = newToken;
    headers = {
      "Accept": "application/json",
      "Authorization": newToken,
    };
  }

  Future<http.Response> get(String url, {String customLang = "default"}) async {
    headers.remove("Content-Length");
    String requestLang = customLang == "default" ? lang : customLang;
    http.Response response = await http.get(
      Uri.parse(baseUrl +
          url +
          (url.contains("?") ? "&l=$requestLang" : "?l=$requestLang")),
      headers: headers,
    );
    return response;
  }

  Future<http.Response> post(String url,
      {body, String customLang = "default"}) async {
    String requestLang = customLang == "default" ? lang : customLang;
    http.Response response = await http.post(
      Uri.parse(baseUrl +
          url +
          (url.contains("?") ? "&l=$requestLang" : "?l=$requestLang")),
      body: body,
      headers: headers,
    );
    return response;
  }

  Future<http.Response> multipartPost(
    String url, {
    required Map<String, dynamic> body,
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl + url));
    request.headers.addAll(headers);
    for (var key in body.keys.toList()) {
      dynamic value = body[key];
      if (value.runtimeType.toString() == "_File") {
        final mimeTypeData =
            lookupMimeType(value.path, headerBytes: [0xFF, 0xD8])!.split('/');
        print("MIME: $mimeTypeData");
        request.files.add(
          await http.MultipartFile.fromPath(
            key,
            value.path,
            contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
          ),
        );
      }
      if (value.runtimeType.toString() == "String") {
        request.fields[key] = value;
        print(key);
      }
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return response;
  }
}
