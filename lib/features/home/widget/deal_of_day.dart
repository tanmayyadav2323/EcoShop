import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/features/product_details/screens/product_detail_screen.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/stars.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealofDay(context: context);
    setState(() {});
  }

  void navigateToDetailsScreen() {
    Navigator.of(context)
        .pushNamed(ProductDetailScreen.routeName, arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigateToDetailsScreen,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 15,
                      ),
                      child: const Text(
                        'Top Sellers',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Image.network(
                              product!.images[0],
                              height: 200,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Container(
                            height: 200,
                            width: 1,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                product!.name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "₹" + product!.price.toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    // Container(
                    //   alignment: Alignment.topLeft,
                    //   padding: const EdgeInsets.only(left: 15),
                    //   child: Text(
                    //     '₹${product!.price}',
                    //     style: const TextStyle(fontSize: 18),
                    //   ),
                    // ),
                    // Container(
                    //   alignment: Alignment.topLeft,
                    //   padding:
                    //       const EdgeInsets.only(left: 15, top: 5, right: 40),
                    //   child: Text(
                    //     product!.name,
                    //     maxLines: 2,
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    // ),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: product!.images
                    //         .map(
                    //           (e) => Image.network(
                    //             e,
                    //             fit: BoxFit.fitWidth,
                    //             width: 100,
                    //             height: 100,
                    //           ),
                    //         )
                    //         .toList(),
                    //   ),
                    // ),
                    // Container(
                    //   padding:
                    //       const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                    //   alignment: Alignment.topLeft,
                    //   child: Text(
                    //     'See all deals',
                    //     style: TextStyle(
                    //       color: Colors.cyan[800],
                    //     ),
                    //   ),
                    // )
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
  }
}
