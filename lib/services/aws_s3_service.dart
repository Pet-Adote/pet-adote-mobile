import 'dart:io';

import 'package:aws_s3_api/s3-2006-03-01.dart' as s3;
import 'package:aws_signature_v4/aws_signature_v4.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AwsS3Service {
  AwsS3Service()
      : _region = dotenv.env['AWS_REGION'] ?? '',
        _bucketName = dotenv.env['AWS_BUCKET_NAME'] ?? '' {
    final credentials = AWSCredentials(
      dotenv.env['AWS_ACCESS_KEY_ID'] ?? '',
      dotenv.env['AWS_SECRET_ACCESS_KEY'] ?? '',
    );
    _client = s3.S3(region: _region, credentials: credentials);
  }

  late final s3.S3 _client;
  final String _region;
  final String _bucketName;

  Future<String> uploadFile(File file) async {
    final key = file.uri.pathSegments.last;
    final bytes = await file.readAsBytes();
    await _client.putObject(
      s3.PutObjectRequest(
        bucket: _bucketName,
        key: key,
        body: bytes,
        acl: s3.ObjectCannedACL.publicRead,
      ),
    );
    return 'https://$_bucketName.s3.$_region.amazonaws.com/$key';
  }
}
