import 'package:books_app/models/wishlist_model.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class HiveService {
  Future<Box> initHive() async {
    if (!Hive.isBoxOpen('bookBox')) {
      await Hive.initFlutter();
      Hive.registerAdapter(WishlistAdapter());

      Box bookBox = await Hive.openBox('bookBox',
          compactionStrategy: (contents, modifiedContents) {
        return modifiedContents > 20;
      });
      return bookBox;
    } else {
      return getBookBox();
    }
  }

  Box getBookBox() {
    return Hive.box('bookBox');
  }

  saveWishlist(Wishlist wish) {
    Box bookBox = getBookBox();

    // Safely retrieve the wishlist and cast to List<Wishlist>
    List<Wishlist> wishlist =
        (bookBox.get('wishlist') as List<dynamic>?)?.cast<Wishlist>() ?? [];

    // Add the new wishlist item
    wishlist.add(wish);

    // Save the updated list back to Hive
    bookBox.put('wishlist', wishlist);
  }

  removeWishlist(Wishlist wish) {
    Box bookBox = getBookBox();

    // Safely retrieve the wishlist and cast to List<Wishlist>
    List<Wishlist> wishlist =
        (bookBox.get('wishlist') as List<dynamic>?)?.cast<Wishlist>() ?? [];

    // Remove the wishlist item
    wishlist.remove(wish);

    // Save the updated list back to Hive
    bookBox.put('wishlist', wishlist);
  }

 Future< List<Wishlist>> fetchWishlist() async{
    Box bookBox = getBookBox();

    // Safely retrieve the wishlist and cast to List<Wishlist>
    List<Wishlist> wishlist =
        (bookBox.get('wishlist') as List<dynamic>?)?.cast<Wishlist>() ?? [];

    return wishlist;
  }

  clearBox() async {
    Box bookBox = getBookBox();
    await bookBox.clear();
  }
}
