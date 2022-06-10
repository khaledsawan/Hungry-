import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop_delivery_system/controller/address_controller.dart';
import 'package:shop_delivery_system/routes/AppRoutes.dart';
import 'package:shop_delivery_system/screen/location/Widgets/search_location_dialogue_page.dart';
import '../../utils/colors.dart';
import '../../widgets/button/custom_button.dart';

class PickAddressMap extends StatefulWidget {
  final bool? fromSignup;
  final bool? fromAddress;
  final GoogleMapController? googleMapController;

  const PickAddressMap({
    Key? key,
    required this.fromSignup,
    required this.fromAddress,
    this.googleMapController,
  }) : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.find<AddressController>().addressList.isEmpty) {
      _initialPosition = const LatLng(3.139003, 101.686852);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<AddressController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
          double.parse(Get.find<AddressController>().getAddress['latitude']),
          double.parse(Get.find<AddressController>().getAddress['longitude']),
        );
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(builder: (addressController) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: (GoogleMapController googleMapController) {
                      _mapController = googleMapController;
                    },
                    initialCameraPosition:
                        CameraPosition(target: _initialPosition, zoom: 17),
                    zoomControlsEnabled: false,
                    onCameraMove: (CameraPosition cameraPosition) {
                      _cameraPosition = cameraPosition;
                    },
                    onCameraIdle: () {
                      Get.find<AddressController>()
                          .updatePosition(_cameraPosition, false);
                    },
                  ),
                  Center(
                    child: !addressController.loading
                        ? Image.asset("assets/image/pick_marker.png",
                            height: 50, width: 50)
                        : Center(
                            child: CircularProgressIndicator(
                            color: AppColors.mainColor,
                          )),
                  ),
                  Positioned(
                    top: 45,
                    left: 20,
                    right: 20,
                    child: InkWell(
                      onTap: () {
                        Get.dialog(SearchLocationDialoguePage(
                            MapConroller: _mapController));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.location_on,
                                size: 42, color: AppColors.yellowColor),
                            Expanded(
                                child: Text(
                              addressController.pickplacemark.name ??
                                  'not billing the account',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.search_outlined,
                              color: AppColors.mainColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 60,
                    left: 20,
                    right: 20,
                    child: addressController.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : CustomButton(
                            width: MediaQuery.of(context).size.width - 50,
                            buttonText: addressController.inZone
                                ? widget.fromAddress!
                                    ? 'Pick Address'
                                    : 'Pick Location'
                                : "Service is not available in your area",
                            onPressed: (addressController.buttonDisabled ||
                                    addressController.loading)
                                ? null
                                : () {
                                    if (addressController
                                                .pickPosition.latitude !=
                                            0 &&
                                        addressController.pickplacemark.name !=
                                            null) {
                                      if (widget.fromAddress!) {
                                        if (widget.googleMapController !=
                                            null) {
                                          print("Now you can clicked on this");
                                          addressController.setAddAddressData();
                                          widget.googleMapController!
                                              .moveCamera(CameraUpdate
                                                  .newCameraPosition(
                                                      CameraPosition(
                                                          target: LatLng(
                                            addressController
                                                .pickPosition.latitude,
                                            addressController
                                                .pickPosition.longitude,
                                          ))));
                                          addressController.setAddAddressData();
                                        }
                                        Get.offNamed(
                                            AppRoutes.getAddressPage());
                                      }
                                    }

                                    // Get.back();
                                  },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
