import 'package:flutter/material.dart';
import 'package:flutter_item_tracker/app.dart';
import 'package:flutter_item_tracker/src/items_list/items_provider.dart';
import 'package:flutter_item_tracker/src/items_list/items_repo.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ProviderInjection());
}

class ProviderInjection extends StatelessWidget {
  const ProviderInjection({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ItemsRepository>(
          create: (context) => ItemsRepository(),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ItemsProvider>(
            create: (context) =>
                ItemsProvider(itemsRepository: context.read<ItemsRepository>()),
          ),
        ],
        child: const App(),
      ),
    );
  }
}
