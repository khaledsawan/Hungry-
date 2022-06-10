import 'dart:ui';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_delivery_system/Services/api/api_client.dart';
import 'package:shop_delivery_system/services/model/address_model.dart';

import '../../utils/AppConstants.dart';

class AddressRepo extends GetxService {
  late ApiClient apiClient;
  late SharedPreferences sharedPre;
  AddressRepo({required this.apiClient, required this.sharedPre});

  Future<Response> getAddressfromGeocode(LatLng latLng) async {
    return await apiClient.getData('${AppConstants.GEOCODE_URI}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}');
  }

  String getUserAddress() {
    return sharedPre.getString(AppConstants.USER_ADDRESS) ?? "";
  }

  Future<Response> addAddress(AddressModel addressModel) async {
    return await apiClient.postData(
        AppConstants.ADD_USER_ADDRESS, addressModel);
  }

  Future<Response> getAllAddress() async {
    return await apiClient.getData(AppConstants.ADDRESS_LIST_URI);
  }

  Future<bool> saveUserAddress(String userAddress) async {
    apiClient.updateHeaders(sharedPre.getString(AppConstants.TOKEN)!);
    return await sharedPre.setString(AppConstants.USER_ADDRESS, userAddress);
  }

  Future<Response> getZone(String lat, String lng) async {
    return await apiClient
        .getData('${AppConstants.ZONE_URI}?lat=$lat&lng=$lng');
  }

  Future<Response> searchLocation(String text) async {
    return await apiClient
        .getData('${AppConstants.SEARCH_LOCATION_URI}?search_text=$text');
  }

  Future<Response> setLocation(String placeID) async {
    return await apiClient
        .getData('${AppConstants.PLACE_DETATLS_URI}?placeid=$placeID');
  }
}
