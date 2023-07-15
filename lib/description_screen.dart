import 'package:flutter/material.dart';

class DescriptionScreen extends StatefulWidget {
  final String title;
  final String desc;
  const DescriptionScreen({super.key, required this.title, required this.desc});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('D E T A I L S'),
        backgroundColor: Colors.green.shade50,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.pink.shade50,
                child: ListTile(
                  title: Text(
                    'Title:${widget.title}',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.pink.shade50,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Description:${widget.desc}'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
