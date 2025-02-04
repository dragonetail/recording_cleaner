import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:recording_cleaner/core/providers/repository_provider.dart'
    as app_provider;
import 'package:recording_cleaner/core/utils/app_logger.dart';
import 'package:recording_cleaner/domain/entities/contact_entity.dart';
import 'package:recording_cleaner/presentation/blocs/contacts/contacts_bloc.dart';
import 'package:recording_cleaner/presentation/blocs/contacts/contacts_event.dart';
import 'package:recording_cleaner/presentation/blocs/contacts/contacts_state.dart';
import 'package:recording_cleaner/presentation/widgets/contact_list_item.dart';
import 'package:recording_cleaner/presentation/widgets/empty_state.dart';
import 'package:recording_cleaner/presentation/widgets/loading_state.dart';
import 'package:recording_cleaner/presentation/widgets/selection_mode.dart';

/// 联系人列表页面
class ContactsPage extends StatelessWidget {
  /// 创建[ContactsPage]实例
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<app_provider.RepositoryProvider>().contactRepository,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('联系人'),
              centerTitle: true,
            ),
            body: ErrorState(
              message: snapshot.error.toString(),
              onRetry: () {
                context
                    .read<app_provider.RepositoryProvider>()
                    .contactRepository;
              },
            ),
          );
        }

        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('联系人'),
              centerTitle: true,
            ),
            body: const LoadingState(),
          );
        }

        return BlocProvider(
          create: (context) => ContactsBloc(
            logger: context.read(),
            contactRepository: snapshot.data!,
          )..add(const LoadContacts()),
          child: const _ContactsContent(),
        );
      },
    );
  }
}

class _ContactsContent extends StatelessWidget {
  const _ContactsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) {
        final appBar = state.isSelectionMode
            ? SelectionModeAppBar(
                selectedCount: state.selectedContacts.length,
                totalCount: state.contacts.length,
                onSelectAll: () {
                  context.read<ContactsBloc>().add(const ToggleSelectAll());
                },
                onDelete: () async {
                  context.read<ContactsBloc>().add(DeleteSelectedContacts());
                  return true;
                },
                onShare: () {
                  // TODO: 实现分享功能
                },
                onCancel: () {
                  context.read<ContactsBloc>().add(const ExitSelectionMode());
                },
              )
            : AppBar(
                title: const Text('联系人'),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.checklist_rounded),
                    onPressed: () {
                      context
                          .read<ContactsBloc>()
                          .add(const EnterSelectionMode());
                    },
                  ),
                ],
              );

        final body = state.isLoading
            ? const LoadingState()
            : state.error != null
                ? ErrorState(
                    message: state.error!,
                    onRetry: () {
                      context.read<ContactsBloc>().add(const LoadContacts());
                    },
                  )
                : state.contacts.isEmpty
                    ? const EmptyState(
                        message: '暂无联系人',
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          context
                              .read<ContactsBloc>()
                              .add(const LoadContacts());
                        },
                        child: AnimationLimiter(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            itemCount: state.contacts.length,
                            itemBuilder: (context, index) {
                              final contact = state.contacts[index];
                              return ContactListItem(
                                index: index,
                                name: contact.name,
                                phoneNumber: contact.phoneNumber,
                                category: contact.category,
                                onTap: () {
                                  // TODO: 实现联系人详情页面
                                },
                                onDelete: () async {
                                  context.read<ContactsBloc>().add(
                                        DeleteContacts([contact.id]),
                                      );
                                  return true;
                                },
                                onCategoryChanged: (category) {
                                  context.read<ContactsBloc>().add(
                                        UpdateContactCategory(
                                          contact.id,
                                          category,
                                        ),
                                      );
                                },
                                onProtectionChanged: (isProtected) {
                                  context.read<ContactsBloc>().add(
                                        UpdateContactProtection(
                                          contact.id,
                                          isProtected,
                                        ),
                                      );
                                },
                                isProtected: contact.isProtected,
                                isSelected:
                                    state.selectedContacts.contains(contact.id),
                                onSelectedChanged: state.isSelectionMode
                                    ? (selected) {
                                        context.read<ContactsBloc>().add(
                                              ToggleContactSelection(
                                                contact.id,
                                              ),
                                            );
                                      }
                                    : null,
                                showSlideAction: !state.isSelectionMode,
                              );
                            },
                          ),
                        ),
                      );

        return Scaffold(
          appBar: appBar,
          body: body,
          bottomNavigationBar: state.isSelectionMode
              ? SelectionMode(
                  selectedCount: state.selectedContacts.length,
                  totalCount: state.contacts.length,
                  onSelectAll: () {
                    context.read<ContactsBloc>().add(const ToggleSelectAll());
                  },
                  onDelete: () async {
                    context.read<ContactsBloc>().add(DeleteSelectedContacts());
                    return true;
                  },
                  onShare: () {
                    // TODO: 实现分享功能
                  },
                  onCancel: () {
                    context.read<ContactsBloc>().add(const ExitSelectionMode());
                  },
                )
              : null,
        );
      },
    );
  }
}
