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
  final List<GlobalKey> currentPostionKey = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => context.read<ItemsProvider>().getItems(),
    );
  }

  double getWidgetPosition(int index) {
    final renderObject = currentPostionKey[index]
        .currentContext
        ?.findRenderObject() as RenderBox?;
    if (renderObject != null) {
      final itemBox = renderObject;
      return itemBox.localToGlobal(Offset.zero).dy;
    }

    return 0;
  }

  double getWidgetSize(int index) {
    final renderObject = currentPostionKey[index]
        .currentContext
        ?.findRenderObject() as RenderBox?;
    if (renderObject != null) {
      final itemBox = renderObject.size;
      return itemBox.width;
    }

    return 0;
  }

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
    return Consumer<ItemsProvider>(
      builder: (context, value, child) {
        currentPostionKey
          ..clear()
          ..addAll(
            List.generate(value.itemsList.length, (index) => GlobalKey()),
          );
        return value.isLoading
            ? const CircularProgressIndicator()
            : listView(value.itemsList);
      },
    );
  }

  Widget listView(List<ItemsModel> data) {
    if (data.isEmpty) {
      return const Center(
        child: Text('Add Items'),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) => list(data[index], index),
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
    );
  }

  Widget list(ItemsModel model, int index) {
    final position = ValueNotifier<double>(0);
    final size = ValueNotifier<double>(0);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      position.value = getWidgetPosition(index);
      size.value = getWidgetSize(index);
    });
    return SizedBox(
      width: index.isEven ? 200 : double.infinity,
      child: ListTile(
        key: currentPostionKey[index],
        tileColor: Colors.white,
        
        title: Text(model.name ?? 'Name'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.desc ?? 'Desc'),
            ValueListenableBuilder(
              valueListenable: position,
              builder: (context, value, child) =>
                  Text('Position : ${position.value}'),
            ),
            ValueListenableBuilder(
              valueListenable: size,
              builder: (context, value, child) => Text('size : ${size.value}'),
            ),
          ],
        ),
        isThreeLine: true,
        trailing: IconButton(
          onPressed: () {
            if (model.id != null && model.id != '') {
              context.read<ItemsProvider>().removeItem(id: model.id!);
            }
          },
          icon: const Icon(Icons.delete),
        ),
      ),
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
      isScrollControlled: true,
      context: context,
      anchorPoint: const Offset(0, 0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => const ItemForm(),
    );
  }
}
