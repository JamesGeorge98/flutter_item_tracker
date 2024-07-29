import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_item_tracker/src/items_list/items_model.dart';
import 'package:flutter_item_tracker/src/items_list/items_provider.dart';
import 'package:flutter_item_tracker/src/items_list/views/item_form.dart';
import 'package:provider/provider.dart';

class ItemView extends StatefulWidget {
  const ItemView({super.key});

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Tracker'),
      ),
      body: builder(),
      floatingActionButton: fab(),
    );
  }

  Widget builder() {
    return FutureBuilder(
      future: context.read<ItemsProvider>().getItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = snapshot.data ?? [];
        if (data.isEmpty) {
          return const Center(
            child: Text('Add some items'),
          );
        }
        return listView(data);
      },
    );
  }

  Widget listView(List<ItemsModel> data) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) => list(data[index]),
    );
  }

  Widget list(ItemsModel model) {
    return ListTile(
      tileColor: Colors.white,
      title: Text(model.name ?? 'Name'),
      subtitle: Text(model.desc ?? 'Desc'),
    );
  }

  Widget fab() {
    return FloatingActionButton(
      onPressed: openForm,
      child: const Icon(Icons.add),
    );
  }

  void openForm() {
    var width = 300.0;
    if (context.size != null) {
      width = context.size!.width * 0.4;
    }
    if (kIsWeb) {
      showDialog<Widget>(
        context: context,
        builder: (context) => AlertDialog(
          content: SizedBox(
            width: width,
            child: const ItemForm(),
          ),
        ),
      );
      return;
    }

    showModalBottomSheet<Widget>(
      context: context,
      builder: (context) => const ItemForm(),
    );
  }
}
