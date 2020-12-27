import 'package:directus/src/handlers/items_handler.dart';
import 'package:directus/src/handlers/relations_handler.dart';
import 'package:test/test.dart';

import '../mock/mock_dio.dart';

void main() {
  test('that RelationsHandler extends  ItemsHandler.', () async {
    final relations = RelationsHandler(client: MockDio());

    expect(relations, isA<ItemsHandler>());
  });
}
