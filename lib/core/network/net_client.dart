import 'package:graphql/client.dart';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:http/http.dart';

GraphQLClient getClient(){
  final _httpLink = HttpLink(
    'https://countries.trevorblades.com/',
    httpClient: LoggerHttpClient(Client())
  );

  return GraphQLClient(
    /// pass the store to the cache for persistence
    cache: GraphQLCache(),
    link: _httpLink,
  );
}

class LoggerHttpClient extends BaseClient {
  final Client _client;
  final JsonEncoder _encoder = new JsonEncoder.withIndent('  ');
  final JsonDecoder _decoder = new JsonDecoder();

  LoggerHttpClient(this._client);

  @override
  void close() {
    _client.close();
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    return _client.send(request).then((response) async {
      final responseString = await response.stream.bytesToString();

      String prettyPrint = _encoder.convert(_decoder.convert(responseString));
      final _res = '''
      responseString: $prettyPrint,
      statusCode: ${response.statusCode},
      headers: ${response.headers},
      reasonPhrase: ${response.reasonPhrase},
      persistentConnection: ${response.persistentConnection},
      request: ${response.request.toString()},
      isRedirect: response.isRedirect''';
      developer.log(_res.toString(), name: "http.client");
      return StreamedResponse(ByteStream.fromBytes(utf8.encode(responseString)),
          response.statusCode,
          headers: response.headers,
          reasonPhrase: response.reasonPhrase,
          persistentConnection: response.persistentConnection,
          contentLength: response.contentLength,
          isRedirect: response.isRedirect,
          request: response.request);
    });
  }
}