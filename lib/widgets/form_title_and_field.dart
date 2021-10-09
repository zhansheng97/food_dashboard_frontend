import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormTitleAndField extends StatelessWidget {
  final String title;
  final String? hintText;
  final String? suffixText;
  final TextEditingController textEditingController;
  final Function(String value) onChanged;
  final Function(String? value) onSaved;
  final String? Function(String? value) validate;
  final bool obscure;
  const FormTitleAndField({
    Key? key,
    required this.title,
    this.hintText,
    this.suffixText,
    required this.textEditingController,
    required this.onChanged,
    required this.onSaved,
    required this.validate,
    this.obscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: onChanged,
            onSaved: onSaved,
            validator: validate,
            controller: textEditingController,
            style: GoogleFonts.montserrat(
              fontSize: 14,
            ),
            obscureText: obscure,
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: hintText,
                suffixText: suffixText,
                suffixStyle:
                    GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
