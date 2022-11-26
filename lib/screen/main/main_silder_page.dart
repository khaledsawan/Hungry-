import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_delivery_system/Controller/recommended_products_controller.dart';
import 'package:shop_delivery_system/routes/AppRoutes.dart';
import 'package:shop_delivery_system/Controller/popular_products_controller.dart';
import 'package:shop_delivery_system/utils/AppConstants.dart';
import 'package:shop_delivery_system/utils/colors.dart';
import 'package:shop_delivery_system/widgets/icon_and_text%20widgets/icons_text_widgets.dart';
import 'package:shop_delivery_system/widgets/text/big_text.dart';
import 'package:shop_delivery_system/widgets/text/smail_text.dart';
import '../../Services/model/product_model.dart';


class MainSliderPage extends StatefulWidget {
  const MainSliderPage({Key? key}) : super(key: key);

  @override
  State<MainSliderPage> createState() => _MainSliderPageState();
}

class _MainSliderPageState extends State<MainSliderPage> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  var currPageValue = 0.0;
  @override
  void initState(){
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currPageValue=  _pageController.page!;
      });
    });
  }
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
  late double height;
  late double width;
  late double _height;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    _height = height * 0.40;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          GetBuilder<PopularProductController>(
            builder: (popularController) {
              return !popularController.isLoaded
                  ? Container(margin: const EdgeInsets.only(top: 5),
                padding:const EdgeInsets.only(top:5),
                      height: height * 0.40,
                      color: Colors.white,
                      child: PageView.builder(
                          controller: _pageController,
                          physics: const BouncingScrollPhysics(),
                          itemCount:
                              popularController.popularProductList.length,
                          itemBuilder: (context, index) {
                            return _buildPageItemPopular(index,
                                popularController.popularProductList[index]);
                          }),
                    )
                  :const CircularProgressIndicator(
                      color: AppColors.mainColor,
                    );
            },
          ),
          GetBuilder<PopularProductController>(builder: (popularController) {
            return Container(
              color: Colors.white,
              child: DotsIndicator(
                dotsCount: popularController.popularProductList.isEmpty
                    ? 1
                    : popularController.popularProductList.length,
                position: currPageValue,
                decorator: DotsDecorator(
                  size:const  Size.square(9.0),
                  activeSize:const  Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            );
          }),
          const SizedBox(
            height: 10,
          ),
          GetBuilder<PopularProductController>(builder: (builder) {
            return Container(
              margin: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  BigText(
                    textbody: 'Recommended',
                    color: Colors.black,
                    size: 18,
                  ),
                  SmailText(
                    textbody: ' . ',
                    color: AppColors.textColor,
                    size: 24,
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: SmailText(
                        textbody: 'food pairing',
                        color: AppColors.textColor,
                      )),
                ],
              ),
            );
          }),
          GetBuilder<RecommendedProductsController>(
            builder: (recommended) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recommended.recommendedProductList.length,
                itemBuilder: (context, index) {
                  return _buildPageRecommended(
                      index, recommended.recommendedProductList[index]);
                },
              );
            },
          )
        ],
      ),
    );
  }

  _buildPageRecommended(int index, ProductModal productRecommend) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),

      ),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.RecommendedPage, arguments: productRecommend);
        },
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10, left: 10,top: 5,bottom: 15),

              width: width * 0.33,
              height: height * 0.15,
              decoration: BoxDecoration(
                color:  index.isEven?Colors.cyan:Colors.purple[200],
                image: DecorationImage(
                  image: NetworkImage(AppConstants.BASE_URL +
                      "/uploads/" +
                      productRecommend.img!),
                  fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(textbody: productRecommend.name!),
                  const SizedBox(
                    height: 15,
                  ),
                  SmailText(
                    textbody: 'delivery',
                    color: AppColors.textColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: IconsTextWidgets(
                        food_name: 'normal',
                        location: '33.km',
                        food_timer: '1.7'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildPageItemPopular(int index, ProductModal productPopular) {
    double _scaleFactor = 0.8;
    Matrix4 matrix = Matrix4.identity();
    if (index == currPageValue.floor()) {
      var currScale = 1 - (currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currPageValue.floor() - 1) {
      var currScale = 1 - (currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.PopularPage, arguments: productPopular);
            },
            child: Stack(
              children: [
                Container(
                  height: height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(right: 5, left: 5,bottom:50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(
                            1.0,
                            1.0,
                          ),
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                        ), //BoxShadow
                        BoxShadow(
                          color:  AppColors.white,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                      ],
                      color: index.isEven
                          ? const Color(0xFF69c5df)
                          : const Color(0xFF9294cc),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(AppConstants.BASE_URL +
                            "/uploads/" +
                            productPopular.img!),
                      )),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    width: double.maxFinite,
                    height: 105,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:  AppColors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: AppColors.white,
                              blurRadius: 5.0,
                              offset: Offset(0, 5)),
                          BoxShadow(color: AppColors.white, offset: Offset(-5, 0)),
                          BoxShadow(color:  AppColors.white, offset: Offset(5, 0))
                        ]),
                    child: Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      margin: const EdgeInsets.only(top: 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(productPopular.name!),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Wrap(
                                children: List.generate(
                                    productPopular.stars!,
                                    (index) => const Icon(Icons.star,
                                        color: Colors.cyan, size: 15)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SmailText(
                                  maxline: 1,
                                  textbody: productPopular.stars.toString(),
                                  color: AppColors.textColor),
                              const SizedBox(
                                width: 10,
                              ),
                              SmailText(
                                  maxline: 1,
                                  textbody: "1287 comments",
                                  color: AppColors.textColor)
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          IconsTextWidgets(
                              food_name: 'food type',
                              location: '25.km',
                              food_timer: "2.2"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
