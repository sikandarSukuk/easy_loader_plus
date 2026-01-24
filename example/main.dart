import 'package:easy_loader_plus/easy_loader_plus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Loader Plus Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: EasyLoader.init(),
      home: const MyHomePage(title: 'Easy Loader Plus Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              key: const Key('show_loader_button'),
              onPressed: () async {
                await EasyLoader.show(status: 'Loading...');
                await Future.delayed(const Duration(seconds: 2));
                await EasyLoader.dismiss();
              },
              child: const Text('Show Loader'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              key: const Key('show_success_button'),
              onPressed: () async {
                await EasyLoader.success('Success!');
              },
              child: const Text('Show Success'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              key: const Key('show_error_button'),
              onPressed: () async {
                await EasyLoader.error('Error!');
              },
              child: const Text('Show Error'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              key: const Key('show_info_button'),
              onPressed: () async {
                await EasyLoader.info('Info');
              },
              child: const Text('Show Info'),
            ),
          ],
        ),
      ),
    );
  }
}
