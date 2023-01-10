import 'package:directus_core/src/modules/fields/fields_handler.dart';
import 'package:directus_core/src/modules/items/items_handler.dart';
import 'package:test/test.dart';

import '../../mock/mocks.mocks.dart';

void main() {
  test('that FieldsHandler extends ItemsHandler.', () async {
    final fields = FieldsHandler(client: MockDio());

    expect(fields, isA<ItemsHandler>());
  });
}
