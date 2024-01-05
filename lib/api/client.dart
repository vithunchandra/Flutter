import 'package:dio/dio.dart';

Dio getClient (){
  const uri = "https://ws.audioscrobbler.com/2.0/";
  Dio client = Dio();
  client.options.baseUrl = uri;
  return client;
}

dynamic baseParams = {
  "api_key": "1581e3b7afc714d0c23409d637c7d446",
  "format": "json"
};