import 'package:flutter/material.dart';

class PortfolioSection extends StatelessWidget {
  final List<Map<String, String>> portfolioList = [
    {'title': 'GitHub Profile', 'link': 'https://github.com/Bee0510'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PORTFOLIO/ WORK SAMPLES',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: portfolioList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(portfolioList[index]['title']!,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              subtitle: Text(portfolioList[index]['link']!,
                  style: TextStyle(fontSize: 12, color: Colors.blue)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.grey),
                    onPressed: () {
                      // Handle edit press
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.grey),
                    onPressed: () {
                      // Handle delete press
                    },
                  ),
                ],
              ),
            );
          },
        ),
        TextButton(
          onPressed: () {
            // Handle add portfolio press
          },
          child: Text('+ Add portfolio/ work sample',
              style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}
