import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for managing conversations
final conversationsProvider =
    StateNotifierProvider<ConversationsNotifier, List<Map<String, dynamic>>>(
  (ref) => ConversationsNotifier(),
);

class ConversationsNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  ConversationsNotifier() : super([]);

  void addConversation(Map<String, dynamic> conversation) {
    state = [...state, conversation]; // Update state by creating a new list
  }

  void updateConversations(List<Map<String, dynamic>> newConversations) {
    state = newConversations; // Update state with new conversations
  }
}
