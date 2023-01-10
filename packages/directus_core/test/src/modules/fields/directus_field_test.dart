import 'package:directus_core/src/modules/fields/directus_field.dart';
import 'package:test/test.dart';

void main() {
  test('DirectusField', () async {
    final field = DirectusField.fromJson({'id': 1});
    expect(field, isA<DirectusField>());
    expect(field.id, 1);
    final fieldMap = field.toJson();
    expect(fieldMap, isMap);
  });
}
