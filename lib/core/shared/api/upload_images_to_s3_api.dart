import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';
import 'package:new_strucuture/core/exports.dart';
import 'package:new_strucuture/core/models/err_model.dart';
import 'package:new_strucuture/core/utils/app_constants.dart';

/*

fileName: file.path.split('/').last,
            filePath: file.path,
            accessKey: aw3SettingsModel.data['key']?.value ?? "",
            secretKey: aw3SettingsModel.data['secret']?.value ?? "",
            region: aw3SettingsModel.data['region']?.value ?? "",
            bucketName: aw3SettingsModel.data['space']?.value ?? "",
            endpoint: aw3SettingsModel.data['endpoint']?.value ?? "",
            destinationPath:
                aw3SettingsModel
                    .data['inspection_image_and_tickets_file']
                    ?.value ??
                "",
          );
 */
class UploadImagesToS3Api {
  Future<Either<ErrorModel, SuccessModel>> uploadFiles({
    required String filePath,
    String accessKey = AppConstance.accessKey,
    String secretKey = AppConstance.secretKey,
    String region = AppConstance.region,
    String bucketName = AppConstance.bucketName,
    String endpoint = AppConstance.endpoint,
    String destinationPath = AppConstance.destinationPath,
    required String fileName,
  }) async {
    try {
      log(
        "accessKey: $accessKey secretKey: $secretKey region: $region bucketName: $bucketName endpoint: $endpoint destinationPath: $destinationPath fileName: $fileName filePath: $filePath ",
      );
      log('$filePath ^PATH');
      log('$fileName ^PATHNAME');
      final file = File(filePath);
      // final fileName = basename(file.path);

      final host = '$bucketName.$region.digitaloceanspaces.com';
      // final filePathInBucket = '$destinationPath/$fileName';
      // final filePathInBucket = Uri.encodeFull('$destinationPath/$fileName');
      final filePathInBucket = Uri.encodeFull('$destinationPath/$fileName');
      final url = 'https://$host/$filePathInBucket';
      final dateTime = DateTime.now().toUtc();
      final amzDate = DateFormat("yyyyMMdd'T'HHmmss'Z'", "en").format(dateTime);
      final dateStamp = DateFormat('yyyyMMdd', "en").format(dateTime);

      final service = 's3';
      final credentialScope = '$dateStamp/$region/$service/aws4_request';

      final canonicalRequest = [
        'PUT',
        '/$filePathInBucket',
        '',
        'host:$host',
        'x-amz-acl:public-read',
        'x-amz-date:$amzDate',
        '',
        'host;x-amz-acl;x-amz-date',
        'UNSIGNED-PAYLOAD',
      ].join('\n');

      log('Canonical Request:\n$canonicalRequest\n');

      final hashedCanonicalRequest =
          sha256.convert(utf8.encode(canonicalRequest)).toString();

      final stringToSign = [
        'AWS4-HMAC-SHA256',
        amzDate,
        credentialScope,
        hashedCanonicalRequest,
      ].join('\n');

      log('String to Sign:\n$stringToSign\n');

      final signingKey = _generateSigningKey(
        secretKey,
        dateStamp,
        region,
        service,
      );

      final signature = Hmac(
        sha256,
        signingKey,
      ).convert(utf8.encode(stringToSign)).toString();

      log('Signature: $signature\n');

      final authorizationHeader =
          'AWS4-HMAC-SHA256 Credential=$accessKey/$credentialScope, SignedHeaders=host;x-amz-acl;x-amz-date, Signature=$signature';

      final request = http.Request('PUT', Uri.parse(url));
      request.headers.addAll({
        'x-amz-date': amzDate,
        'Authorization': authorizationHeader,
        'x-amz-content-sha256': 'UNSIGNED-PAYLOAD',
        'x-amz-acl': 'public-read',
        'Content-Type': 'application/octet-stream',
      });
      request.bodyBytes = await file.readAsBytes();

      final response = await request.send();
      if (response.statusCode == 200) {
        log('Upload successful! File URL: $url');
        return Right(
          SuccessModel(
            // code: '200',
            message: url,
            // status: 'success',
            // type: 'success',
          ),
        );
      } else {
        log('Failed to upload. Status code: ${response.statusCode}');
        log(await response.stream.bytesToString());
        throw Exception('Failed to upload');
        // return ApiResult.failure(
        //   ErrorModel(
        //     code: '500',
        //     status: 'error',
        //     type: 'error',
        //     message: 'Failed to upload',
        //   ),
        // );
      }
    } catch (e) {
      log('Error: $e');
      // throw Exception('Failed to upload');

      return Left(ErrorModel(message: 'Failed to upload'));
    }
  }

  List<int> _generateSigningKey(
    String secretKey,
    String dateStamp,
    String region,
    String service,
  ) {
    final kDate = Hmac(
      sha256,
      utf8.encode('AWS4$secretKey'),
    ).convert(utf8.encode(dateStamp)).bytes;
    final kRegion = Hmac(sha256, kDate).convert(utf8.encode(region)).bytes;
    final kService = Hmac(sha256, kRegion).convert(utf8.encode(service)).bytes;
    final kSigning = Hmac(
      sha256,
      kService,
    ).convert(utf8.encode('aws4_request')).bytes;
    return kSigning;
  }
}
