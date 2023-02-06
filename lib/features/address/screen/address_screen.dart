import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/providers/user_provider.dart';

import '../../../common/widgets/custom_textfield.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;

  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = "";
  List<PaymentItem> paymentItems = [];

  @override
  void dispose() {
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }
  }

  @override
  void initState() {
    paymentItems.add(
      PaymentItem(
          amount: widget.totalAmount,
          label: 'Total Amount',
          status: PaymentItemStatus.final_price),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: flatBuildingController,
                      hintText: 'Flat, House no, Building',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: areaController,
                      hintText: 'Area, Street',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: pincodeController,
                      hintText: 'Pincode',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: cityController,
                      hintText: 'Town/City',
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ApplePayConfig(
                      paymentItems: paymentItems,
                      function: () => payPressed(address),
                      addressToBeUsed: addressToBeUsed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ApplePayConfig extends StatefulWidget {
  final List<PaymentItem> paymentItems;
  final Function() function;
  final String addressToBeUsed;

  ApplePayConfig(
      {Key? key,
      required this.paymentItems,
      required this.function,
      required this.addressToBeUsed})
      : super(key: key);

  @override
  State<ApplePayConfig> createState() => _ApplePayConfigState();
}

class _ApplePayConfigState extends State<ApplePayConfig> {
  final Future<PaymentConfiguration> _applePayConfigFuture =
      PaymentConfiguration.fromAsset('gpay.json');
  final AddressServices addressServices = AddressServices();

  void onApplePayResult() {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: widget.addressToBeUsed);
    }
    addressServices.placeOrder(
        context: context,
        address: widget.addressToBeUsed,
        totalSum: double.parse(widget.paymentItems[0].amount));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PaymentConfiguration>(
      future: _applePayConfigFuture,
      builder: (context, snapshot) => snapshot.hasData
          ? GooglePayButton(
              onPressed: (() {
                widget.function();
                onApplePayResult();
              }),
              width: double.infinity,
              paymentConfiguration: snapshot.data!,
              type: GooglePayButtonType.buy,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
              onPaymentResult: (Map<String, dynamic> result) {
                onApplePayResult();
              },
              paymentItems: widget.paymentItems,
              height: 50,
            )
          : Text('Loading'),
    );
  }
}
