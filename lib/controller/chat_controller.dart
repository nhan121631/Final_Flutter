import 'package:get/get.dart';
import '../service/remote_service/remote_chat_service.dart';

class ChatController extends GetxController {
  var messages = <String>[].obs;
  final ChatService _chatService = ChatService();

  Future<void> sendMessage(String message) async {
    messages.add("Bạn: $message");

    try {
      String botMessage = await _chatService.sendMessage(message);
      messages.add("AI: $botMessage");
    } catch (e) {
      messages.add("AI: Không thể nhận được phản hồi.");
    }
  }
}
