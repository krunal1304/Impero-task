import '../model/category_model.dart';
import '../service/api_category_list.dart';
import '../service/api_response_status.dart';
import 'base_provider.dart';

class CategoryMediaProvider extends BaseProvider {
  int pageNo = 1;
  bool loading = false;
  bool lastPage = false;
  List<CategoryModel> categoryList = [];
  List<SubCategoriesModel> subCategoryList = [];
  List<ProductModel> productListData = [];
  late int id = 0;

  getCategoryData() async {

    if (!lastPage && !loading) {
      if (pageNo == 1) {
        loading = true;
        categoryList = [];
        notifyListeners();
      } else {
        loading = true;
        notifyListeners();
      }

      Map<String, dynamic> queryParams = {
        "CategoryId":id,
        "DeviceManufacturer":"Google",
        "DeviceModel":"Android SDK built for x86",
        "DeviceToken":" ",
        "PageIndex":1
      };


      ApiCategoryList.getCategoryData(queryParams, (response) {
        if (response.status == Status.COMPLETED) {

          loading  = false;

          final List catList = (response.data['Category'] as List);

          categoryList.addAll(catList
              .map((val) => CategoryModel.fromJson(val))
              .toList());


          if (categoryList.isNotEmpty) {
            id = categoryList[0].Id!;
          }

          if (catList.isEmpty) {
            lastPage = true;
          }
          getSubCategoryData();
          notifyListeners();
        }
      });
    }
  }

  getSubCategoryData() async {

    if (!lastPage && !loading) {
      if (pageNo == 1) {
        loading = true;
        subCategoryList = [];
        notifyListeners();
      } else {
        loading = true;
        notifyListeners();
      }

      Map<String, dynamic> queryParams = {
        "CategoryId":id,
        "PageIndex":pageNo
      };


      ApiCategoryList.getCategoryData(queryParams, (response) {
        if (response.status == Status.COMPLETED) {

          loading  = false;
          pageNo++;

          if(response.data['Category'][0]["SubCategories"] != null) {
            final List catList = (response.data['Category'][0]["SubCategories"] as List);

            subCategoryList.addAll(catList
                .map((val) => SubCategoriesModel.fromJson(val))
                .toList());


            if (categoryList.isNotEmpty) {
              id = categoryList[0].Id!;
            }

            if (catList.isEmpty) {
              lastPage = true;
            }
            notifyListeners();
          }
        }

      });
    }

  }



  getProduct() async {

    if (!lastPage && !loading) {
      if (pageNo == 1) {
        loading = true;
        categoryList = [];
        notifyListeners();
      } else {
        loading = true;
        notifyListeners();
      }

      Map<String, dynamic> queryParams = {
        "SubCategoryId":510,
        "PageIndex":pageNo
      };



      ApiCategoryList.getProductData(queryParams, (response) {
        if (response.status == Status.COMPLETED) {

          loading  = false;
          pageNo++;

          final List productList = (response.data as List);

          productListData.addAll(productList
              .map((val) => ProductModel.fromJson(val))
              .toList());


          if (productList.isEmpty) {
            lastPage = true;
          }
        }
        notifyListeners();

      });
    }



  }


}