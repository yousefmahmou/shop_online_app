class CategoriesModel {
  late bool status;
  late CategoriesDataModel data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  late int current_page;
  late List<DataModel> data = [];
  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];

    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
    data = json['data'];
  }
}

class DataModel {
  late int id;
  late String image;
  late String name;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['id'];
    name = json['name'];
  }
}
