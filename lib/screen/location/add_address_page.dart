// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:shop_delivery_system/Controller/user_profile_controller.dart';
// import '../../controller/auth_controller.dart';
// import '../../controller/location_controller.dart';
// import '../../utils/colors.dart';
// import '../../widgets/inputtextform/inputtextform.dart';
// import '../../widgets/text/big_text.dart';
//
//
// class AddAddressPage extends StatefulWidget {
//   const AddAddressPage({Key? key}) : super(key: key);
//
//   @override
//   State<AddAddressPage> createState() => _AddAddressPageState();
// }
//
// class _AddAddressPageState extends State<AddAddressPage> {
//   TextEditingController _addressController = TextEditingController();
//   final TextEditingController _contactPersonName = TextEditingController();
//   final TextEditingController _contactPersonNumber = TextEditingController();
//   late bool _isLogged;
//   late CameraPosition _cameraPosition;
//   late LatLng _initialPosition;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     final locationController = Get.find<LocationController>();
//     _isLogged = Get.find<AuthController>().isAuth();
//     if (_isLogged && Get.find<UserProfileController>().userProfileModel == null) {
//       Get.find<UserProfileController>().getProfileInfo();
//     }
//     if (locationController.addressList.isNotEmpty) {
//       return;
//     }//Get.find<LocationController>().getUserAddressFromLocalStorage() != ""
//     if (true) {
//      // Get.find<LocationController>().saveUserAddress(Get.find<LocationController>().addressList.last);
//      // Get.find<LocationController>().getUserAddress();
//       _cameraPosition = CameraPosition(
//         target: LatLng(
//           double.parse(locationController.getAddress['latitude']),
//           double.parse(locationController.getAddress['longitude']),
//         ),
//       );
//       _initialPosition = LatLng(
//         double.parse(locationController.getAddress['latitude']),
//         double.parse(locationController.getAddress['longitude']),
//       );
//     } else {
//       _initialPosition = const LatLng(3.139003, 101.686852);
//       _cameraPosition = const CameraPosition(
//         target: LatLng(3.139003, 101.686852),
//         zoom: 17,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Address Page"),
//       ),
//       body: GetBuilder<UserProfileController>(builder: (userController) {
//         if (userController.userProfileModel != null && _contactPersonName.text.isEmpty) {
//           _contactPersonName.text = '${userController.userProfileModel?.fName}';
//           _contactPersonNumber.text = '${userController.userProfileModel?.phone}';
//           if (Get.find<LocationController>().addressList.isNotEmpty) {
//            // _addressController.text = Get.find<LocationController>().getUserAddress().address;
//           }
//         }
//         return GetBuilder<LocationController>(builder: (locationController) {
//           _addressController.text = '${locationController.placemark.name ?? ''}'
//               '${locationController.placemark.locality ?? ''}'
//               '${locationController.placemark.postalCode ?? ''}'
//               '${locationController.placemark.country ?? ''}';
//           debugPrint('address in my view is ${_addressController.text}');
//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   height: 200,
//                   width: MediaQuery.of(context).size.width,
//                   margin: EdgeInsets.only(left: 5 , right:  5, top: 5),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(
//                       width: 2,
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                   ),
//                   child: Stack(
//                     children: [
//                       GoogleMap(
//                         onMapCreated: (GoogleMapController controller) {
//                           locationController.setMapController(controller);
//                           if (Get.find<LocationController>().addressList.isEmpty) {
//                             //locationController.get
//                           }
//                         },
//                         initialCameraPosition: CameraPosition(
//                           target: _initialPosition,
//                           zoom: 17.0,
//                         ),
//                         // onTap: (latlng) {
//                         //   Get.offNamed(RouteHelper.getPickAddressPage(),
//                         //       arguments: PickAddressMap(
//                         //         fromSignup: false,
//                         //         fromAddress: true,
//                         //         googleMapController: locationController.mapController,
//                         //       ));
//                         // },
//                         compassEnabled: false,
//                         zoomControlsEnabled: false,
//                         indoorViewEnabled: true,
//                         mapToolbarEnabled: false,
//                         myLocationEnabled: true,
//                         onCameraIdle: () {
//                           locationController.updatePosition(_cameraPosition, true);
//                         },
//                         onCameraMove: (position) => _cameraPosition = position,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 20, top: 20),
//                   child: SizedBox(
//                     height: 50,
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       scrollDirection: Axis.horizontal,
//                       itemCount: locationController.addressTypeList.length,
//                       itemBuilder: (context, index) => InkWell(
//                         onTap: () => locationController.setAddressTypeIndex(index),
//                         child: Container(
//                           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                           margin: EdgeInsets.only(right: 10),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: Theme.of(context).cardColor,
//                             boxShadow: [
//                               BoxShadow(color: Colors.grey[200]!, spreadRadius: 1, blurRadius: 5),
//                             ],
//                           ),
//                           child: Icon(
//                             index == 0
//                                 ? Icons.home_filled
//                                 : index == 1
//                                 ? Icons.work
//                                 : Icons.location_on,
//                             color: locationController.addressTypeIndex == index ? Theme.of(context).colorScheme.primary : Theme.of(context).disabledColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Padding(
//                   padding: EdgeInsets.only(left: 20),
//                   child: BigText(
//                     textbody: "Delivery Address",
//
//                   ),
//                 ),
//                 InPutTextForm(icon: Icons.map, hintcolor: Colors.grey, hintText: "Your address", color: AppColors.mainColor, textEditingController: _addressController),
//                 SizedBox(height: 20),
//                 Padding(
//                   padding: EdgeInsets.only(left: 20),
//                   child: BigText(
//                     textbody: "Contact name",
//
//                   ),
//                 ),
//                 InPutTextForm(icon: Icons.person, hintcolor: Colors.grey, color: AppColors.mainColor, textEditingController: _contactPersonName, hintText: 'contact person name ',),
//                 SizedBox(height: 20),
//                 Padding(
//                   padding: EdgeInsets.only(left: 20),
//                   child: BigText(
//                     textbody: "Your number",
//
//                   ),
//                 ),
//                 InPutTextForm(textEditingController: _contactPersonNumber, hintText: "Your number", icon: Icons.phone, color: AppColors.mainColor, hintcolor: Colors.grey,),
//               ],
//             ),
//           );
//         });
//       }),
//       // bottomNavigationBar: GetBuilder<LocationController>(builder: (locationController) {
//       //   return Column(
//       //     mainAxisSize: MainAxisSize.min,
//       //     children: [
//       //       Container(
//       //         height: Dimensions.height20 * 7,
//       //         padding: EdgeInsets.only(
//       //           top: Dimensions.height30,
//       //           bottom: Dimensions.height30,
//       //           left: Dimensions.width20,
//       //           right: Dimensions.width20,
//       //         ),
//       //         decoration: BoxDecoration(
//       //           color: AppColors.buttonBackgroundColor,
//       //           borderRadius: BorderRadius.only(
//       //             topLeft: Radius.circular(Dimensions.radius20 * 2),
//       //             topRight: Radius.circular(Dimensions.radius20 * 2),
//       //           ),
//       //         ),
//       //         child: Row(
//       //           mainAxisAlignment: MainAxisAlignment.center,
//       //           children: [
//       //             GestureDetector(
//       //               onTap: () {
//       //                 AddressModel _addressModel = AddressModel(
//       //                   addressType: locationController.addressTypeList[locationController.addressTypeIndex],
//       //                   contactPersonName: _contactPersonName.text,
//       //                   contactPersonNumber: _contactPersonNumber.text,
//       //                   address: _addressController.text,
//       //                   latitude: locationController.position.latitude.toString(),
//       //                   longitude: locationController.position.longitude.toString(),
//       //                 );
//       //                 locationController.addAddress(_addressModel).then(
//       //                       (response) => {
//       //                     if (response.isSuccess)
//       //                       {
//       //                         ///this code should be fit UX, commented due to the class unfinished yet
//       //                         //Get.back();
//       //                         Get.offNamed(RouteHelper.getInitial()),
//       //                         Get.snackbar('Address', 'Added Successfully'),
//       //                       }
//       //                     else
//       //                       {
//       //                         Get.snackbar('Address', "Couldn't save address"),
//       //                       },
//       //                   },
//       //                 );
//       //               },
//       //               child: Container(
//       //                 padding: EdgeInsets.only(
//       //                   top: Dimensions.height20,
//       //                   bottom: Dimensions.height20,
//       //                   left: Dimensions.width20,
//       //                   right: Dimensions.width20,
//       //                 ),
//       //                 decoration: BoxDecoration(
//       //                   borderRadius: BorderRadius.circular(Dimensions.radius20),
//       //                   color: Theme.of(context).colorScheme.primary,
//       //                 ),
//       //                 child: BigText(
//       //                   text: "Save Address",
//       //                   color: Colors.white,
//       //                   size: Dimensions.font26,
//       //                 ),
//       //               ),
//       //             ),
//       //           ],
//       //         ),
//       //       ),
//       //     ],
//       //   );
//       // }),
//     );
//   }
// }
