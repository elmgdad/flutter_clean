import 'dart:convert';

class MethodField {
  MethodField({
    required this.inputName,
    required this.inputType,
    required this.placeHolder,
    this.inputValue,
  });

  String? inputName;
  String? inputType;
  String? inputValue;
  String? placeHolder;

  MethodField copyWith(String value) {
    inputValue = value;
    return this;
  }

  factory MethodField.fromRawJson(String str) => MethodField.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MethodField.fromJson(Map<String, dynamic> json) => MethodField(
        inputName: json["input_name"],
        inputType: json["input_type"],
        inputValue: json["input_value"],
        placeHolder: json["placeholder"],
      );

  Map<String, dynamic> toJson() => {
        "input_name": inputName,
        "input_type": inputType,
        "input_value": inputValue,
        "placeholder": placeHolder,
      };
}
