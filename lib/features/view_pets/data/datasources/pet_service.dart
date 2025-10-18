import 'package:dio/dio.dart';
import 'package:pet_finder/core/networking/api_constants.dart';
import 'package:pet_finder/features/view_pets/data/models/pet_model.dart';
import 'package:retrofit/retrofit.dart';
part 'pet_service.g.dart';


@RestApi(baseUrl:ApiConstants.baseUrl)
abstract class PetService {
  factory PetService(Dio dio, {String baseUrl}) = _PetService;
  // 1️⃣ Random images
  @GET("/images/search")
  Future<List<Pet>> getRandomImages({
    @Query("limit") int limit = 1,
    @Header("x-api-key") required String apiKey,
  });

  // 2️⃣ Images by breed
  @GET("/images/search")
  Future<List<Pet>> getBreedImages({
    @Query("breed_ids") required String breedId,
    @Query("limit") int limit = 10,
    @Header("x-api-key") required String apiKey,
  });



}

