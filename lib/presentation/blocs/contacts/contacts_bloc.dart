import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recording_cleaner/core/utils/app_logger.dart';
import 'package:recording_cleaner/domain/repositories/contact_repository.dart';
import 'package:recording_cleaner/presentation/blocs/contacts/contacts_event.dart';
import 'package:recording_cleaner/presentation/blocs/contacts/contacts_state.dart';

/// 联系人列表 BLoC
class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  /// 创建[ContactsBloc]实例
  ContactsBloc({
    required AppLogger logger,
    required ContactRepository contactRepository,
  })  : _logger = logger,
        _contactRepository = contactRepository,
        super(ContactsState.initial()) {
    on<LoadContacts>(_onLoadContacts);
    on<DeleteContacts>(_onDeleteContacts);
    on<DeleteSelectedContacts>(_onDeleteSelectedContacts);
    on<EnterSelectionMode>(_onEnterSelectionMode);
    on<ExitSelectionMode>(_onExitSelectionMode);
    on<ToggleContactSelection>(_onToggleContactSelection);
    on<ToggleSelectAll>(_onToggleSelectAll);
    on<UpdateContactCategory>(_onUpdateContactCategory);
    on<UpdateContactProtection>(_onUpdateContactProtection);
    on<BatchUpdateCategory>(_onBatchUpdateCategory);
  }

  final AppLogger _logger;
  final ContactRepository _contactRepository;

  Future<void> _onLoadContacts(
    LoadContacts event,
    Emitter<ContactsState> emit,
  ) async {
    try {
      emit(state.copyWith(
        isLoading: true,
        error: null,
      ));

      final contacts = await _contactRepository.getContacts();

      emit(state.copyWith(
        contacts: contacts,
        isLoading: false,
      ));
    } catch (e, s) {
      _logger.e('加载联系人列表失败', error: e, stackTrace: s);
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onDeleteContacts(
    DeleteContacts event,
    Emitter<ContactsState> emit,
  ) async {
    try {
      await _contactRepository.deleteContacts(event.ids);

      final contacts = await _contactRepository.getContacts();

      emit(state.copyWith(
        contacts: contacts,
      ));
    } catch (e, s) {
      _logger.e('删除联系人失败', error: e, stackTrace: s);
      emit(state.copyWith(
        error: e.toString(),
      ));
    }
  }

  Future<void> _onDeleteSelectedContacts(
    DeleteSelectedContacts event,
    Emitter<ContactsState> emit,
  ) async {
    try {
      await _contactRepository.deleteContacts(state.selectedContacts);

      final contacts = await _contactRepository.getContacts();

      emit(state.copyWith(
        contacts: contacts,
        selectedContacts: [],
        isSelectionMode: false,
      ));
    } catch (e, s) {
      _logger.e('删除选中的联系人失败', error: e, stackTrace: s);
      emit(state.copyWith(
        error: e.toString(),
      ));
    }
  }

  void _onEnterSelectionMode(
    EnterSelectionMode event,
    Emitter<ContactsState> emit,
  ) {
    emit(state.copyWith(
      isSelectionMode: true,
    ));
  }

  void _onExitSelectionMode(
    ExitSelectionMode event,
    Emitter<ContactsState> emit,
  ) {
    emit(state.copyWith(
      isSelectionMode: false,
      selectedContacts: [],
    ));
  }

  void _onToggleContactSelection(
    ToggleContactSelection event,
    Emitter<ContactsState> emit,
  ) {
    final selectedContacts = List<String>.from(state.selectedContacts);
    if (selectedContacts.contains(event.id)) {
      selectedContacts.remove(event.id);
    } else {
      selectedContacts.add(event.id);
    }
    emit(state.copyWith(
      selectedContacts: selectedContacts,
    ));
  }

  void _onToggleSelectAll(
    ToggleSelectAll event,
    Emitter<ContactsState> emit,
  ) {
    final selectedContacts =
        state.selectedContacts.length == state.contacts.length
            ? <String>[]
            : state.contacts.map((e) => e.id).toList();
    emit(state.copyWith(
      selectedContacts: selectedContacts,
    ));
  }

  Future<void> _onUpdateContactCategory(
    UpdateContactCategory event,
    Emitter<ContactsState> emit,
  ) async {
    try {
      await _contactRepository.updateContactCategory(event.id, event.category);

      final contacts = await _contactRepository.getContacts();

      emit(state.copyWith(
        contacts: contacts,
      ));
    } catch (e, s) {
      _logger.e('更新联系人分类失败', error: e, stackTrace: s);
      emit(state.copyWith(
        error: e.toString(),
      ));
    }
  }

  Future<void> _onUpdateContactProtection(
    UpdateContactProtection event,
    Emitter<ContactsState> emit,
  ) async {
    try {
      await _contactRepository.updateContactProtection(
          event.id, event.isProtected);

      final contacts = await _contactRepository.getContacts();

      emit(state.copyWith(
        contacts: contacts,
      ));
    } catch (e, s) {
      _logger.e('更新联系人保护状态失败', error: e, stackTrace: s);
      emit(state.copyWith(
        error: e.toString(),
      ));
    }
  }

  Future<void> _onBatchUpdateCategory(
    BatchUpdateCategory event,
    Emitter<ContactsState> emit,
  ) async {
    try {
      await _contactRepository.batchUpdateCategory(event.ids, event.category);

      final contacts = await _contactRepository.getContacts();

      emit(state.copyWith(
        contacts: contacts,
        selectedContacts: [],
        isSelectionMode: false,
      ));
    } catch (e, s) {
      _logger.e('批量更新联系人分类失败', error: e, stackTrace: s);
      emit(state.copyWith(
        error: e.toString(),
      ));
    }
  }
}
