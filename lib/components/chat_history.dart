import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ragchat/services/cody_api.dart';
import 'package:ragchat/state_management/chat_instance.dart';

class ChatHistory extends ConsumerWidget {
  const ChatHistory({super.key});

  Future<List<Map<String, dynamic>>> handleGetConversations() async {
    return await getConversations();
  }

  void selectConversation(
      WidgetRef ref, BuildContext context, Map<String, dynamic> conversation) {
    ref.read(chatInstance.notifier).state = conversation;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatRef = ref.watch(chatInstance);

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: handleGetConversations(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.blue.shade900,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No conversations yet"));
        } else {
          final conversations = snapshot.data!;
          return ListView.builder(
            itemCount: conversations.length,
            itemBuilder: (context, index) => ListTile(
              title: Container(
                decoration: BoxDecoration(
                  border: chatRef['id'] == conversations[index]['id']
                      ? Border.all(color: Colors.grey.shade400)
                      : null,
                  borderRadius: chatRef['id'] == conversations[index]['id']
                      ? const BorderRadius.all(Radius.circular(10))
                      : null,
                ),
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  child: Text(conversations[index]["name"]),
                ),
              ),
              onTap: () =>
                  selectConversation(ref, context, conversations[index]),
            ),
          );
        }
      },
    );
  }
}
