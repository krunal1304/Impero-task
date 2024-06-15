
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/category_media_provider.dart';

class CategoryWiseListScreen extends StatefulWidget {
  const CategoryWiseListScreen({super.key,});

  @override
  State<CategoryWiseListScreen> createState() => _CategoryWiseListScreenState();
}

class _CategoryWiseListScreenState extends State<CategoryWiseListScreen> {
  late BuildContext buildContext;
  final ScrollController _mainController = ScrollController();
  late int id;


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getCatList();
    });

    _mainController.addListener(() {
      if (_mainController.position.maxScrollExtent - _mainController.position.pixels < 20) {
        _getSubCatList();
      }
    });


  }



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CategoryMediaProvider(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: const [
            Padding(
              padding: const EdgeInsets.only(right: 16,top: 16),
              child: Row(
                children: [
                  Icon(Icons.filter_list_alt,size: 26,color: Colors.white,),
                  SizedBox(width: 10,),
                  Icon(Icons.search,size: 26,color: Colors.white,)
                ],
              ),
            ),
          ],
        ),
        body: Consumer<CategoryMediaProvider>(builder: (context, provider, child){
          buildContext = context;
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 16,),
                height: 50,
                child: ListView.builder(
                  itemCount: provider.categoryList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 50,
                      margin: const EdgeInsets.only(left: 16) ,// Set a fixed height for each item
                      alignment: Alignment.center,  // Center the content of the container
                      child: Text(
                        provider.categoryList[index].Name.toString(),
                        style: TextStyle(
                          fontSize: index == 0 ? 20 : 16,
                          color: index == 0 ? Colors.white : Colors.grey,// Larger font for the first item, smaller for others
                        ),
                        textAlign: TextAlign.center,  // Center the text within the Text widget
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
                  child: SingleChildScrollView(
                    controller: _mainController,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      //padding: const EdgeInsets.only(bottom: 24),
                      shrinkWrap: true,
                      itemCount: provider.subCategoryList.length ,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                provider.subCategoryList[index].name!,
                                style: TextStyle(
                                  fontSize:  16 ,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height: 130,
                              child: ListView.builder(
                                itemCount: provider.subCategoryList[index].productList!.length,
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(right: 16),
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, productIndex) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 8,right: 8),
                                    child: Column(
                                      children: [
                                        Stack(
                                            children:[
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: Container(
                                                  height: 100,
                                                  width: 115,
                                                  //color: Colors.black,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(image: NetworkImage(
                                                          provider.subCategoryList[index].productList![productIndex].imageName!
                                                      ),fit: BoxFit.cover)
                                                  ),
                                                  // child: Image(image: CachedNetworkImageProvider(provider.categoryList[0].SubCategories![index].productList![indexs].imageName!)),
                                                ),
                                              ),
                                              Positioned(
                                                top:10,
                                                left:10,
                                                child: Container(
                                                  width: 40,
                                                  height: 20,
                                                  decoration: const BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius: BorderRadius.all(Radius.circular(2))
                                                  ),
                                                  child: Text(
                                                    provider.subCategoryList[index].productList![productIndex].priceCode!,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize:  12 ,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ]
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8),
                                          child: Text(
                                            provider.subCategoryList[index].productList![productIndex].name!.length > 10 ? provider.subCategoryList[index].productList![productIndex].name!.substring(0,10) : provider.subCategoryList[index].productList![productIndex].name!,
                                            style: const TextStyle(
                                              fontSize:  12 ,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            // BannerAds(isSubscribe: isSubscribe,),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
       })
      )
    );
  }


  _getCatList() {
    Provider.of<CategoryMediaProvider>(buildContext, listen: false).getCategoryData();
  }

  _getSubCatList() {
    Provider.of<CategoryMediaProvider>(buildContext, listen: false).getSubCategoryData();
  }

  _getProductList() {
    Provider.of<CategoryMediaProvider>(buildContext, listen: false).getProduct();
  }



}