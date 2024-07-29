import 'package:flutter_item_tracker/core/utils.dart';

typedef JSON = Map<String, dynamic>;

class ItemsModel {
  ItemsModel({this.desc, this.name, this.id});

  factory ItemsModel.fromJSON(dynamic json) {
    var id = json['id'] as String?;
    id ??= generateID();
    return ItemsModel(
      name: json['name'] as String?,
      desc: json['desc'] as String?,
      id: id,
    );
  }

  String? name;
  String? desc;
  String? id;

  @override
  bool operator ==(covariant ItemsModel other) => other.id == id;
  
  @override
  int get hashCode => id.hashCode;
  
}
