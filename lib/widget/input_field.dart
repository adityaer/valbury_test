import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String inputName;
  final TextEditingController controller;
  final bool isObscureText;

  const InputField({
    super.key,
    required this.controller,
    required this.inputName,
    this.isObscureText = false,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool obscure = false;

  @override
  void initState() {
    obscure = widget.isObscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: InputDecorator(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        child: TextField(
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 0,
            ),
            border: InputBorder.none,
            labelText: widget.inputName,
            suffixIcon: widget.isObscureText
                ? IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    color: Colors.black,
                    icon: Icon(
                      obscure ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                  )
                : null,
          ),
          controller: widget.controller,
          obscureText: obscure,
        ),
      ),
    );
  }
}
