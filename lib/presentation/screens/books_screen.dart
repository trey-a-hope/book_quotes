import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_keeper/presentation/widgets/app_bar_widget.dart';
import 'package:quote_keeper/presentation/widgets/quote_card_widget.dart';
import 'package:quote_keeper/utils/config/providers.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:convert';

import 'package:quote_keeper/utils/constants/globals.dart';

class BooksScreen extends ConsumerStatefulWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<BooksScreen> createState() => _BooksPageState();
}

class _BooksPageState extends ConsumerState<BooksScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      ref.read(Providers.booksAsyncNotifierProvider.notifier).getNextBooks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuild.appBar(
        title: 'Quotes',
        implyLeading: false,
        context: context,
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final booksAsyncValue =
              ref.watch(Providers.booksAsyncNotifierProvider);

          if (booksAsyncValue.hasError) {
            return Center(
              child: Text(
                booksAsyncValue.error.toString(),
              ),
            );
          } else if (booksAsyncValue.hasValue) {
            var books = booksAsyncValue.value!;
            return ListView.builder(
                controller: _scrollController,
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return QuoteCardWidget(
                    book: book,
                    onTap: () => context.goNamed(
                      Globals.routeEditQuote,
                      pathParameters: <String, String>{
                        // Note: Conversion between String and Timestamp since Timestamp can't be encodded.
                        'book': jsonEncode(
                          {
                            'id': book.id,
                            'title': book.title,
                            'author': book.author,
                            'quote': book.quote,
                            'imgPath': book.imgPath,
                            'hidden': book.hidden,
                            'complete': book.complete,
                            'created': book.created.toIso8601String(),
                            'modified': book.modified.toIso8601String(),
                            'uid': book.uid,
                          },
                        )
                      },
                    ),
                  ).animate().fadeIn(duration: 1000.ms).then(
                        delay: 1000.ms,
                      );
                });
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
