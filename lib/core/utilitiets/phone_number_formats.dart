import 'package:smart_soliq_app/export_files.dart';

var uzFormat = MaskTextInputFormatter(
  mask: '## ### ## ##',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);
