import 'package:directus_core/directus_core.dart';
import 'package:directus_core_example/example_core.dart';

Future<void> main(List<String> arguments) async {
  try {
    final sdk = await getSdkSingleton();
    final res = await sdk
        .items('contacts')
        .createOne({"email": "test_me8@example.com"});
    print(res.data);
    print('success');
  } catch (e) {
    print(2);
    print(e);
    print((e as DirectusError).dioError);
    print((e as DirectusError).additionalInfo);
  }
}
