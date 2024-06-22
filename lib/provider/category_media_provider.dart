import 'dart:developer';

import 'package:impero_task/service/api_base.dart';
import '../model/category_model.dart';
import 'base_provider.dart';

class CategoryMediaProvider extends BaseProvider {

  List<CategoryModel> catModel = [];
  int page = 1;
  bool loading = false;
  bool lastPage = false;

 // bool loading = false;
  bool lastPageProduct = false;

  CategoryModel? selectedCategory;
  List<ProductModel> productModel = [];

  getCategoryData() async {
    if (!loading) {
        loading = true;
        notifyListeners();

          Map<String, dynamic> queryParams = {};
          if(selectedCategory != null){
            queryParams["CategoryId"] = selectedCategory?.id;
            queryParams["PageIndex"] = page;
          }else{
            queryParams["CategoryId"] = 0;
            queryParams["DeviceManufacturer"] = "Google";
            queryParams["DeviceModel"] = "Android SDK built for x86";
            queryParams["DeviceToken"] = " ";
            queryParams["PageIndex"] = 1;
          }

      var result = await postData("http://esptiles.imperoserver.in/api/API/Product/DashBoard", queryParams);

      final catList = result.result["Category"] as  List;
      loading = false;

      if (catList.isNotEmpty) {
        if(selectedCategory != null){
          var category = CategoryModel.fromJson(catList.first);
          selectedCategory?.subCatModel.addAll(category.subCatModel);
          page++;
        }else{
          for (var element in catList) {
            catModel.add(CategoryModel.fromJson(element));
          }
          selectCategory(catModel.first);
        }
      }
      notifyListeners();
    }
  }

  selectCategory(CategoryModel categoryModel){
    selectedCategory = categoryModel;
    notifyListeners();
  }

  getProductData(int index) async {


    if (lastPageProduct == false) {

      Map<String, dynamic> queryParams = {};

        queryParams["SubCategoryId"] = selectedCategory?.subCatModel[index].id;
        queryParams["PageIndex"] = selectedCategory?.subCatModel[index].productPage;


        print(queryParams);

      var result = await postData("http://esptiles.imperoserver.in/api/API/Product/ProductList", queryParams);
      print(result.result);


      if(result.result == []){
        print("krunals");
      }else{
        print("vala");
      }


      if (result.result != ""){
        for (var element in result.result) {
          selectedCategory?.subCatModel[index].productList.add(ProductModel.fromJson(element));
        }
        //selectedCategory!.subCatModel[index].loading = false;
        selectedCategory!.subCatModel[index].lastPage == false;
        selectedCategory?.subCatModel[index].productPage++;
      }else{
          print("krunalkjkjk");
          lastPageProduct = true;
      }

      notifyListeners();

    }
  }

}