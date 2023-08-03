import 'dart:convert';

import 'package:flutter_webapi_first_course/models/journal.dart';
import 'package:flutter_webapi_first_course/services/http_interceptors.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

class JournalService {
  static const String url = "http://192.168.40.102:3000/";
  static const String resource = "journals/";

  http.Client client =
      InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  String getUrl() {
    return "$url$resource";
  }

  Future<bool> register(Journal journal) async {
    String jsonJournal = jsonEncode(journal.toMap());

    http.Response response = await client.post(
      Uri.parse(getUrl()),
      headers: {"Content-Type": "application/json"},
      body: jsonJournal,
    );
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<List<Journal>> getAll() async {
    http.Response response = await client.get(Uri.parse(getUrl()));

    if (response.statusCode != 200) {
      throw Exception("Error while fetching journals");
    }

    List<Journal> list = [];

    List<dynamic> listDynamic = jsonDecode(response.body);

    for (var element in listDynamic) {
      list.add(Journal.fromMap(element));
    }
    return list;
  }
}
