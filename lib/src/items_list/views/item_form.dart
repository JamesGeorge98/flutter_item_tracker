import 'package:flutter/material.dart';
import 'package:flutter_item_tracker/src/widgets/gap.dart';

class ItemForm extends StatefulWidget {
  const ItemForm({super.key});

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  late final TextEditingController nameController;
  late final TextEditingController descController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descController = TextEditingController();
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Add an item'),
          const Gap(20),
          TextFormField(
            controller: nameController,
          ),
          TextFormField(
            controller: descController,
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Add')),
        ],
      ),
    );
  }
}
