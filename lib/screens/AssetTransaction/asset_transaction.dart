import 'package:fats_client/screens/AssetTransaction/asset_management.dart';
import 'package:fats_client/screens/AssetTransaction/rectify_assets_by_employee.dart';
import 'package:fats_client/screens/AssetVarification/asset_tag_information.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssetTransaction extends StatefulWidget {
  const AssetTransaction({super.key});

  @override
  State<AssetTransaction> createState() => _AssetTransactionState();
}

class _AssetTransactionState extends State<AssetTransaction> {
  Map<String, dynamic> data = {
    "onTap": [
      () {
        Get.to(() => const AssetManagement());
      },
      () {},
      () {},
      () {
        Get.to(() => const RectifyAssetsByEmployee());
      },
      () {},
      () {
        Get.to(() => const AssetTagInformation());
      },
    ],
  };

  String userName = '';
  String userEmail = '';
  String token = '';

  List<String> icons = [
    "assets/asset_movement.png",
    "assets/asset_inventory.png",
    "assets/rectify_assets_by_location.png",
    "assets/rectify_assets_by_employee.png",
    "assets/update_serial_number.png",
    "assets/close.png",
  ];
  List<String> names = [
    "Asset Movement",
    "Asset Inventory",
    "Rectify Assets\nby Location Tags",
    "Rectify Assets\nby Employee",
    "Update Serial Number",
    "Close",
  ];

  Future<void> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.getString('userName') ?? '';
      userEmail = prefs.getString('userEmail') ?? '';
      token = prefs.getString('token') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),
                  Image.asset("assets/images/nartec_logo.png"),
                  Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "Assets Transactions",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        GridView.count(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          childAspectRatio: 1.5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          physics: const BouncingScrollPhysics(),
                          children: List.generate(
                            icons.length,
                            (index) {
                              return ItemWidget(
                                title: names[index],
                                icon: icons[index],
                                onTap: data["onTap"][index],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Back button
              Positioned(
                top: 10,
                left: 10,
                child: CircleAvatar(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemWidget extends StatefulWidget {
  String title;
  String icon;
  VoidCallback onTap;

  ItemWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            widget.icon,
            height: 60,
            width: 60,
          ),
          Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
