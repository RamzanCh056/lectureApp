class AddTopic {
  String? topics;
  String? doc;


  AddTopic({
    this.topics,
    this.doc,
  });

  Map<String, dynamic> toJson() {
    return {
      "topics": this.topics,
      "doc": this.doc,


    };
  }

  factory AddTopic.fromJson(Map<String, dynamic> json) {
    return AddTopic(
      topics: json["topics"] ?? "",
      doc: json["doc"] ?? "",


    );
  }
}
