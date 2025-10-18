
class Note {
  final int? id;
  final String content;

  Note({this.id, required this.content});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
    };
  }
}
