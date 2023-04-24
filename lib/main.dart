import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const _hover = const MethodChannel('kikoba.co.tz/hover');
  String _ActionResponse = 'Waiting for Response...';
  Future<dynamic> sendMoney(var number, money) async {
    var sendMap = <String, dynamic>{
      'number': number,
      'money': money,
    };
// response waits for result from java code
    String? response = "";
    try {
      final String? result = await _hover.invokeMethod('sendMoney', sendMap);
      response = result;
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }
    _ActionResponse = response!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Row(
            children: [
              TextButton(
                onPressed: () async {
                  sendMoney("615379757", "1");
                },
                child: Text("Start Trasaction"),
              ),
              SizedBox(
                height: 18,
              ),
              Center(
                child: Text(_ActionResponse),
              )
            ],
          ),
        ),
      ),
    );
  }
}
