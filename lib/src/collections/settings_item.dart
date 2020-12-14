/// Settings item
class SettingsItem {
  late int auth_login_attempts;
  String? auth_password_policy;
  String? custom_css;
  late int id;
  String? project_color;
  String? project_logo;
  late String project_name;
  late String project_url;
  String? public_background;
  String? public_foreground;
  String? public_note;
  List<_AssetPreset>? storage_asset_presets;

  /// Either `none`, `all` or `presets`
  late String storage_asset_transform;

  SettingsItem({
    required this.auth_login_attempts,
    required this.auth_password_policy,
    required this.custom_css,
    required this.id,
    required this.project_color,
    required this.project_logo,
    required this.project_name,
    required this.project_url,
    required this.public_background,
    required this.public_foreground,
    required this.public_note,
    required this.storage_asset_presets,
    required this.storage_asset_transform,
  });

  SettingsItem.fromMap(Map data) {
    auth_login_attempts = data['auth_login_attempts'];
    auth_password_policy = data['auth_password_policy'];
    custom_css = data['custom_css'];
    id = data['id'];
    project_color = data['project_color'];
    project_logo = data['project_logo'];
    project_name = data['project_name'];
    project_url = data['project_url'];
    public_background = data['public_background'];
    public_foreground = data['public_foreground'];
    public_note = data['public_note'];
    storage_asset_presets = data['storage_asset_presets'];
    storage_asset_transform = data['storage_asset_transform'];
  }
}

class _AssetPreset {
  late String fit;
  late int height;
  late int width;
  late int quality;
  late String key;
  late bool withoutEnlargement;

  _AssetPreset({
    required this.fit,
    required this.height,
    required this.key,
    required this.quality,
    required this.width,
    required this.withoutEnlargement,
  });

  _AssetPreset.fromMap(Map data) {
    fit = data['fit'];
    height = data['height'];
    key = data['key'];
    quality = data['quality'];
    width = data['width'];
    withoutEnlargement = data['withoutEnlargement'];
  }
}
