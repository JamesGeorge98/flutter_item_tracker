import 'package:flutter/material.dart';
import 'package:flutter_item_tracker/src/items_list/items_model.dart';
import 'package:flutter_item_tracker/src/items_list/items_provider.dart';
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
      title: Text(model.name ?? 'Name'),
      subtitle: Text(model.desc ?? 'Desc'),
    );
  }
}
