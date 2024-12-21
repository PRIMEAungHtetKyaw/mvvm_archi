import 'package:flutter/material.dart'; 

class CommonTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? rightIcon;
  final bool isPassword;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? inputType;
  const CommonTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.rightIcon,
    this.isPassword = false,
    this.validator,
    this.onChanged,
    this.inputType = TextInputType.text
  });

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
          if(widget.prefixIcon != null)      
           Padding(
             padding: const EdgeInsets.only(right: 20),
             child: Icon(widget.prefixIcon, color: Theme.of(context).colorScheme.primary),
           ),
        Expanded(
          child: TextFormField(
            keyboardType: widget.inputType,
            controller: widget.controller,
            obscureText: widget.isPassword ? _isObscure : false,
            decoration: InputDecoration(
              hintText: widget.hintText,
          
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    )
                  : (widget.rightIcon != null
                      ? Icon(widget.rightIcon, color: Theme.of(context).colorScheme.primary)
                      : null),
              enabledBorder:   UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
            validator: widget.validator ??
                (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null;
                },
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }
}
