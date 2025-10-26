import 'package:pet_finder/core/networking/api_result.dart';
import 'package:pet_finder/features/view_pets/data/datasources/pet_service.dart';
import 'package:pet_finder/features/view_pets/data/models/pet_model.dart';

class PetRepo {
  final PetService service;

  PetRepo({required this.service});

  Future<ApiResult<List<Pet>>> getRandomImages({int limit = 1, required String apiKey}) async {
    try {
      final response = await service.getRandomImages(limit: limit, apiKey: apiKey);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e);
    }
  }

  Future<ApiResult<List<Pet>>> getBreedImages({required String breedId, int limit = 10, required String apiKey}) async {
    try {
      final response = await service.getBreedImages(breedId: breedId, limit: limit, apiKey: apiKey);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e);
    }
  }
}
