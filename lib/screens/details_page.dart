import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_library/features/movie_details/widget/movie_details.dart';

class DetailsPage extends ConsumerWidget {
  final int movieId;
  const DetailsPage({required this.movieId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Stack(
          children: [
            ListView(
              children: [MovieDetails(movieId: movieId)],
            ),
            const Positioned(top: 15, left: 15, child: BackButton())
          ],
        ),
      ),
    );
  }
}
