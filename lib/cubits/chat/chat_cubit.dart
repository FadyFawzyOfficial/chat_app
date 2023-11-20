import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;

import '../../constants/strings.dart';
import '../../models/message.dart';

class ChatCubit extends Cubit<List<Message>> {
  ChatCubit() : super([]);

  // Create a CollectionReference called messages that references the firestore collection
  final _messages = FirebaseFirestore.instance.collection(kMessagesKey);

  void sendMessage({required String email, required String message}) {
    _messages.add({
      kMessageKey: message,
      kDateKey: DateTime.now(),
      kEmailKey: email,
    });
  }

  void get messages =>
      _messages.orderBy(kDateKey, descending: true).snapshots().listen(
            (snapshot) => emit(
              List.from(
                snapshot.docs.map(
                  (message) => Message.fromMap(message),
                ),
              ),
            ),
          );
}
