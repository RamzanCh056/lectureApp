class AddPdfModel {
  String? Pdf;
  String? doc;
  String? topic;


  AddPdfModel({
    this.Pdf,
this.topic,
    this.doc,
  });

  Map<String, dynamic> toJson() {
    return {
      "Pdf": this.Pdf,
      "doc": this.doc,
      "topic": this.topic,


    };
  }

  factory AddPdfModel.fromJson(Map<String, dynamic> json) {
    return AddPdfModel(
      Pdf: json["Pdf"] ?? "",
      doc: json["doc"] ?? "",
      topic: json["topic"] ?? "",

    );
  }
}
