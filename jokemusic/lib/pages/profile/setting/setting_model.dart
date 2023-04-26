class SettingItemModel {
  const SettingItemModel({
    this.idx,
    this.name
  });

  final int? idx;
  final String? name;
}

class SettingModel {
  const SettingModel({
    this.section,
    this.title,
    this.list
  });

  final int? section;
  final String? title;
  final List<SettingItemModel>? list;
}
