
import 'package:cloud_firestore/cloud_firestore.dart';


class SavedPrompts {
  String id;
  String userID;
  String title;
  String content;
  String contentFirst;
  bool isPinned;
  bool whatisthis;

  SavedPrompts(this.id, this.userID, this.title, this.content,
      this.contentFirst, this.isPinned, this.whatisthis);

  Future<List<SavedPrompts>> readPrompts() async {
    final querysnapshot =
        await FirebaseFirestore.instance.collection("SavedPrompts").get();
    List<QueryDocumentSnapshot> docs = querysnapshot.docs;
    List<SavedPrompts> listem = docs
        .map((doc) => SavedPrompts.fromJson(doc.data() as dynamic))
        .toList();
    return listem;
  }

  factory SavedPrompts.fromJson(Map<String, dynamic> json) {
    return SavedPrompts(
      json["id"],
      json["userID"] as String,
      json["title"] as String,
      json["content"] as String,
      json["contentFirst"] as String,
      json["isPinned"] as bool,
      json["whatisthis"] as bool,
    );
  }
}
