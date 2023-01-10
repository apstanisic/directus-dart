import 'package:directus_core/directus_core.dart';
import 'package:directus_core_example/example_core.dart';

Future<void> main(List<String> arguments) async {
  try {
    final result = await createUser();
    print(1);
    print(result.data);
  } catch (e) {
    print(2);
    print(e);
    print((e as DirectusError).additionalInfo);
  }
}
