/// Settings item
class SettingsItem {
  int? auth_login_attempts;
  String? auth_password_policy;
  String? custom_css;
  int? id;
  String? project_color;
  String? project_logo;
  String? project_name;
  String? project_url;
  String? public_background;
  String? public_foreground;
  String? public_note;
  List<AssetPreset>? storage_asset_presets;

  /// Either `none`, `all` or `presets`
  late String? storage_asset_transform;

  SettingsItem({
    this.auth_login_attempts,
    this.auth_password_policy,
    this.custom_css,
    this.id,
    this.project_color,
    this.project_logo,
    this.project_name,
    this.project_url,
    this.public_background,
    this.public_foreground,
    this.public_note,
    this.storage_asset_presets,
    this.storage_asset_transform,
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

    final presets = data['storage_asset_presets'];
    if (presets is List) {
      storage_asset_presets = presets.map((preset) => AssetPreset.fromMap(preset)).toList();
    }
  }
}

class AssetPreset {
  late String fit;
  late int height;
  late int width;
  late int quality;
  late String key;
  late bool withoutEnlargement;

  AssetPreset({
    required this.fit,
    required this.height,
    required this.key,
    required this.quality,
    required this.width,
    required this.withoutEnlargement,
  });

  AssetPreset.fromMap(Map data) {
    if (data['fit'].runtimeType != String ||
        data['height'].runtimeType != int ||
        data['width'].runtimeType != int ||
        data['quality'].runtimeType != int ||
        data['key'].runtimeType != String ||
        data['withoutEnlargement'].runtimeType != bool) {
      throw Exception('Asset preset is not valid');
    }

    fit = data['fit'];
    height = data['height'];
    key = data['key'];
    quality = data['quality'];
    width = data['width'];
    withoutEnlargement = data['withoutEnlargement'];
  }
}
