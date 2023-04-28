class SettingItemModel {
  const SettingItemModel({
    this.idx,
    this.name
  });

  final int? idx;
  final String? name;
}

class SettingModel {
  ///默认构造函数
  SettingModel({
    this.section,
    this.title,
    this.list
  });

  ///命名构造函数
  SettingModel.initModel({
    this.section,
    this.title,
    List<String>? names
  }){
    List<SettingItemModel> list = [];
    int count = names?.length ?? 0;
    for(int i = 0; i < count; i++){
      list.add(SettingItemModel(idx: i,name: names?[i]));
    }
    this.list = list;
  }

  final int? section;
  late String? title;
  late List<SettingItemModel>? list;

}
