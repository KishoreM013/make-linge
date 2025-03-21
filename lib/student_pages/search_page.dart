import 'package:flutter/material.dart';
import 'package:makelinge/widgets/bottom_bar.dart';
import 'package:makelinge/widgets/search_tag.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Trigger rebuild to update the stream with the new search text
              setState(() {});
            },
            child: const Text('Search'),
          ),
          Expanded(
            child: StreamBuilder(
              stream: firestore
                  .collection('search_data')
                  .where('email', isEqualTo: searchController.text)
                  .snapshots(),
              builder: (context, snapshot) {
                // Show a loading indicator while waiting for data.
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                // Check if there is data and if there are documents.
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No results found'));
                }
                // Build the ListView with the fetched documents.
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data!.docs[index];
                    return SearchTag(
                      email: doc['email'],
                      name: doc['name'],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
