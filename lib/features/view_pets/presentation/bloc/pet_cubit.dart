import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_finder/features/view_pets/data/models/pet_model.dart';
import 'package:pet_finder/features/view_pets/data/repositories/pet_repo.dart';
import 'pet_state.dart';

class PetCubit extends Cubit<PetState> {
  final PetRepo repo;
  final String apiKey;
  List<Pet> _allPets = [];

  PetCubit({required this.repo, required this.apiKey}) : super(PetInitial());

  /// جلب كل الصور دفعة واحدة
  fetchAllPets({int limit = 50}) async {
    emit(PetLoading());
    final result = await repo.getRandomImages(limit: limit, apiKey: apiKey);

    result.when(
      onSuccess: (data) {
        _allPets = data;
        emit(PetLoaded(data));
      },
      onError: (error) {
        emit(PetError(error.toString()));
      },
    );
  }

  void filterPetsByCategory(String category) {
    if (state is PetLoaded) {
      if (category == 'All' || category == 'Cats') {
        emit(PetLoaded(_allPets));
      } else {
        // For other categories like Dogs, Birds, etc., show an empty list
        // as we are only fetching cats from TheCatApi.
        emit(PetLoaded([]));
      }
    }
  }
}
