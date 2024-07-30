import 'package:flutter/material.dart';
import 'package:flutter_item_tracker/src/items_list/item_view.dart';
import 'package:flutter_item_tracker/src/items_list/items_provider.dart';
import 'package:flutter_item_tracker/src/items_list/items_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Add Button test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            Provider<ItemsRepository>(
              create: (context) => ItemsRepository(),
            ),
          ],
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider<ItemsProvider>(
                create: (context) => ItemsProvider(
                  itemsRepository: context.read<ItemsRepository>(),
                ),
              ),
            ],
            child: const ItemView(),
          ),
        ),
      ),
    );
    final button = find.byIcon(Icons.add);
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pumpAndSettle();
    expect(find.byType(BottomSheet), findsOneWidget);
    // final findForm = find.byWidget(const ItemForm());
    // expect(findForm, findsOneWidget);
  });
}
