import 'package:json_annotation/json_annotation.dart';

part 'pet_model.g.dart';

@JsonSerializable()
class Pet {
  final String? id;
  final String? url;

  @JsonKey(name: 'breeds')
  final List<Map<String, dynamic>>? breeds;

  // This is not in TheCatAPI, will be null
  final String? gender;

  // This is not in TheCatAPI, will be null
  final String? distance;

  Pet({
    this.id,
    this.url,
    this.breeds,
    this.gender,
    this.distance,
  });

  String? get name => _nameFromBreeds(breeds);
  String? get age => _ageFromBreeds(breeds);
  String? get breed => _breedFromBreeds(breeds);

  factory Pet.fromJson(Map<String, dynamic> json) => _$PetFromJson(json);

  Map<String, dynamic> toJson() => _$PetToJson(this);
}

String? _nameFromBreeds(List<Map<String, dynamic>>? breeds) {
  if (breeds != null && breeds.isNotEmpty && breeds.first['name'] != null) {
    return breeds.first['name'];
  }
  return "Unknown";
}

String? _ageFromBreeds(List<Map<String, dynamic>>? breeds) {
  if (breeds != null && breeds.isNotEmpty && breeds.first['life_span'] != null) {
    return "${breeds.first['life_span']} years";
  }
  return "Unknown";
}

String? _breedFromBreeds(List<Map<String, dynamic>>? breeds) {
  if (breeds != null && breeds.isNotEmpty && breeds.first['name'] != null) {
    return breeds.first['name'];
  }
  return "Unknown";
}
