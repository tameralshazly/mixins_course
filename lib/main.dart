import 'dart:convert';
import 'dart:developer' as devtools show log;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

void testIt() async {
  final people = await const GetPeople().getString();
  people.log();
}

extension Log on Object {
  void log() => devtools.log(toString());
}

extension GetOnUri on Object {
  Future<HttpClientResponse> getUrl(
    String url,
  ) =>
      HttpClient()
          .getUrl(
            Uri.parse(url),
          )
          .then(
            (request) => request.close(),
          );
}

mixin CanMakeGetCall {
  String get url;

  @useResult
  Future<String> getString() => getUrl(
        url,
      ).then((response) => response
          .transform(
            utf8.decoder,
          )
          .join());
}

@immutable
class GetPeople with CanMakeGetCall {
  const GetPeople();
  @override
  String get url => 'http://172.20.10.5:5500/apis/people.json';
}

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    testIt();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
    );
  }
}
