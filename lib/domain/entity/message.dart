import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final String name;
  final String email;
  final String message;

  Message({
    required this.name,
    required this.email,
    required this.message,
  });

  // from JSON
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  // to JSON
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
