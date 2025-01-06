import 'dart:convert';

BookModel bookModelFromJson(String str) => BookModel.fromJson(json.decode(str));

String bookModelToJson(BookModel data) => json.encode(data.toJson());

class BookModel {
  List<Doc> docs;

  BookModel({
    required this.docs,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        docs: List<Doc>.from(json["docs"].map((x) => Doc.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "docs": List<dynamic>.from(docs.map((x) => x.toJson())),
      };
}

class Doc {
  List<String>? authorName;

  int editionCount;

  int? firstPublishYear;

  bool hasFulltext;

  String title;

  Doc({
    this.authorName,
    required this.editionCount,
    this.firstPublishYear,
    required this.hasFulltext,
    required this.title,
  });

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        authorName: json["author_name"] == null
            ? []
            : List<String>.from(json["author_name"]!.map((x) => x)),
        editionCount: json["edition_count"],
        firstPublishYear: json["first_publish_year"],
        hasFulltext: json["has_fulltext"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "author_name": authorName == null
            ? []
            : List<dynamic>.from(authorName!.map((x) => x)),
        "edition_count": editionCount,
        "first_publish_year": firstPublishYear,
        "has_fulltext": hasFulltext,
        "title": title,
      };
}
