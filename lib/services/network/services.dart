import 'package:either_dart/either.dart';
import 'package:elaveoironing_vendor/datamodel/count_datamodel.dart';
import 'package:elaveoironing_vendor/datamodel/getcomplaint_datamodel.dart';
import 'package:elaveoironing_vendor/datamodel/pending_datamodel.dart';
import 'package:elaveoironing_vendor/datamodel/profile_datamodel.dart';
import 'package:elaveoironing_vendor/datamodel/report_datamodel.dart';
import 'package:elaveoironing_vendor/datamodel/version_datamodel.dart';
import 'package:elaveoironing_vendor/res/app_config.dart';
import 'package:elaveoironing_vendor/services/network/api_request.dart';
import 'package:elaveoironing_vendor/services/network/base_services.dart';
import 'package:elaveoironing_vendor/services/network/reponse_error.dart';

class Services implements BaseServices {
  @override
  Future<Either<ResponseError, dynamic>> logIn(
      {String? phone, String? password}) {
    final body = {"mobile": phone, "password": password};
    return safe(
            postRequest(endPoint: "${AppConfig.middleurl}login", body: body))
        .thenRight(checkHttpStatus)
        .thenRight(parseJson)
        .mapRight((right) {
      print(right);
      return right;
    });
  }

  @override
  Future<Either<ResponseError, PendingDatamodel>> pending({
    int? status,
  }) {
    final body = {
      "status": status,
    };
    return safe(postRequestWithToken(endPoint: "pendingOrders", body: body))
        .thenRight(checkHttpStatus)
        .thenRight(parseJson)
        .mapRight((right) {
      print(right);
      return PendingDatamodel.fromJson(right);
    });
  }

  @override
  Future<Either<ResponseError, dynamic>> changestatus(
      {int? status, int? orderid}) {
    final body = {"status": status, "order_id": orderid};
    return safe(postRequestWithToken(endPoint: "updateOrders", body: body))
        .thenRight(checkHttpStatus)
        .thenRight(parseJson)
        .mapRight((right) {
      print(right);
      return right;
    });
  }

  @override
  Future<Either<ResponseError, dynamic>> updateactive({int? status}) {
    final body = {"status": status, "store_id": AppConfig.id};
    print(body);
    return safe(postRequestWithToken(endPoint: "updateActive", body: body))
        .thenRight(checkHttpStatus)
        .thenRight(parseJson)
        .mapRight((right) {
      print(right);
      return right;
    });
  }

  @override
  Future<Either<ResponseError, ReportDatamodel>> report(
      {String? fromdata, String? todate}) {
    final body = {"date_from": fromdata, "date_to": todate};
    return safe(postRequestWithToken(endPoint: "orderReport", body: body))
        .thenRight(checkHttpStatus)
        .thenRight(parseJson)
        .mapRight((right) {
      print(right);
      return ReportDatamodel.fromJson(right);
    });
  }

  @override
  Future<Either<ResponseError, dynamic>> logout() {
    // final body = {
    //   "delivery_agent_id": AppConfig.id,
    // };
    return safe(postRequestWithToken(endPoint: "logout"))
        .thenRight(checkHttpStatus)
        .thenRight(parseJson)
        .mapRight((right) {
      print(right);
      return right;
    });
  }

  @override
  Future<Either<ResponseError, dynamic>> locationupdate(
      {double? latitude, double? longitude}) {
    final body = {"lattittude": latitude, "longitude": longitude};
    return safe(putRequestWithToken(endPoint: "location", body: body))
        .thenRight(checkHttpStatus)
        .thenRight(parseJson)
        .mapRight((right) {
      print(right);
      return right;
    });
  }

  @override
  Future<Either<ResponseError, dynamic>> complaint(
      {int? orderid, int? shopid, String? desc, int? orderitemid}) {
    print({
      "shopkeeper_id": AppConfig.id,
      "order_id": orderid,
      "description": desc,
      if (orderitemid != null) "order_item_id": orderitemid
    });
    return safe(postRequest(endPoint: "api/v1/customer/order-feedback", body: {
      "shopkeeper_id": AppConfig.id,
      "order_id": orderid,
      "description": desc,
      "order_item_id": orderitemid
    })).thenRight(checkHttpStatus).thenRight(parseJson).mapRight((right) {
      return right;
    });
  }

  @override
  Future<Either<ResponseError, GetcomplaintDatamodel>> getcomplaint(
      {int? orderid, int? shopid}) {
    return safe(postRequest(
            endPoint: "api/v1/customer/get-order-feedback",
            body: {"order_id": orderid}))
        .thenRight(checkHttpStatus)
        .thenRight(parseJson)
        .mapRight((right) {
      return GetcomplaintDatamodel.fromJson(right);
    });
  }

  @override
  Future<Either<ResponseError, CountDatamodel>> getcount() {
    return safe(getRequestWithToken(
      endPoint: "orders/count",
    )).thenRight(checkHttpStatus).thenRight(parseJson).mapRight((right) {
      return CountDatamodel.fromJson(right);
    });
  }

  @override
  Future<Either<ResponseError, VersionDatamodel>> getversion() {
    return safe(
            getRequestWithTokenversion(endPoint: "api/store-keeper/version"))
        .thenRight(checkHttpStatus)
        .thenRight(parseJson)
        .mapRight((right) {
      return VersionDatamodel.fromJson(right);
    });
  }

  @override
  Future<Either<ResponseError, ProfileDatamodel>> getprofile() {
    return safe(
            getRequestWithTokenversion(endPoint: "api/v1/store-keeper/profile"))
        .thenRight(checkHttpStatus)
        .thenRight(parseJson)
        .mapRight((right) {
      return ProfileDatamodel.fromJson(right);
    });
  }
}
