import 'package:team_app/Models/addBlogModels.dart';
import 'package:json_annotation/json_annotation.dart';

part 'SuperModel.g.dart';

@JsonSerializable()
class SuperModel {
  List<AddBlogModel> data;
  SuperModel({required this.data});
  factory SuperModel.fromJson(Map<String, dynamic> json) =>
      _$SuperModelFromJson(json);
  Map<String, dynamic> toJson() => _$SuperModelToJson(this);
}
