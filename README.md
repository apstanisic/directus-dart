# Direcuts SDK for Dart/Flutter

---

Unofficial Directus SDK for Dart/Flutter that provides APIs for reading, creating, updating and deleting user and system data, authentication, and access to activity.

## Getting started

Create instance and initialize.

```dart
import 'package:directus/directus.dart';

final sdk = await Directus('http://localhost:8055').init();
```

## Examples

### Using collections

Get item by ID:

```dart
// ID must be `String` because Dart does not have union types.
final res = await sdk.items('users').readOne('someid');
print(res.data['name']);
```

Get many items:

```dart
final res =  await sdk.items('users').readMany(Query(limit: 5, offset: 5));
res.data.forEach((user) => print(user['name']));
```

Create single item:

```dart
final created = await sdk.items('users').createOne({'name': 'Test'});
print(created.data['name']);
```

Create many items:

```dart
final created = await sdk.items('users').createMany([{'name': 'Test'}]);
created.data.forEach((user) => print(user['name']));
```

Update item by ID:

```dart
final updated = await sdk.items('users').updateOne(data: {'name': 'Test'}, id: '55');
print(updated.data['name']);
```

Update many items:

```dart
final updated = await sdk.items('users').updateMany(data: {'name': 'Test'}, ids: ['55']);
created.data.forEach((user) => print(user['name']));
```

Delete item by ID:

```dart
await sdk.items('users').deleteOne('55');
```

Delete many items:

```dart
await sdk.items('users').deleteMany(['55']);
```

### Using system resources:

Most of the system APIs are the same as `items('collection_name')` APIs.
Collections, files, folders, permissions, presets, relations, revisions, roles, settings, users:

```dart
final res = await sdk.files.readMany();
await sdk.folders.deleteOne('some-id');
```

### Auth

Is user logged in:

```dart
final isLoggedIn = sdk.auth.isLoggedIn;
```

Login/logout:

```dart
await sdk.auth.login(email: 'test@example.com', password: 'password');
await sdk.logout();
```

Current user:

```dart
// `currentUser` will be null if user is not logged in.
final user = await sdk.auth.currentUser?.read();
final updatedUser = await sdk.auth.currentUser?.update({'name': 'Dart'});
```

Two factor authentication:

```dart
// `currentUser` will be null if user is not logged in.
await sdk.auth.tfa.enable('current-password');
await sdk.auth.fta.disable('otp');
```

Forgotten password:

```dart
await sdk.auth.forgottenPassword.request('email@example.com');
await sdk.auth.forgottenPassword.reset(token: 'some-token', password: 'password');
```

### Activity

```dart
final activity = await sdk.activity.readOne('some-id');
final activities = await sdk.activity.readMany(Query(limit: 10));

final comment = await sdk.activity.createComment(collection: 'posts',
                  item: 'some-id',
                  comment: 'Awesome post',
                );
final updatedComment = await sdk.activity.updateComment(id: '50', comment: 'Awesome change!');
await sdk.activity.deleteComment('55');


```

### Server

```dart
final pong = await sdk.server.ping();
final info = await sdk.server.info();
final oas = await sdk.server.oas();
```

### Users

```dart
await sdk.users.invite(email: 'test@example.com', role: 'some-uuid');

await sdk.users.inviteMany(emails: ['test@example.com'], role: 'some-uuid');

await sdk.users.acceptInvite(token: 'some-token', password: 'password');
```

### Utils

```dart
final randomString = await sdk.utils.randomString(15);

final hash = await sdk.utils.generateHash('value-to-hash');

final correctHash = await sdk.utils.verifyHash('value-to-hash', 'some-hash');

await sdk.utils.sort(collection: 'users', itemPk: '5', toPk: '10');

await sdk.utils.revert('25');
```
