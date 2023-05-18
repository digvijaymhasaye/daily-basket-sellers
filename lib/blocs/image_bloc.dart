import 'package:daily_basket_sellers/repositories/image_repository.dart';

class ImageBloc {
  ImageRepository _imageRepository = ImageRepository();

  uploadImage(image, type) async {
    var response = await _imageRepository.uploadImage(image, type);
    return response;
  }
}