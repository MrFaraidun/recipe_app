import 'package:flutter/material.dart';
import 'search_bar.dart';
import 'search_suggestions.dart';
import 'search_results.dart';
import 'filter_modal.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFilterOpen = false;

  final List<String> recentSearches = ['Pancakes', 'Salad'];
  final List<String> suggestions = [
    'sushi',
    'sandwich',
    'seafood',
    'fried rice',
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _openFilterModal() {
    setState(() => _isFilterOpen = true);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const FilterModal(),
    ).whenComplete(() => setState(() => _isFilterOpen = false));
  }

  void _onBack() {
    Navigator.pop(context);
  }

  void _onClear() {
    setState(() {
      _controller.clear();
    });
  }

  void _onSearchSelect(String term) {
    setState(() {
      _controller.text = term;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            SearchBarWidget(
              controller: _controller,
              focusNode: _focusNode,
              isFilterOpen: _isFilterOpen,
              onClear: _onClear,
              onFilterTap: _openFilterModal,
              onBack: _onBack,
            ),

            // Content
            Expanded(
              child: _controller.text.isNotEmpty
                  ? SearchResults(query: _controller.text)
                  : SearchSuggestions(
                      recentSearches: recentSearches,
                      suggestions: suggestions,
                      onSelect: _onSearchSelect,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
