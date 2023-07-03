import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:currency_converter_app_flutter/controllers/Provider/amount_modal.dart';
import 'package:currency_converter_app_flutter/controllers/Provider/from_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/Helper/api_Helper.dart';
import '../../controllers/Provider/theme_provider.dart';
import '../../controllers/Provider/to_provider.dart';
import '../../models/globals/globals.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  late Future data;

  @override
  void initState() {
    super.initState();
    data = ApiHelper.apiHelper.CurrencyApi(
      From: Provider.of<FromProvider>(context, listen: false)
          .fromModal
          .FromCountry,
      To: Provider.of<ToProvider>(context, listen: false).toModal.ToCountry,
      amount: Provider.of<AmountProvider>(context, listen: false)
          .amountModal
          .Amount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Welcome",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.lightGreen,
            fontSize: 25,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(
                (Provider.of<ThemeProvider>(context).themeModal.isDark == false)
                    ? Icons.sunny
                    : Icons.wb_sunny_outlined,
                size: 30,
                color: (Provider.of<ThemeProvider>(context).themeModal.isDark ==
                        false)
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Currency\nConverter",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.w700,
                ),
              ),
              //From
              const Padding(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: Text(
                  "From",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              AwesomeDropDown(
                isPanDown: Globals.isPanDown,
                dropDownList: Globals.CountryCode,
                selectedItem: Provider.of<FromProvider>(context, listen: true)
                    .fromModal
                    .FromCountry,
                onDropDownItemClick: (From) {
                  Provider.of<FromProvider>(context, listen: false)
                      .changeFrom(From);
                },
                dropStateChanged: (isOpen) {
                  Globals.isDropdownOpened = isOpen;
                  if (!isOpen) {
                    Globals.isBackPress = false;
                  }
                },
              ),

              //To
              const Padding(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: Text(
                  "To",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              AwesomeDropDown(
                isPanDown: Globals.isPanDown,
                dropDownList: Globals.CountryCode,
                selectedItem: Provider.of<ToProvider>(context, listen: true)
                    .toModal
                    .ToCountry,
                onDropDownItemClick: (To) {
                  Provider.of<ToProvider>(context, listen: false).changeTo(To);
                },
                dropStateChanged: (isOpen) {
                  Globals.isDropdownOpened = isOpen;
                  if (!isOpen) {
                    Globals.isBackPress = false;
                  }
                },
              ),

              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 5, left: 280),
                child: Text(
                  Provider.of<FromProvider>(context, listen: false)
                      .fromModal
                      .FromCountry,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
              TextFormField(
                onChanged: (val) {
                  // setState(() {
                  //   Globals.Amount = int.parse(val);
                  // });
                  Provider.of<AmountProvider>(context, listen: false)
                      .changeAmount(int.parse(val));
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: const Text(
                    "Amount",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  border: OutlineInputBorder(
                    // borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      data = ApiHelper.apiHelper.CurrencyApi(
                        From: Provider.of<FromProvider>(context, listen: false)
                            .fromModal
                            .FromCountry,
                        To: Provider.of<ToProvider>(context, listen: false)
                            .toModal
                            .ToCountry,
                        amount:
                            Provider.of<AmountProvider>(context, listen: false)
                                .amountModal
                                .Amount,
                      );
                    });
                  },
                  child: Container(
                    height: 65,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade800,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      "CONVERT",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 21,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                          ),
                          child: FutureBuilder(
                            future: data,
                            builder: (context, snapShot) {
                              if (snapShot.hasError) {
                                return Text("${snapShot.error}");
                              } else if (snapShot.hasData) {
                                Map? P = snapShot.data;
                                return Text(
                                  "${P!['new_amount']}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              }
                              return const Text(
                                "Result",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Provider.of<ToProvider>(context, listen: false)
                              .toModal
                              .ToCountry,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
