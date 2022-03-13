import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TextFieldWidget extends StatefulWidget {
  final int maxLines;
  final String label, text;
  final ValueChanged<String> onChanged;
  
  const TextFieldWidget({ 
    Key? key,
    this.maxLines = 1,
    required this.label ,
    required this.text , 
    required this.onChanged , 
    }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();
    
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8,),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          maxLines: widget.maxLines,
        ),
      ],
    );
  }
}