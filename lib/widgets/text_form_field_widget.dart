import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final double? width;
  final double? height;
  final String? hintText;
  final String? labelText;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final Color? color;
  final void Function(String)? onChanged;
  final VoidCallback? onEditingComplete;

  const TextFormFieldWidget({
    super.key,
    this.width,
    this.height,
    this.hintText,
    this.labelText,
    required this.controller,
    this.readOnly,
    this.validator,
    this.color,
    this.onChanged,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color ?? Colors.white,
        ),
        width: width ?? MediaQuery.of(context).size.width * 0.8,
        height: height ?? 50,
        child: TextFormField(
          readOnly: readOnly ?? false,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
        ),
      ),
    );
  }
}
