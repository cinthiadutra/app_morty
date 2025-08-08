// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app_morty/data/models/location.dart';

class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String image;
  final String gender;
  final Location? location;
  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.image,
    required this.gender,
    this.location,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'image': image,
      'gender': gender,
      'location': location?.toMap(),
    };
  }

  factory CharacterModel.fromMap(Map<String, dynamic> map) {
    return CharacterModel(
      id: map['id'] as int,
      name: map['name'] as String,
      status: map['status'] as String,
      species: map['species'] as String,
      image: map['image'] as String,
      gender: map['gender'] as String,
      location: map['location'] != null ? Location.fromMap(map['location'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CharacterModel.fromJson(String source) => CharacterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CharacterModel(id: $id, name: $name, status: $status, species: $species, image: $image, gender: $gender, location: $location)';
  }
}
