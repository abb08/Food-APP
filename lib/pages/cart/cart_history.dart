import 'package:ecoomerce_dbestech/controllers/cart_controller.dart';
import 'package:ecoomerce_dbestech/utils/colors.dart';
import 'package:ecoomerce_dbestech/utils/constants.dart';
import 'package:ecoomerce_dbestech/utils/dimentions.dart';
import 'package:ecoomerce_dbestech/widgets/bigText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    /*
.reversed  is to make it reverse so the last order appear first
.toList because u want it as a list but reverse turns it into something else
     */

    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<int> itemsPerOrder = cartOrderTimeToList();
    var listCounter = 0;

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            height: 100,
            padding: EdgeInsets.only(top: 45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: 'Your Cart history',
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () {
                    print(itemsPerOrder.toString());
                  },
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: Dimentions.width20, vertical: Dimentions.hight10),
              child: MediaQuery.removePadding(
                context: context,
                child: ListView(
                  children: [
                    for (int i = 0; i < cartItemsPerOrder.length; i++)
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //this is instantly invoked method a way to do logic within the build ((){  teturn widget;}())

                            (() {
                              DateTime parseDate =
                                  DateFormat('yyyy-MM-dd HH:mm:ss').parse(
                                      getCartHistoryList[i].time.toString());
                              var inputData =
                                  DateTime.parse(parseDate.toString());
                              var outputFormat =
                                  DateFormat("MM/dd/yyyy hh:mm a");
                              var outPutDate = outputFormat.format(inputData);
                              return BigText(text: outPutDate);
                            }()),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Wrap(
                                          direction: Axis.horizontal,
                                          children: List.generate(
                                              itemsPerOrder[i], (index) {
                                            if (listCounter <
                                                getCartHistoryList.length) {
                                              listCounter++;
                                            }
                                            return Container(
                                              margin: EdgeInsets.only(
                                                  left: Dimentions.hight10),
                                              height: 80,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimentions.radius15 /
                                                              2),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          AppConstants.baseUrl +
                                                              '/uploads/' +
                                                              getCartHistoryList[
                                                                      listCounter -
                                                                          1]
                                                                  .img!))),
                                            );
                                          }),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 120,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(
                                            text: "Total",
                                            color: Colors.black,
                                            size: Dimentions.font16,
                                          ),
                                          BigText(
                                            text:
                                                "${getCartHistoryList[i].quantity.toString()} Items",
                                            color: Colors.black,
                                            size: Dimentions.font20,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimentions.width10,
                                                vertical:
                                                    Dimentions.hight10 / 2),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimentions.radius15 / 3),
                                              border: Border.all(
                                                  width: 1,
                                                  color: AppColors.mainColor),
                                            ),
                                            child: BigText(
                                              text: "one more",
                                              color: AppColors.mainColor,
                                              size: Dimentions.font16,
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
