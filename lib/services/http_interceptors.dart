import 'package:http_interceptor/http_interceptor.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor implements InterceptorContract {
  Logger logger = Logger();

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    logger.v('''
          Resposta de: ${data.baseUrl}\n
          Cabeçalhos: ${data.headers}\n
          Corpo: ${data.body}
        ''');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode ~/ 100 == 2) {
      logger.i('''
          Requisição para: ${data.url}\n
          Status: ${data.statusCode}\n         
          Cabeçalhos: ${data.headers}\n
          Corpo: ${data.body}
        ''');
    } else {
      logger.e('''
          Requisição para: ${data.url}\n
          Status: ${data.statusCode}\n
          Cabeçalhos: ${data.headers}\n
          Corpo: ${data.body}
        ''');
    }
    return data;
  }
}
