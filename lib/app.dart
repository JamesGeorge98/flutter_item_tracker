import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_item_tracker/src/items_list/item_view.dart';
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
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => context.read<ItemsRepository>().loadInitailData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    const title = kIsWeb ? 'Item Tracker Web' : 'Item Tracker';
    return const MaterialApp(
      // debugShowMaterialGrid: true,

      debugShowCheckedModeBanner: false,
      title: title,
      home: ItemView(),
    );
  }
}
