import 'package:directus/src/modules/fields/directus_field.dart';
import 'package:test/test.dart';

void main() {
  test('DirectusField', () async {
    final field = DirectusField.fromJson({'id': 1});
    expect(field, isA<DirectusField>());
    expect(field.id, 1);
    final fieldMap = field.toJson();
    expect(fieldMap, isMap);
  });

  test('FieldConverter', () {
    final converter = FieldConverter();
    final fieldMap = converter.toJson(DirectusField(id: 1));
    expect(fieldMap, isMap);
    final field = converter.fromJson(fieldMap);
    expect(field, isA<DirectusField>());
  });
}
