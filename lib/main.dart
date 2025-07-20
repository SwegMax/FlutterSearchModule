import 'package:flutter/material.dart';
import 'package:flutter_search_module/pages/search_page.dart';

void main() => runApp(const SearchApp());

@pragma('vm:entry-point')
void searchEntryPoint() {
  runApp(const SearchApp());
}

class SearchApp extends StatelessWidget {
  const SearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SearchPage(),
    );
  }
}
