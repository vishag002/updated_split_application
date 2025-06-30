import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:updated_split_application/group/controller/contact_controller.dart';

final contactProvider = StateNotifierProvider<ContactController, ContactState>((
  ref,
) {
  return ContactController();
});
