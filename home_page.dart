import 'package:flutter/material.dart';
import 'package:quotes_of_the_day/quotes_model.dart';
import 'package:quotes_of_the_day/api.dart';
import 'package:quotes_of_the_day/favorites_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool inprogress = false;
  QuotesModel? quotes;
  List<QuotesModel> favoriteQuotes = [];
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            color: Colors.blue,
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              "Quotes of the Day",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Container(
                color: Colors.orange,
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "Today's Quotes",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        quotes?.a ?? 'Author',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'monospace',
                          color: Color.fromARGB(255, 84, 173, 247),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        quotes?.q ?? 'Quote',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'serif',
                          color: Color.fromARGB(255, 84, 173, 247),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: isFavorite ? Colors.red : Colors.grey,
                              ),
                              onPressed: () {
                                if (quotes != null) {
                                  setState(() {
                                    isFavorite = !isFavorite;
                                    if (isFavorite) {
                                      favoriteQuotes.add(quotes!);
                                    } else {
                                      favoriteQuotes.remove(quotes);
                                    }
                                  });
                                }
                              },
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () {
                                _fetchQuotes();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 76, 172, 245),
                              ),
                              child: const Text(
                                "Generate",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FavoritesPage(favoriteQuotes: favoriteQuotes),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: const Text(
                  "View Favorites",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _fetchQuotes() async {
    setState(() {
      inprogress = true;
    });
    try {
      final fetchquotes = await Api.fetchRandomQuotes();
      debugPrint('Fetched quotes: ${fetchquotes.toJson().toString()}');
      setState(() {
        quotes = fetchquotes;
        isFavorite = favoriteQuotes.contains(quotes);
      });
    } catch (e) {
      debugPrint('Failed to generate quotes: $e');
    } finally {
      setState(() {
        inprogress = false;
      });
    }
  }
}
