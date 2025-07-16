import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
      ),
      body: _buildUI());
  }

  Widget _buildUI() {
    return SizedBox.expand(
      child: Column(
        children: [
          _productsListView(),
        ],
      ),
    );
  }

  Widget _productsListView() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.8,
      width: MediaQuery.sizeOf(context).width,
      child: ListView.builder(
        itemCount: 0,
        itemBuilder: (context, index) {},
      ),
    );
  }
}