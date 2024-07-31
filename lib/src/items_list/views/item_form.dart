import 'package:flutter/material.dart';
import 'package:flutter_item_tracker/src/items_list/items_model.dart';
import 'package:flutter_item_tracker/src/items_list/items_provider.dart';
import 'package:flutter_item_tracker/src/widgets/gap.dart';
import 'package:provider/provider.dart';

class ItemForm extends StatefulWidget {
  const ItemForm({super.key, this.itemsModel});

  final ItemsModel? itemsModel;

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  late final TextEditingController nameController;
  late final TextEditingController descController;

  late final itemsModel = widget.itemsModel;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descController = TextEditingController();

    if (itemsModel != null) {
      nameController.text = itemsModel?.name ?? 'name';
      descController.text = itemsModel?.desc ?? 'name';
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 40,
        ),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Add An Item'),
              const Gap(20),
              TextFormField(
                controller: nameController,
              ),
              const Gap(30),
              TextFormField(
                controller: descController,
              ),
              const Gap(20),
              ElevatedButton(
                onPressed: () async {
                  final model = ItemsModel(
                    name: nameController.text,
                    desc: descController.text,
                    id: itemsModel?.id,
                  );
                  await context.read<ItemsProvider>().putItems(model: model);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
