import 'dart:io';

import 'package:aws_s3_client/aws_s3_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AwsS3Service {
  AwsS3Service();

  Future<String> uploadFile(File file) async {
    final region = dotenv.env['AWS_REGION'] ?? '';
    final accessKey = dotenv.env['AWS_ACCESS_KEY_ID'] ?? '';
    final secretKey = dotenv.env['AWS_SECRET_ACCESS_KEY'] ?? '';
    final bucketName = dotenv.env['AWS_BUCKET_NAME'] ?? '';

    final bucket = Bucket(
      region: region,
      bucketId: bucketName,
      accessKey: accessKey,
      secretKey: secretKey,
    );

    final fileName = file.uri.pathSegments.last;

    final response = await bucket.uploadFile(
      fileName,
      file,
      'public-read',
    );

    if (response.statusCode == 200) {
      return 'https://$bucketName.s3.$region.amazonaws.com/$fileName';
    } else {
      throw Exception('Failed to upload file: ${response.statusCode}');
    }
  }
}
