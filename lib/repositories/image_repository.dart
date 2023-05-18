import 'package:daily_basket_sellers/api-providers/image_api_provider.dart';

class ImageRepository {
  ImageApiProvider _imageApiProvider = ImageApiProvider();

  uploadImage(image, type) async => await _imageApiProvider.uploadImage(image, type);
}