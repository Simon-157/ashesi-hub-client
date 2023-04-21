import 'package:flutter/material.dart';
import 'package:hub_client/components/card_custom.dart';
import 'package:hub_client/components/custom_widget_attributes.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode, nextFocusNode;
  final FormFieldValidator<String>? validateFunction;
  final void Function(String)? onSaved, onChange;
  final IconData? prefix;
  final IconData? suffix;

  CustomTextField({
    Key? key,
    this.prefix,
    this.suffix,
    this.hintText,
    this.controller,
    this.nextFocusNode,
    this.focusNode,
    this.validateFunction,
    this.onSaved,
    this.onChange,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCard(
            onTap: () {
              print('clicked');
            },
            borderRadius: BorderRadius.circular(40.0),
            child: Theme(
              data: ThemeData(
                primaryColor: Theme.of(context).colorScheme.secondary,
                colorScheme: ColorScheme.fromSwatch().copyWith(
                    secondary: Theme.of(context).colorScheme.secondary),
              ),
              child: TextFormField(
                cursorColor: Theme.of(context).colorScheme.secondary,
                textCapitalization: TextCapitalization.none,
                style: const TextStyle(
                  fontSize: 15.0,
                ),
                key: widget.key,
                controller: widget.controller,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    widget.prefix,
                    size: 15.0,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  suffixIcon: Icon(
                    widget.suffix,
                    size: 15.0,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  // fillColor: Colors.white,
                  filled: true,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  border: border(context),
                  enabledBorder: border(context),
                  focusedBorder: focusBorder(context),
                  errorStyle: const TextStyle(height: 0.0, fontSize: 0.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Visibility(
            visible: error != null,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                '$error',
                style: TextStyle(
                  color: Colors.red[700],
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
