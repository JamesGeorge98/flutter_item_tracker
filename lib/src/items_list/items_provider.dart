import 'package:flutter_item_tracker/core/base_provider.dart';
import 'package:flutter_item_tracker/core/utils.dart';
import 'package:flutter_item_tracker/src/items_list/items_model.dart';
import 'package:flutter_item_tracker/src/items_list/items_repo.dart';

class ItemsProvider extends BaseProvider {
  ItemsProvider({required ItemsRepository itemsRepository})
      : _itemsRepository = itemsRepository;

  final ItemsRepository _itemsRepository;

  final itemsList = <ItemsModel>[];

  Future<void> getItems() async {
    try {
      setLoader();
      await Future<void>.delayed(Duration.zero);
      final data = await _itemsRepository.fetchItems();
      itemsList
        ..clear()
        ..addAll(data);
    } catch (e) {
      throw Exception('Error while fetcing data');
    } finally {
      setLoader();
    }
  }

  Future<void> putItems({required ItemsModel model}) async {
    try {
      model.id ??= generateID();
      await Future<void>.delayed(Duration.zero);
      if (_itemsRepository.itemsList.contains(model)) {
        final index = _itemsRepository.itemsList.indexWhere(
          (element) => element.id == model.id,
        );
        _itemsRepository.itemsList[index] = model;
      } else {
        _itemsRepository.itemsList.add(model);
      }
    } catch (e) {
      throw Exception('Error while adding data');
    } finally {
      await getItems();
    }
  }

  Future<void> removeItem({required String id}) async {
    try {
      await Future<void>.delayed(Duration.zero);
      _itemsRepository.itemsList.removeWhere((model) => model.id == id);
    } catch (e) {
      throw Exception('Error while remoing data');
    } finally {
      await getItems();
    }
  }
}
