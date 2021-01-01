import 'items_converter.dart';

/// Default [ItemsConverter] that returns [Map]
class MapItemsConverter extends ItemsConverter<Map<String, dynamic>> {
  @override
  Map<String, dynamic> fromJson(Map data) {
    return Map.from(data);
  }

  @override
  Map<String, dynamic> toJson(Map item) {
    return Map.from(item);
  }
}
