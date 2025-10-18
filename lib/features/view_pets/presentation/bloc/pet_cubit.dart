import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_finder/features/view_pets/data/repositories/pet_repo.dart';
import 'pet_state.dart';

class PetCubit extends Cubit<PetState> {
  final PetRepo repo;
  final String apiKey;

  PetCubit({required this.repo, required this.apiKey}) : super(PetInitial());

  /// جلب كل الصور دفعة واحدة
  fetchAllPets({int limit = 50}) async {
    emit(PetLoading());
    final result = await repo.getRandomImages(limit: limit, apiKey: apiKey);

    result.when(
      onSuccess: (data) {
        emit(PetLoaded(data));
      },
      onError: (error) {
        emit(PetError(error.toString()));
      },
    );
  }
}
