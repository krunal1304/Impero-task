

class CategoryModel {
  int? Id;
  String? Name;
  List<SubCategoriesModel>? SubCategories = [];

  CategoryModel();

  CategoryModel.fromJson(dynamic json) {
    Id = json['Id'];
    Name = json['Name'];

    if (json['SubCategories'] != null) {
      SubCategories = [];
      json['SubCategories'].forEach((v) {
        SubCategories?.add(SubCategoriesModel.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = Id;
    map['Name'] = Name;

    return map;
  }
}

class SubCategoriesModel {

  int? id;
  String? name;
  List<ProductModel>? productList;


  SubCategoriesModel();

  SubCategoriesModel.fromJson(dynamic json) {
    id = json['Id'];
    name = json['Name'];

    if (json['Product'] != null) {
      productList = [];
      json['Product'].forEach((v) {
        productList?.add(ProductModel.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['Name'] = name;

    return map;
  }
}


class ProductModel {

  String? name;
  String? priceCode;
  String? imageName;


  ProductModel();

  ProductModel.fromJson(dynamic json) {
    name = json['Name'];
    priceCode = json['PriceCode'];
    imageName = json['ImageName'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Name'] = name;
    map['PriceCode'] = priceCode;
    map['ImageName'] = imageName;

    return map;
  }
}