import 'package:flutter_item_tracker/core/utils.dart';
import 'package:flutter_item_tracker/src/items_list/items_model.dart';

class ItemsRepository {
  List<ItemsModel> get itemsList => _itemsList;
  final _itemsList = <ItemsModel>[];

  void loadInitailData() {
    for (final modelData in _initialData) {
      _itemsList.add(ItemsModel.fromJSON(modelData));
    }
  }

  List<JSON> get _initialData => <JSON>[
        {
          'name': 'james',
          'desc': 'frontend developer',
          'id': generateID(),
        },
        {
          'name': 'komal',
          'desc': 'backend developer',
          'id': generateID(),
        },
      ];

  Future<List<ItemsModel>> fetchItems() async {
    try {
      await Future<void>.delayed(Duration.zero);
      return _itemsList;
    } catch (e) {
      throw Exception('Error while fetcing data');
    }
  }
}
