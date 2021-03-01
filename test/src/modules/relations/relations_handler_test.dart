import 'package:directus/src/modules/items/items_handler.dart';
import 'package:directus/src/modules/relations/relations_handler.dart';
import 'package:test/test.dart';

import '../../mock/mocks.mocks.dart';

void main() {
  test('that RelationsHandler extends  ItemsHandler.', () async {
    final relations = RelationsHandler(client: MockDio());

    expect(relations, isA<ItemsHandler>());
  });
}
