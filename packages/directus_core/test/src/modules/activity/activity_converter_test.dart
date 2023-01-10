import 'package:directus_core/src/modules/activity/activity_converter.dart';
import 'package:directus_core/src/modules/activity/directus_activity.dart';
import 'package:test/test.dart';

void main() {
  test('ActivityConverter', () {
    final converter = ActivityConverter();
    final activityMap = converter.toJson(DirectusActivity(id: 1));
    expect(activityMap, isMap);
    final activity = converter.fromJson(activityMap);
    expect(activity, isA<DirectusActivity>());
  });
}
