class QuotesModel {
  String? quotes;
  String? doc;


  QuotesModel({
    this.quotes,
    this.doc,
  });

  Map<String, dynamic> toJson() {
    return {
      "quotes": this.quotes,
      "doc": this.doc,
    };
  }

  factory QuotesModel.fromJson(Map<String, dynamic> json) {
    return QuotesModel(
      quotes: json["quotes"] ?? "",
      doc: json["doc"] ?? "",

    );
  }
}
