import 'package:equatable/equatable.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

part 'wishlist_model.g.dart';

@HiveType(typeId: 0)
class Wishlist extends Equatable {
  @HiveField(0)
  final List<String>? authorName;
  @HiveField(1)
  final String title;

  const Wishlist({
    required this.authorName,
    required this.title,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        authorName: json["author_name"] == null
            ? []
            : List<String>.from(json["author_name"]!.map((x) => x)),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "author_name": authorName == null
            ? []
            : List<dynamic>.from(authorName!.map((x) => x)),
        "title": title,
      };

  @override
  List<Object?> get props => [authorName, title];
}
