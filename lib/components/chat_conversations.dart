import 'package:flutter/material.dart';
import 'package:ragchat/components/message.dart';
import 'package:ragchat/model/message.dart';

class ChatConversations extends StatefulWidget {
  final List<Map<String, dynamic>> conversations;

  const ChatConversations({super.key, required this.conversations});

  @override
  State<ChatConversations> createState() => _ChatConversationsState();
}

class _ChatConversationsState extends State<ChatConversations> {
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _conversations = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _conversations.addAll(widget.conversations);
    scrollToBottom(700);
  }

  @override
  void didUpdateWidget(covariant ChatConversations oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_conversations != oldWidget.conversations) {
      scrollToBottom(300);
    }
  }

  void scrollToBottom(int milliseconds) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: milliseconds),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: widget.conversations.length,
      reverse: false,
      itemBuilder: (context, index) {
        return Message(
          message: MessageModel.fromJson(widget.conversations[index]),
        );
      },
    );
  }
}
