import 'package:flutter/material.dart';
import 'package:flutter_search_module/models/product.dart';
import 'package:flutter_search_module/services/native_search_service.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Product> _products = [];
  bool _isLoading = false;

  final NativeSearchService searchService = NativeSearchService();
  final controller = ScrollController();
  
  void _startSearch(String query) async {
    if (_isLoading) return; // return if a search is already in progress
    setState(() {
      _products.clear();
      _isLoading = true;
    });

    try {
      final newProducts = await searchService.startSearch(query);
      setState(() {
        _products.addAll(newProducts);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        // Handle error, e.g., show a snackbar
      });
      debugPrint('Error during search: $e');
    }
  }

  void _loadNextPage() async {
    if (_isLoading) return; // return if a search is already in progress
    setState(() {
      _isLoading = true;
    });

    try {
      final newProducts = await searchService.loadNextPage();
      setState(() {
        _products.addAll(newProducts);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        // Handle error
      });
      debugPrint('Error loading next page: $e');
    }
  }

  void _navigateToProduct(Product product) async {
  try {
    await searchService.navigateToProduct(product);
  } catch (e) {
    debugPrint('Error navigating to product: $e');
  }
}

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
      _loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false ,
      appBar: AppBar(
        title: const Text('Search Page'),
      ),
      body: _buildUI());
  }

  Widget _buildUI() {
    return SizedBox.expand(
      child: Column(
        children: [
          _searchBar(),
          if (_products.isNotEmpty)_productsListView(),
          if (_products.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 16.0), 
                child: Text('No products found'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.80,
      child: TextField(
        onSubmitted: (value) {
            _startSearch(value);
        },
        decoration: const InputDecoration(
          hintText: "Search...",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _productsListView() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.8,
      width: MediaQuery.sizeOf(context).width,
      child: ListView.builder(
        controller: controller,
        padding: const EdgeInsets.all(8.0),
        itemCount: _products.length + 1,
        itemBuilder: (context, index) {
          if (index < _products.length) {
            final Product product = _products[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
              leading: Image.network(product.images.isNotEmpty ? product.images[0] : ''),
              onTap: () {
                _navigateToProduct(product);
              },
            ); 
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text(''),
              ),
            );
          }
          /* return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            leading: Image.network(product.images.isNotEmpty ? product.images[0] : ''),
            onTap: () {
              searchService.navigateToProduct(product);
            },
          ); */
        },
      ),
    );
  }
}