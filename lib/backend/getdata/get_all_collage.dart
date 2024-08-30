import 'package:jazzee/constants.dart/constants.dart';

class getAllCollage {
  Future<List<Map<String, String>>> get_all_collage() async {
    final List<Map<String, dynamic>> _collages =
        await supabase.from('collage').select();

    print('collages: $_collages');

    List<Map<String, String>> collagesList = _collages.map((collage) {
      return {
        'Collage ID': collage['collage_id'] as String,
        'Collage Name': collage['collage_name'] as String,
      };
    }).toList();

    return collagesList;
  }
}

class collageModel {
  final String coll_id;
  final String coll_name;

  const collageModel({
    required this.coll_id,
    required this.coll_name,
  });

  // Factory constructor to create a collageModel object from a JSON map
  factory collageModel.fromJson(Map<String, dynamic> json) {
    return collageModel(
      coll_id: json['collage_id'] as String,
      coll_name: json['collage_name'] as String,
    );
  }

  @override
  String toString() {
    return 'Collage ID: $coll_id, Collage Name: $coll_name';
  }
}
