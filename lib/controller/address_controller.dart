import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop_delivery_system/services/api/api_checker.dart';
import 'package:shop_delivery_system/services/repository/address_repo.dart';
import '../Services/model/response_model.dart';
import '../services/model/address_model.dart';
import 'package:google_maps_webservice/places.dart';

class AddressController extends GetxController implements GetxService {
  AddressRepo addressRepo;
  AddressController({required this.addressRepo});

  bool _updateAddressDate = true;
  bool _changeAddress = true;

  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  final List<String> _addressTypeList = ["home", "office", "other"];
  List<String> get addressTypeList => _addressTypeList;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;

  late List<AddressModel> _allAddressList = [];
  List<AddressModel> get allAddressList => _allAddressList;

  bool _loading = false;
  bool get loading => _loading;

  late Position _position;
  Position get position => _position;

  late Position _pickPosition;
  Position get pickPosition => _pickPosition;

  Placemark _placeMark = Placemark();
  Placemark get placeMark => _placeMark;

  Placemark _pickPlaceMark = Placemark();
  Placemark get pickPlaceMark => _pickPlaceMark;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _inZone = false;
  bool get inZone => _inZone;

  bool _buttonDisabled = true;
  bool get buttonDisabled => _buttonDisabled;

  /*
  save the google map suggestions type
   */
  List<Prediction> _predictionList = [];

  List<Prediction> get predictionList => _predictionList;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {

    String _address = "Unknown location found";
    List<Placemark> response = await addressRepo.getAddressfromGeocode(latLng);
    if (true) {
      Placemark placeMark = response[0];
      String? name = placeMark.name;
      String? subLocality = placeMark.subLocality;
      String? locality = placeMark.locality;
      String? administrativeArea = placeMark.administrativeArea;
      String? postalCode = placeMark.postalCode;
      String? country = placeMark.country;
      String? street = placeMark.street;
      _address = "$name,$street,$postalCode, $subLocality, $locality, $administrativeArea , $country";

    }
    update();
    return _address;
  }

  late Map<String, dynamic> _getAddress;

  Map get getAddress => _getAddress;

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressDate) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        } else {
          _pickPosition = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
          update();
        }
        ResponseModel respondMoodle = await getZones(
            position.target.latitude.toString(),
            position.target.longitude.toString(),
            false);
        _buttonDisabled = !respondMoodle.isSuccessful!;
        update();
        if (_changeAddress) {
          String _address = await getAddressFromGeocode(
              LatLng(position.target.latitude, position.target.longitude));
          fromAddress
              ? _placeMark = Placemark(name: _address)
              : _pickPlaceMark = Placemark(name: _address);
        } else {
          _changeAddress = true;
        }
      } catch (e) {
        print(e.toString());
      }
      _loading = false;
      update();
    } else {
      _updateAddressDate = true;
    }
  }

  AddressModel getUserAddress() {
    late AddressModel addressModel;
    _getAddress = jsonDecode(addressRepo.getUserAddress());
    try {
      addressModel = AddressModel.fromjson(_getAddress);
      addressList.add(addressModel);
    } catch (e) {
      print(e);
    }

    return addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading = true;
    update();

    Response response = await addressRepo.addAddress(addressModel);
    ResponseModel responseModel;

    if (response.statusCode == 200) {

      await getAddressList();
      responseModel = ResponseModel(massage: response.body["message"], isSuccessful: true);
      await saveUserAddress(addressModel);
    } else {

      responseModel =
          ResponseModel(isSuccessful: true, massage: response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
    Response response = await addressRepo.getAllAddress();
    if (response.statusCode == 200) {


      _addressList = [];
      _allAddressList = [];
      response.body.forEach((address) {
        _addressList.add(AddressModel.fromjson(address));
        _allAddressList.add(AddressModel.fromjson(address));
      });

    } else {
      _addressList = [];
      _allAddressList = [];
    }
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await addressRepo.saveUserAddress(userAddress);
  }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

  String getUserAddressFromLocalStorage() {
    return addressRepo.getUserAddress();
  }

  void setAddAddressData() {
   _position = _pickPosition;
    _placeMark = _pickPlaceMark;
    _updateAddressDate = false;
    update();
  }

  Future<ResponseModel> getZones(
      String lat, String lng, bool markerLoad) async {
    late ResponseModel _responseModel;
    if (markerLoad) {
      _loading = true;
    } else {
      _isLoading = true;
    }
    update();
    Response response = await addressRepo.getZone(lat, lng);
    if (response.statusCode == 200) {
      _inZone = true;
      _responseModel = ResponseModel(
          massage: response.body["zone_id"].toString(), isSuccessful: true);
    } else {
      _inZone = false;
      _responseModel =
          ResponseModel(isSuccessful: true, massage: response.statusText!);
    }
    if (markerLoad) {
      _loading = false;
    } else {
      _isLoading = false;
    }
    update();
    return _responseModel;
  }

  Future<List<Prediction>> searchLocation(
      BuildContext context, String text) async {
    if (text.isNotEmpty) {
      Response response = await addressRepo.searchLocation(text);
      if (response.statusCode == 200 && response.body['status'] == 'OK') {
        _predictionList = [];
        response.body['predictions'].forEach((prediction) =>
            _predictionList.add(Prediction.fromJson(prediction)));
      } else {
        ApiChecker.checkerApi(response);
      }
    }
    return _predictionList;
  }

  setLocation(String placeId, String address,
      GoogleMapController googleMapController) async {
    _loading = true;
    PlacesDetailsResponse details;
    Response response = await addressRepo.setLocation(placeId);
    details = PlacesDetailsResponse.fromJson(response.body);
    Position(
        latitude: details.result.geometry!.location.lat,
        altitude: 1,
        speed: 1,
        accuracy: 1,
        heading: 1,
        longitude: details.result.geometry!.location.lng,
        speedAccuracy: 1,
        timestamp: DateTime.now());
    _pickPlaceMark = Placemark(name: address);
    _changeAddress = false;
    if (!googleMapController.isNull) {
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(details.result.geometry!.location.lat,
                  details.result.geometry!.location.lng),
              zoom: 17)));
    }
    _loading = false;
    update();
  }
}
