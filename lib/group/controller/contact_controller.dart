//riverpod controller for fetching contacts
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactController extends StateNotifier<ContactState> {
  ContactController() : super(ContactState());

  Future<void> fetchContacts() async {
    final hasPermission = await FlutterContacts.requestPermission(
      readonly: true,
    );
    if (!hasPermission) {
      state = state.copyWith(permissionDenied: true);
      return;
    }

    final contacts = await FlutterContacts.getContacts();
    state = state.copyWith(contacts: contacts);
  }

  void toggleSelection(int index) {
    final newSelected = Set<int>.from(state.selectedIndices);
    if (newSelected.contains(index)) {
      newSelected.remove(index);
    } else {
      newSelected.add(index);
    }

    state = state.copyWith(selectedIndices: newSelected);
  }

  void removeSelected(int index) {
    final newSelected = Set<int>.from(state.selectedIndices)..remove(index);
    state = state.copyWith(selectedIndices: newSelected);
  }
}

//state class

class ContactState {
  final List<Contact> contacts;
  final Set<int> selectedIndices;
  final bool permissionDenied;

  ContactState({
    this.contacts = const [],
    this.selectedIndices = const {},
    this.permissionDenied = false,
  });

  ContactState copyWith({
    List<Contact>? contacts,
    Set<int>? selectedIndices,
    bool? permissionDenied,
  }) {
    return ContactState(
      contacts: contacts ?? this.contacts,
      selectedIndices: selectedIndices ?? this.selectedIndices,
      permissionDenied: permissionDenied ?? this.permissionDenied,
    );
  }
}
