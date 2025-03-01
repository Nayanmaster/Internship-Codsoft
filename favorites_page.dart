import 'package:flutter/material.dart';
import 'package:quotes_of_the_day/quotes_model.dart';

class FavoritesPage extends StatelessWidget {
  final List<QuotesModel> favoriteQuotes;

  const FavoritesPage({super.key, required this.favoriteQuotes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Quotes"),
      ),
      body: ListView.builder(
        itemCount: favoriteQuotes.length,
        itemBuilder: (context, index) {
          final quote = favoriteQuotes[index];
          return ListTile(
            title: Text(quote.q ?? 'Quote'),
            subtitle: Text(quote.a ?? 'Author'),
          );
        },
      ),
    );
  }
}
