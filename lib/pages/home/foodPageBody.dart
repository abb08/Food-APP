import '/controllers/popularProductsController.dart';
import '/controllers/recomendedController.dart';
import '/models/products_model.dart';
import '/routes/routes_helper.dart';
import '/utils/colors.dart';
import '/utils/constants.dart';
import '/utils/dimentions.dart';
import '/widgets/appColumn.dart';
import '/widgets/bigText.dart';
import '/widgets/icon_and_text_widget.dart';
import '/widgets/smallText.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);

  var _currentPageValue = 0.0;
  var _hight = Dimentions.pageViewContainer;
  double _scaleFactor = 0.8;

  @override
  void initState() {
    ///todo: dispose of the state
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
        GetBuilder<PopularProductsController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
                  height: Dimentions.pageView,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductsList.isEmpty
                          ? 1
                          : popularProducts.popularProductsList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductsList[position]);
                      }),
                )
              : CircularProgressIndicator();
        }),


        //dots indecator
        GetBuilder<PopularProductsController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductsList.isEmpty
                ? 1
                : popularProducts.popularProductsList.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),

        //popular text
        SizedBox(
          height: Dimentions.hight30,
        ),




        //recommended food
        Container(
          margin: EdgeInsets.only(left: Dimentions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recomended'),
              SizedBox(
                width: Dimentions.width10,
              ),
              BigText(
                text: '.',
                color: Colors.black26,
              ),
              SizedBox(
                width: Dimentions.width10,
              ),
              SmallText(
                text: 'Food Pairing',
              )
            ],
          ),
        ),
        //list of food and images
        GetBuilder<RecomendedProductsController>(builder: (recomendedProduct) {
          return recomendedProduct.isLoaded
              ? ListView.builder(
                  //nevrer it scrolls it with the whole page as one //
                  // AlwaysScrollableScrollPhysics() for when u want it independantly scrolling
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // u only need this with the always choice or if u dont wrapp it with container as in now
                  itemCount: recomendedProduct.recommendedProductsList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                          left: Dimentions.width20,
                          right: Dimentions.width20,
                          bottom: Dimentions.hight10),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelpler.getRecommendedFood(index));
                        },
                        child: Row(
                          children: [
                            //image part
                            Container(
                              height: Dimentions.listViewImageSize,
                              width: Dimentions.listViewImageSize,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimentions.radius15),
                                  image: DecorationImage(
                                      image: NetworkImage(AppConstants.baseUrl +
                                          "/uploads/" +
                                          recomendedProduct
                                              .recommendedProductsList[index]
                                              .img
                                              .toString()))),
                            ),
                            // text part
                            Expanded(
                              child: Container(
                                height: Dimentions.listViewTextSize,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight:
                                        Radius.circular(Dimentions.radius15),
                                    bottomRight:
                                        Radius.circular(Dimentions.radius15),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimentions.width10,
                                      right: Dimentions.width10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(
                                          text: recomendedProduct
                                              .recommendedProductsList[index]
                                              .name),

                                      SmallText(
                                          text: recomendedProduct
                                              .recommendedProductsList[index]
                                              .description),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconAndTextWidget(
                                              icon: Icons.circle,

                                              text: 'normal',
                                              iconColor: AppColors.iconColor1),
                                          IconAndTextWidget(
                                              icon: Icons.location_on,
                                              text: '1.7 km',
                                              iconColor: AppColors.mainColor),
                                          IconAndTextWidget(
                                              icon: Icons.access_time_rounded,
                                              text: '32 mis',
                                              iconColor: AppColors.iconColor2),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator(
                  color: AppColors.mainBlackColor,
                );
        })
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    //this whole sectopn along with the vars in the top and the transition widget are just for the scalling effect when u slide
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var curScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _hight * (1 - curScale) / 2;
      matrix = Matrix4.diagonal3Values(1, curScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var curScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _hight * (1 - curScale) / 2;
      matrix = Matrix4.diagonal3Values(1, curScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var curScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _hight * (1 - curScale) / 2;
      matrix = Matrix4.diagonal3Values(1, curScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var curScale = 0.8;
      //in the matrix u only deal with the hight thats why u only adjust the y axis
      //setTransitionRow is so the new size is in the middle rather than it being smaller but still positioned on top like the main one
      matrix = Matrix4.diagonal3Values(1, curScale, 1)
        ..setTranslationRaw(0, _hight * (1 - _scaleFactor) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Get.toNamed(RouteHelpler.getPopularFood(index));
            },
            child: Container(
              height: Dimentions.pageViewContainer,
              //child follows parent hight anyways
              margin: EdgeInsets.only(
                  left: Dimentions.width10, right: Dimentions.width10),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstants.baseUrl +
                        "/uploads/" +
                        popularProduct.img.toString()),
                  ),
                  borderRadius: BorderRadius.circular(Dimentions.radius30),
                  color: Color(0xFF69c5df)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimentions.pageTextContainer,
              //child follows parent hight anyways
              margin: EdgeInsets.only(
                  left: Dimentions.width30,
                  right: Dimentions.width30,
                  bottom: Dimentions.width30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimentions.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0XFFe8e8e8),
                      blurRadius: 5,
                      offset: Offset(0, 5),
                      //offset controllr x,y axis - up of left + down or right
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    ),
                  ]),
              child: Container(
                  padding: EdgeInsets.only(
                      left: Dimentions.hight15,
                      top: Dimentions.hight15,
                      right: Dimentions.hight15),
                  child: AppColumn(
                    text: popularProduct.name.toString(),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
