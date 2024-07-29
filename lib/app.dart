import 'package:flutter/material.dart';
import 'package:flutter_item_tracker/src/items_list/item_view.dart';
import 'package:flutter_item_tracker/src/items_list/items_provider.dart';
import 'package:flutter_item_tracker/src/items_list/items_repo.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    context.read<ItemsRepository>().loadInitailData();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ItemView(),
    );
  }
}
