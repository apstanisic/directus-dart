import 'items_converter.dart';

/// Default [ItemsConverter] that converts response to and from [Map].
class MapItemsConverter extends ItemsConverter<Map<String, dynamic>> {
  @override
  Map<String, dynamic> fromJson(Map data) => Map.from(data);

  @override
  Map<String, dynamic> toJson(Map item) => Map.from(item);
}
