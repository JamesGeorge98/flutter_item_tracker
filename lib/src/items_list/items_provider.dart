import 'package:flutter_item_tracker/core/base_provider.dart';
import 'package:flutter_item_tracker/src/items_list/items_model.dart';
import 'package:flutter_item_tracker/src/items_list/items_repo.dart';

class ItemsProvider extends BaseProvider {
  ItemsProvider({required ItemsRepository itemsRepository})
      : _itemsRepository = itemsRepository;

  final ItemsRepository _itemsRepository;

  Future<List<ItemsModel>> getItems() async {
    try {
      setLoader();
      await Future<void>.delayed(Duration.zero);
      return _itemsRepository.itemsList;
    } catch (e) {
      throw Exception('Error while fetcing data');
    } finally {
      setLoader();
    }
  }

  Future<void> addItems({required ItemsModel model}) async {
    try {
      setLoader();
      await Future<void>.delayed(Duration.zero);
      _itemsRepository.itemsList.add(model);
    } catch (e) {
      throw Exception('Error while fetcing data');
    } finally {
      setLoader();
    }
  }

  Future<void> removeItem({required String id}) async {
    try {
      setLoader();
      await Future<void>.delayed(Duration.zero);
      _itemsRepository.itemsList.removeWhere((model) => model.id == id);
    } catch (e) {
      throw Exception('Error while fetcing data');
    } finally {
      setLoader();
    }
  }
}
