import 'package:either_dart/either.dart';
import 'package:elaveoironing_vendor/datamodel/count_datamodel.dart';
import 'package:elaveoironing_vendor/datamodel/getcomplaint_datamodel.dart';
import 'package:elaveoironing_vendor/datamodel/pending_datamodel.dart';
import 'package:elaveoironing_vendor/datamodel/profile_datamodel.dart';
import 'package:elaveoironing_vendor/datamodel/report_datamodel.dart';
import 'package:elaveoironing_vendor/datamodel/version_datamodel.dart';
import 'package:elaveoironing_vendor/services/network/reponse_error.dart';

abstract class BaseServices {
  Future<Either<ResponseError, dynamic>> logIn(
      {String? phone, String? password});
  Future<Either<ResponseError, PendingDatamodel>> pending({
    int? status,
  });
  Future<Either<ResponseError, VersionDatamodel>> getversion();
  Future<Either<ResponseError, ProfileDatamodel>> getprofile();

  Future<Either<ResponseError, ReportDatamodel>> report(
      {String? fromdata, String? todate});
  Future<Either<ResponseError, CountDatamodel>> getcount();
  Future<Either<ResponseError, dynamic>> logout();

  Future<Either<ResponseError, dynamic>> changestatus(
      {int? status, int? orderid});
  Future<Either<ResponseError, dynamic>> locationupdate(
      {double? latitude, double? longitude});
  Future<Either<ResponseError, dynamic>> updateactive({
    int? status,
  });
  Future<Either<ResponseError, dynamic>> complaint({
    int? orderid,
    String? desc,
    int? orderitemid,
    int? shopid,
  });
  Future<Either<ResponseError, GetcomplaintDatamodel>> getcomplaint(
      {int? orderid, int? shopid});
}
