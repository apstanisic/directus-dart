import 'items_converter.dart';

/// Default [ItemsConverter] that converts response to and from [Map].
class MapItemsConverter extends ItemsConverter<Map<String, Object?>> {
  @override
  Map<String, Object?> fromJson(Map data) => Map.from(data);

  @override
  Map<String, Object?> toJson(Map data) => Map.from(data);
}
