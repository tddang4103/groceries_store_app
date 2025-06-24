import 'package:flutter/material.dart';
import 'package:groceries_store_app/models/grocery_item.dart';
import 'package:groceries_store_app/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceriesList extends StatefulWidget {
  const GroceriesList({super.key});

  @override
  State<GroceriesList> createState() => _GroceriesListState();
}

class _GroceriesListState extends State<GroceriesList> {
  final List<GroceryItem> _groceryItems = [];

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  void _loadItem() async {
    final url = Uri.https(
      'flutter-prep-a4eee-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );
    final reponse = await http.get(url);
    print(reponse.body);
  }

  _addItem(BuildContext context, List<GroceryItem> _groceries) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewItem()),
    );
    _loadItem();
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _groceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));
    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder:
            (context, index) => Dismissible(
              onDismissed: (direction) {
                _removeItem(_groceryItems[index]);
              },

              key: ValueKey(_groceryItems[index].id),
              child: ListTile(
                leading: Container(
                  width: 24,
                  height: 24,
                  color: _groceryItems[index].category.color,
                ),
                title: Text(_groceryItems[index].name),
                trailing: Text(_groceryItems[index].quantity.toString()),
              ),
            ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Goceries'),
        actions: [
          IconButton(
            onPressed: () {
              _addItem(context, _groceryItems);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
