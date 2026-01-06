import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// This sample class is not used in the example, but it showcases how
/// Colorist package can work with other code-generating packages like Freezed, or Json Serializable.
@freezed
abstract class UserModel with _$UserModel {
  factory UserModel({
    required String id,
    required String name,
    @Default('sample@email.com') String email,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
