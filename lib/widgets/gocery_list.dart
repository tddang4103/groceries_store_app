import 'package:flutter/material.dart';
import 'package:groceries_store_app/data/dummy_items.dart';
import 'package:groceries_store_app/widgets/new_item.dart';

class GroceriesList extends StatelessWidget {
  const GroceriesList({super.key});

  void _addItem(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewItem()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Goceries'),
        actions: [
          IconButton(
            onPressed: () {
              _addItem(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder:
            (context, index) => ListTile(
              leading: Container(
                width: 24,
                height: 24,
                color: groceryItems[index].category.color,
              ),
              title: Text(groceryItems[index].name),
              trailing: Text(groceryItems[index].quantity.toString()),
            ),
      ),
    );
  }
}
