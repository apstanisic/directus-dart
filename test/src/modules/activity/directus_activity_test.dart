import 'package:directus/src/modules/activity/directus_activity.dart';
import 'package:test/test.dart';

void main() {
  test('DirectusActivity', () async {
    final activity = DirectusActivity.fromJson({'id': 1});
    expect(activity, isA<DirectusActivity>());
    expect(activity.id, 1);
    final activityMap = activity.toJson();
    expect(activityMap, isMap);
  });

  test('ActivityConverter', () {
    final converter = ActivityConverter();
    final activityMap = converter.toJson(DirectusActivity(id: 1));
    expect(activityMap, isMap);
    final activity = converter.fromJson(activityMap);
    expect(activity, isA<DirectusActivity>());
  });
}
