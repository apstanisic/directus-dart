import 'package:directus/src/handlers/items_handler.dart';
import 'package:directus/src/handlers/fields_handler.dart';
import 'package:test/test.dart';

import '../mock/mock_dio.dart';

void main() {
  test('that FieldsHandler extends ItemsHandler.', () async {
    final fields = FieldsHandler(client: MockDio());

    expect(fields, isA<ItemsHandler>());
  });
}
