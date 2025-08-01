import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reto_tecnico_apex/config/theme/app_colors.dart';

class InputEditTextWidget extends StatelessWidget {
  const InputEditTextWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.textController,
    this.isPassword = false,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final bool isPassword;
  final TextEditingController textController;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          boxShadow: [
            BoxShadow(
              color: applyOpacity(AppColors.black, 0.25),
              blurRadius: 4.0,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: textController,
          obscureText: isPassword,
          maxLines: 1,
          readOnly: onTap != null,
          onTap: onTap,
          style: Theme.of(context).textTheme.headlineSmall,
          inputFormatters: inputFormatters ?? [],
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: title,
            labelStyle: Theme.of(context).textTheme.headlineSmall,
            prefixIcon: Icon(icon, color: Theme.of(context).primaryColor,),
            suffixIcon: isPassword == true ? Icon(Icons.remove_red_eye_outlined, color: Theme.of(context).primaryColor,) : null,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}