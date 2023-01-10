# Directus SDK for Dart/Flutter

Unofficial Directus SDK for Dart/Flutter that provides APIs for reading, creating, updating and deleting user and system data, authentication, and access to activity. This package is port of SDK for JS from [here](https://github.com/directus/directus/tree/main/packages/sdk-js). Most methods are same as in JS, but there are some differences because of Dart type
system.

## Installation

Add `directus` to `dependencies` in `pubspec.yaml` and run `pub get` or `flutter pub get`.
More info can be found [here](https://pub.dev/packages/directus/install).

## Contributing

Run code bellow before committing. Writing tests is welcomed, but not required.

```sh
flutter test
flutter format .
```

## Getting started

Create instance and initialize. You must run `.init()` for storage to be initialized. Otherwise, there `DirectusError` will be thrown.

### directus

This package requires Flutter since it's using `shared_preferences` for persisting data.

```dart
import 'package:directus/directus.dart';

final sdk = await Directus('http://localhost:8055')
                    .init();
```

### directus_core

This package does not require Flutter, but it does not know how to store data, so you have
to pass it your custom storage that extends `DirectusStorage`. We provide memory storage,
that holds your data in memory while app is live.

```dart
import 'package:directus_core/directus_core.dart';

// Provide your custom storage
final sdk = await DirectusCore('http://localhost:8055', storage: MemoryStorage())
                    .init();
```

## Examples

### Singleton

```dart
import 'package:directus/directus.dart';

await DirectusSingleton.init('http://localhost:8055')
final sdk = DirectusSingleton.instance;
```

### Using collections

#### Get Item by ID:

```dart
// ID must be `String` because Dart does not have union types.
final res = await sdk.items('users').readOne('someId');
print(res.data['name']);
```

#### Get Many Items

```dart
final users =  await sdk.items('users').readMany(Query(limit: 5, offset: 5));
users.data.forEach((user) => print(user['name']));

final firstThreeUsers = await DirectusSdk().items('users').readMany(
      filter: Filters({'id': Filter.isIn(['1', '2'])})
    );
firstThreeUsers.data.forEach((user) => print(user['name']));
```

#### Create Single Item

```dart
final createdUser = await sdk.items('users').createOne({'name': 'Test'});
```

#### Create Many Items

```dart
final createdUsers = await sdk.items('users').createMany([{'name': 'Test'}, {'name': 'Two'}]);
```

#### Update Item by ID

```dart
final updatedUser = await sdk.items('users').updateOne(data: {'name': 'Test'}, id: '55');
```

#### Update Many Items

```dart
final updatedUsers = await sdk.items('users').updateMany(data: {'name': 'Test'}, ids: ['55']);
```

#### Delete Item by ID

```dart
await sdk.items('users').deleteOne('55');
```

#### Delete Many Items

```dart
await sdk.items('users').deleteMany(['55']);
```

---

### Auth

#### Is User Logged In

```dart
final isLoggedIn = sdk.auth.isLoggedIn;
```

#### Login

```dart
await sdk.auth.login(email: 'test@example.com', password: 'password');
```

#### Logout

```dart
await sdk.logout();
```

#### Get Current User

```dart
// `currentUser` will be null if user is not logged in.
final user = await sdk.auth.currentUser?.read();
```

#### Update Current User

```dart
// `currentUser` will be null if user is not logged in.
final updatedUser = await sdk.auth.currentUser?.update({'name': 'Dart'});

```

#### Enable Two Factor Authentication

```dart
// `fta` will be null if user is not logged in.
await sdk.auth.tfa?.enable('current-password');
```

#### Disable 2FA

```dart
// `fta` will be null if user is not logged in.
await sdk.auth.fta?.disable('otp');
```

#### Request a Password Reset

```dart
await sdk.auth.forgottenPassword.request('email@example.com');
```

#### Reset a Password

the token passed in the first parameter is sent in an email to the user when using `request()`.

```dart
await sdk.auth.forgottenPassword.reset(token: 'some-token', password: 'new-password');
```

---

### Activity

#### Read Activity

```dart
final activity = await sdk.activity.readOne('some-id');
final activities = await sdk.activity.readMany(Query(limit: 10));
```

#### Comment

```dart

final comment = await sdk.activity.createComment(collection: 'posts',
                  item: 'some-id',
                  comment: 'Awesome post',
                );
```

#### Change Comment

```dart
final updatedComment = await sdk.activity.updateComment(id: '50', comment: 'Awesome change!');
```

#### Remove comment

```dart
await sdk.activity.deleteComment('55');
```

---

### Collections

Same methods as `sdk.items(collection)`.

```dart
final collections = sdk.collections;
```

---

### Fields

Same methods as `sdk.items(collection)`.

```dart
final fields = sdk.fields;
```

---

### Files

Methods `readOne`, `readMany`, `deleteOne`, `deleteMany` are the same as in `items(collection)`.
There is currently experimental `uploadFile` method that is still not stable.
There are not `updateOne`, `updateMany`, `createOne` and `createMany`.

```dart
final files = sdk.files;
```

---

### Folders

Same methods as `sdk.items(collection)`.

```dart
final folders = sdk.folders;
```

---

### Permissions

Same methods as `sdk.items(collection)`.

```dart
final permissions = sdk.permissions;
```

---

### Presets

Same methods as `sdk.items(collection)`.

```dart
final presets = sdk.presets;
```

---

### Relations

Same methods as `sdk.items(collection)`.

```dart
final relations = sdk.relations;
```

---

### Revisions

Same methods as `sdk.items(collection)`.

```dart
final revisions = sdk.revisions;
```

---

### Roles

Same methods as `sdk.items(collection)`.

```dart
final roles = sdk.roles;
```

---

### Server

#### Ping the Server

```dart
final pong = await sdk.server.ping();
```

#### Get Server/Project Info

```dart
final info = await sdk.server.info();
```

#### Get the API Spec in OAS Format

```dart
final oas = await sdk.server.oas();
```

### Settings

Same methods as `sdk.items(collection)`.

```dart
  final settings = sdk.settings;
```

---

### Users

#### Invite a New User

```dart
await sdk.users.invite(email: 'test@example.com', role: 'some-uuid');
```

#### Invite multiple users

```dart
await sdk.users.inviteMany(emails: ['test@example.com'], role: 'some-uuid');
```

#### Accept a User Invite

```dart
await sdk.users.acceptInvite(token: 'some-token', password: 'secret-password');
```

---

### Utils

#### Get a Random String

```dart
final randomString = await sdk.utils.randomString(15);
```

#### Generate a Hash for a Given Value

```dart
final hash = await sdk.utils.generateHash('value-to-hash');
```

#### Verify if a Hash is Valid

```dart
final correctHash = await sdk.utils.verifyHash('Some value.', 'hashed-value');
```

#### Sort Items in a Collection

This will move item 5 to the position of item 10, and move everything in between one "slot" up

```dart
await sdk.utils.sort(collection: 'users', itemPk: '5', toPk: '10');
```

#### Revert to a Previous Revision

The key passed is the primary key of the revision you'd like to apply

```dart
await sdk.utils.revert('25');
```
