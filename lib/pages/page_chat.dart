import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ragchat/components/drawer.dart';
import 'package:ragchat/pages/chat_interface.dart';
import 'package:ragchat/services/cody_api.dart';
import 'package:ragchat/state_management/chat_instance.dart';

class PageChat extends ConsumerStatefulWidget {
  const PageChat({super.key});

  @override
  ConsumerState<PageChat> createState() => _PageChatState();
}

class _PageChatState extends ConsumerState<PageChat> {
  void handleDeleteConversation(WidgetRef ref) async {
    await deleteConversation(ref.read(chatInstance)['id']);

    ref.read(chatInstance.notifier).state = {};
    print('delete');
  }

  @override
  Widget build(BuildContext context) {
    final chatRef = ref.watch(chatInstance); // Use ref here as expected

    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
              FocusScope.of(context).unfocus();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
        actions: chatRef.isNotEmpty
            ? [
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => handleDeleteConversation(
                      ref), // Call the function with ref
                ),
              ]
            : [],
      ),
      body: const ChatInterface(),
      drawer: const CustomDrawer(),
    );
  }
}
