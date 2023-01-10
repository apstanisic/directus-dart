# 0.9.3

- Enable passing map to filter

# 0.9.2

- Fix `directus` not exporting core

# 0.9.1

- Fix case when user can create, but can't read

# 0.9.0

- Split directus and directus_core

# 0.8.2

- Pub analysis fixes

# 0.8.1

- Fix license

# 0.8.0

- Switched to monorepo
- Bug fixes

# 0.7.2

- Fix logout not working

# 0.7.1

- Fix auth not working

# 0.7.0

- Require Dart 2.15
- Added `sdk.auth.staticToken(token)`
- Added `DirectusSingleton`

## 0.6.2

- Require Dart 2.12 stable

## 0.6.1

- Fix Dio interceptors never finishing
- Ensure Flutter is initialized before accessing storage

## 0.6.0

- Null safety
- Fix: filter not applied when query not passed in ItemsHandler readMany

## 0.5.2

- Fix for locking client after failed refresh

## 0.5.1

- Add option to pass a key to Directus (used for multiple auth)

## 0.5.0

- Add meta to Query, and meta property on DirectusListResponse
- Change names of storage fields, they now start with `directus`
- TTL is now in ms

## 0.4.5

- Logout throws if user is not logged in

## 0.4.4

- Update generated files

## 0.4.3

- Add auth hooks
- Improve types

## 0.0.6

- Fix `Filter.notEmpty`
- Added test

## 0.0.5

- Add SettingsItem

## 0.0.4

- Bug fixes

## 0.0.3

- Small fixes
- Added small readme

## 0.0.2

- Added most of the handlers

## 0.0.1

- Initial version, only placeholder
