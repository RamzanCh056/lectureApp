class AddFormData {
  String? name;
  String? phoneno;
  String? email;
  String? message;
  int? uploadTime;
  String? doc;

  AddFormData({
    this.name,
    this.phoneno,
    this.email,
    this.message,
    this.uploadTime,
    this.doc,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "phone_no": this.phoneno,
      "email": this.email,
      "message": this.message,
      "uploadTime": this.uploadTime,
      "doc": this.doc,
    };
  }

  factory AddFormData.fromJson(Map<String, dynamic> json) {
    return AddFormData(
      name: json["name"] ?? "",
      phoneno: json["phone_no"] ?? "",
      email: json["email"] ?? "",
      message: json["message"] ?? "",
      uploadTime: json["uploadTime"] ?? "",
      doc: json["doc"] ?? "",
    );
  }
}
