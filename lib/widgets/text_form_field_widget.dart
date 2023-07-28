import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController controller;

  final String? Function(String? val)? validate;
  final bool? enabled;
  final IconData? suffixIcon;
  final Function()? suffixFunction;
  final Function()? function;
  final bool isSecure;
  final TextInputType textType;
  final TextInputAction textTypeAction;
  final FocusNode? focusNode;
  final int? maxLength;
  final int? maxLines;
  final String? hint;
  final Function()? onSubmittedFunction;

  const DefaultTextFormField({
    super.key,
    this.onSubmittedFunction,
    this.maxLength,
    this.enabled,
    this.hint,
    this.maxLines = 1,
    required this.controller,
    required this.validate,
    this.function,
    this.suffixIcon,
    this.suffixFunction,
    this.isSecure = false,
    this.textType = TextInputType.emailAddress,
    this.textTypeAction = TextInputAction.done,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        GestureDetector(
          onTap: function,
          child: TextFormField(
            enabled: enabled,
            maxLength: maxLength,
            maxLines: maxLines,
            onEditingComplete: onSubmittedFunction,
            textInputAction: textTypeAction,
            style: Theme.of(context).textTheme.titleSmall,
            obscureText: isSecure,
            keyboardType: textType,
            controller: controller,
            validator: validate,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                  onTap: suffixFunction,
                  child: Icon(
                    suffixIcon,
                  )),
              hintText: hint,
              hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey
              ),
              border:  OutlineInputBorder(
                borderSide:  BorderSide(
                  color: Theme.of(context).splashColor
                ),

                borderRadius: BorderRadius.circular(10)
              ),
            ),
          ),
        ),
      ],
    );
  }
}
