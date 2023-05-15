import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.0),
        color: Colors.grey[200],
      ),
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: TextField(
        style: const TextStyle(
          fontSize: 13.0,
        ),
        controller: _searchController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 11),
          border: InputBorder.none,
          hintStyle: TextStyle(
            fontSize: 14.0,
          ),
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (value) {
          // Perform search operation here
        },
      ),
    );
  }
}
