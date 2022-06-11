import 'package:flutter/material.dart';
import 'package:health_tracker/shared/styles/themes.dart';
import 'package:sizer/sizer.dart';

class MyTextfield extends StatelessWidget {
  final IconData icon;
  final String hint;
  final FormFieldValidator<String> validator;
  final TextEditingController textEditingController;
  final TextInputType keyboardtype;
  final bool obscure;
  final bool readonly;
  final bool showicon;
  final int? maxlenght;
  final Function()? ontap;
  const MyTextfield(
      {Key? key,
      required this.hint,
      required this.icon,
      required this.validator,
      required this.textEditingController,
      this.obscure = false,
      this.readonly = false,
      this.showicon = true,
      this.ontap,
      this.keyboardtype = TextInputType.text,
      this.maxlenght = null})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      maxLines: 1,
      maxLength: maxlenght,
      readOnly: readonly,
      obscureText: obscure,
      keyboardType: keyboardtype,
      onTap: readonly ? ontap : null,
      controller: textEditingController,
      style: Theme.of(context).textTheme.headline1?.copyWith(
          fontSize: 9.sp,
          // color: Colors.black,
          fontWeight: FontWeight.bold),
      decoration: InputDecoration(
          // fillColor: Colors.grey.shade200,
          // filled: true,
          // hintText: hint,
          labelText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.grey.shade200,
                width: 0,
              )),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.3.h),
          hintStyle: Theme.of(context).textTheme.headline1?.copyWith(
                fontSize: 9.sp,
                color: MyThemes.primary,
              ),
          prefixIcon: showicon
              ? Icon(
                  icon,
                  size: 22,
                  color: MyThemes.primary,
                )
              : null,
          suffixIcon: readonly
              ? Icon(
                  icon,
                  size: 22,
                  color: MyThemes.primary,
                )
              : null),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
    );
  }
}


// import 'package:flutter/material.dart';

// class TextFieldWidget extends StatefulWidget {
//   final int maxLines;
//   final String label, text;
//   final ValueChanged<String> onChanged;
  
//   const TextFieldWidget({ 
//     Key? key,
//     this.maxLines = 1,
//     required this.label ,
//     required this.text , 
//     required this.onChanged , 
//     }) : super(key: key);

//   @override
//   State<TextFieldWidget> createState() => _TextFieldWidgetState();
// }

// class _TextFieldWidgetState extends State<TextFieldWidget> {
//   late final TextEditingController controller;

//   @override
//   void initState() {
//     super.initState();

//     controller = TextEditingController(text: widget.text);
//   }

//   @override
//   void dispose() {
//     controller.dispose();
    
//     super.dispose();
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.label,
//           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//         ),
//         const SizedBox(height: 8,),
//         TextField(
//           controller: controller,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           maxLines: widget.maxLines,
//           onChanged: widget.onChanged,
//         ),
//       ],
//     );
//   }
// }