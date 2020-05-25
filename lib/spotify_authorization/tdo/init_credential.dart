import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class InitCredential {
  final String code;
  final String state;
  final String error;

  InitCredential({this.code, this.state, this.error});

  factory InitCredential.fromJson(Map<String, dynamic> json) =>
      _$InitCredentialFromJson(json);

  //Map<String, dynamic> toJson() => _$PersonToJson(this);
  bool hasError() {
    return this.error != null && this.error.isNotEmpty;
  }
  bool hasCode(){
    return this.code != null && this.code.isNotEmpty;
  }

  @override
  String toString() {
    return 'InitCredential{code: $code, state: $state, error: $error}';
  }

}

InitCredential _$InitCredentialFromJson(Map<String, dynamic> json) {
  return InitCredential(
    code: json['code'] as String,
    state: json['state'] as String,
    error: json["error"] as String,
  );

}

