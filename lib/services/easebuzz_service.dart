import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:studentmanagement/core/network/api_endpoints.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/easebuzzAccessKeyResponse.dart';


class EasebuzzService {
  // Use your real merchant key & salt (keep the salt on your backend ideally,
  // never ship it in a public client app if you can avoid it).
  //Live
  static const String merchantKey = '62STKYKHVY';
  static const String salt = 'F61WEY3OFB';

  //Test
  // static const String merchantKey = '8HKJ36CVO';
  // static const String salt = 'ZLV45EKM2';

  // static const String _testUrl =
  //     'https://testpay.easebuzz.in/payment/initiateLink';
  final _liveUrl = ApiConstants.getEaseBuzzAccessKeyPath();

  Future<EasebuzzAccessKeyResponse> getAccessKey({
    required String txnid,
    required String amount,
    required String productinfo,
    required String firstname,
    required String email,
    required String admissionNo,
    required String std,
    required String div,
    required String studName,
    required String schoolName,
    required String phone,
    required String surl,
    required String furl,
    String requestFlow = 'SEAMLESS', // pass this to get an access_key back
  }) async {
    // Trim all values before hashing, as Easebuzz requires
    final k = merchantKey.trim();
    final t = txnid.trim();
    final a = amount.trim();
    final p = productinfo.trim();
    final f = firstname.trim();
    final e = email.trim();
//extra features by custom
    final ad = admissionNo.trim();
    final s = std.trim();
    final d = div.trim();
    final n = studName.trim();
    final sn = schoolName.trim();

    // hash sequence: key|txnid|amount|productinfo|firstname|email|||||||||||salt
    final hashString =
        '$k|$t|$a|$p|$f|$e|$ad|$s|$d|$n|$sn||||||$salt';
    final hash = sha512.convert(utf8.encode(hashString)).toString();

    final body = <String, String>{
      'key': k,
      'txnid': t,
      'amount': a,
      'productinfo': p,
      'firstname': f,
      'email': e,
      'udf1' : ad,
      'udf2' : s,
      'udf3' : d,
      'udf4' : n,
      'udf5' : sn,
      'phone': phone.trim(),
      'surl': surl,
      'furl': furl,
      'hash': hash,
      'request_flow': requestFlow,
    };

    final response = await http.post(
      Uri.parse(_liveUrl),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body, // http package auto-encodes a Map<String,String> as form-urlencoded
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Easebuzz request failed with status ${response.statusCode}: ${response.body}',
      );
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;

    final status = decoded['status'];
    final isSuccess = status == 1 || status == '1' || status == true;

    String? accessKey;
    String? errorDesc;

    final data = decoded['data'];
    if (isSuccess) {
      if (data is Map<String, dynamic>) {
        accessKey = data['access_key']?.toString();
      } else if (data is String) {
        // some responses return access_key directly as data string
        accessKey = data;
      }
    } else {
      // failure case: data is usually the error message string
      errorDesc = decoded['error_desc']?.toString() ??
          (data is String ? data : data?.toString());
    }

    return EasebuzzAccessKeyResponse(
      success: isSuccess,
      accessKey: accessKey,
      errorDesc: errorDesc,
      raw: decoded,
    );
  }
}