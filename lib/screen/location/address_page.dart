import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop_delivery_system/routes/AppRoutes.dart';
import 'package:shop_delivery_system/screen/location/pick_address_map.dart';
import '../../Controller/auth_controller.dart';
import '../../Controller/user_profile_controller.dart';
import '../../controller/address_controller.dart';
import '../../services/model/address_model.dart';
import '../../utils/colors.dart';
import '../../widgets/inputtextform/inputtextform.dart';
import '../../widgets/text/big_text.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  bool _isAuth = false;

  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(45.34, -123.34), zoom: 16);

  late LatLng _initPosition = const LatLng(40.34, -123.34);
  late GoogleMapController googleMapController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AddressController locationController = Get.find<AddressController>();
    _isAuth = Get.find<AuthController>().isAuth();
    if (_isAuth && Get.find<UserProfileController>().userProfileModel == null) {
      Get.find<UserProfileController>().getProfileInfo();
    }



    if (locationController.addressList.isNotEmpty) {
      if (Get.find<AddressController>().getUserAddressFromLocalStorage() ==
          "") {
        Get.find<AddressController>()
            .saveUserAddress(Get.find<AddressController>().addressList.last);
      }

      Get.find<AddressController>().getUserAddress();
      _cameraPosition = CameraPosition(
        target: LatLng(
          double.parse(locationController.getAddress['latitude']),
          double.parse(locationController.getAddress['longitude']),
        ),
      );
      _initPosition = LatLng(
        double.parse(locationController.getAddress['latitude']),
        double.parse(locationController.getAddress['longitude']),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address page"),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserProfileController>(
        builder: (userController) {
          if (userController.userProfileModel != null &&
              _contactNameController.text.isEmpty) {
            _contactNameController.text =
                '${userController.userProfileModel?.fName}';
            _contactNumberController.text =
                '${userController.userProfileModel?.phone}';
            if (Get.find<AddressController>().addressList.isNotEmpty) {
              _addressController.text = Get.find<AddressController>()
                  .getUserAddress()
                  .address
                  .toString();
            }
          }

          return GetBuilder<AddressController>(builder: (addressController) {
            _addressController.text =
                '${addressController.pickPlaceMark.name ?? ''} ${addressController.pickPlaceMark.locality ?? ''} '
                '${addressController.pickPlaceMark.postalCode ?? ''} ${addressController.pickPlaceMark.country ?? ''}';
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    child: Stack(
                      children: [
                        GoogleMap(
                            onMapCreated: (GoogleMapController controller) {
                              googleMapController = controller;
                              addressController.setMapController(controller);
                              if (Get.find<AddressController>()
                                  .addressList
                                  .isEmpty) {}
                            },
                            onTap: (latlng) {
                              Get.toNamed(AppRoutes.AddressPike,
                                  arguments: PickAddressMap(
                                    fromSignup: false,
                                    fromAddress: true,
                                    googleMapController: googleMapController,
                                  ));
                            },
                            initialCameraPosition: CameraPosition(
                              target: _initPosition,
                              zoom: 17.0,
                            ),
                            compassEnabled: false,
                            zoomControlsEnabled: false,
                            indoorViewEnabled: true,
                            mapToolbarEnabled: false,
                            myLocationEnabled: true,
                            onCameraIdle: () {
                              addressController.updatePosition(
                                  _cameraPosition, true);
                            },
                            onCameraMove: (position) {
                              _cameraPosition = position;
                            }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () =>
                              addressController.setAddressTypeIndex(index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).cardColor,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[200]!,
                                    spreadRadius: 1,
                                    blurRadius: 5),
                              ],
                            ),
                            child: Icon(
                              index == 0
                                  ? Icons.home_filled
                                  : index == 1
                                      ? Icons.work
                                      : Icons.location_on,
                              color: addressController.addressTypeIndex == index
                                  ? AppColors.mainColor
                                  : AppColors.textColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding:const EdgeInsets.only(left: 20),
                    child: BigText(
                      textbody: "Delivery Address",
                    ),
                  ),
                  InPutTextForm(
                      icon: Icons.map,
                      hintcolor: Colors.grey,
                      hintText: "Your address",
                      color: AppColors.mainColor,
                      textEditingController: _addressController),
                  const SizedBox(height: 20),
                  Padding(
                    padding:const EdgeInsets.only(left: 20),
                    child: BigText(
                      textbody: "Contact name",
                    ),
                  ),
                  InPutTextForm(
                    icon: Icons.person,
                    hintcolor: Colors.grey,
                    color: AppColors.mainColor,
                    textEditingController: _contactNameController,
                    hintText: 'contact person name ',
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding:const EdgeInsets.only(left: 20),
                    child: BigText(
                      textbody: "Your number",
                    ),
                  ),
                  Container(
                    padding:const EdgeInsets.only(bottom: 15),
                    child: InPutTextForm(
                      textEditingController: _contactNumberController,
                      hintText: "Your number",
                      icon: Icons.phone,
                      color: AppColors.mainColor,
                      hintcolor: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          });
        },
      ),
      bottomNavigationBar:
          GetBuilder<AddressController>(builder: (addressController) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100,
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 20,
                right: 20,
              ),
              decoration:const BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius:  BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {

                      AddressModel _addressModel = AddressModel(
                        addressType: addressController.addressTypeList[
                            addressController.addressTypeIndex],
                        contactPersonName: _contactNameController.text,
                        contactPersonNumber: _contactNumberController.text,
                        address: _addressController.text,
                        latitude:
                            addressController.position.latitude.toString(),
                        longitude:
                            addressController.position.longitude.toString(),
                      );
                     addressController.addAddress(_addressModel).then(
                            (response) => {
                              if (response.isSuccessful!)
                                {
                                  Get.offNamed(AppRoutes.InitHome),
                                  Get.snackbar('Address', 'Added Successfully'),
                                }
                              else
                                {
                                  Get.snackbar(
                                      'Address', "Couldn't save address"),
                                },
                            },
                          );
                    },
                    child: Container(
                      height: 200,
                      width: width * 0.4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.mainColor,
                      ),
                      child: BigText(
                        color: Colors.black,
                        textbody: "Save Address",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
