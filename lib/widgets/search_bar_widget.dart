import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchBarSliverAppBar extends StatelessWidget {
  final Function(String) onSearch;

  const SearchBarSliverAppBar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);

    return SliverAppBar(
      floating: true,
      snap: true, // Makes the app bar appear and disappear as you scroll
      expandedHeight: 120.0, // Adjust the size as needed
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: localizations!
                  .search, // Ensure localization is correctly set up
              // hintText: 'Enter search term',
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
            onSubmitted: onSearch,
          ),
        ),
      ),
    );
  }
}
