

class CategoryModel {

  int? id;
  String name = "";
  List<SubCategoriesModel> subCatModel = [];

  CategoryModel();

  CategoryModel.fromJson(dynamic json){
    id = json["Id"];
    name = json["Name"];

   if (json["SubCategories"] != null){
     subCatModel = [];

     for (var element in json["SubCategories"]){
       subCatModel?.add(SubCategoriesModel.fromJson(element));
     }

   }


  }

}

class SubCategoriesModel {

  int? id;
  String name = "";
  List<ProductModel> productList = [];
  int? page;
  bool lastPage = false;
  bool loading = false;
  int productPage = 2;

  SubCategoriesModel();

  SubCategoriesModel.fromJson(dynamic json){
    id = json["Id"];
    name = json["Name"];

    if (json["Product"] != null) {

      for (var element in json["Product"]){
        productList.add(ProductModel.fromJson(element));
      }
    }

  }

}

class ProductModel {

  String priceCode = "";
  String imageName = "";
  String name = "";

  ProductModel();

  ProductModel.fromJson(dynamic json) {
    priceCode = json["PriceCode"];
    imageName = json["ImageName"];
    name = json["Name"];
  }

}