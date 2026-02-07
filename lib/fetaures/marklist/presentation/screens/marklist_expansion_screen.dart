import 'package:flutter/material.dart';

class MarklistExpansionScreen extends StatelessWidget {
  const MarklistExpansionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mark List")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // HEADER ROW
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: const [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Sl",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Subject",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Mark Obtained",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Total Mark",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // TABLE ROWS
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10, // static data
              itemBuilder: (context, index) {
                final isEven = index.isEven;

                return Container(
                  padding: EdgeInsets.symmetric(
                    vertical: isEven ? 20 : 12,
                    horizontal: 12,
                  ),
                  color: isEven ? Colors.white : Colors.pink.shade50,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "${index + 1}",
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                      const Expanded(
                        flex: 3,
                        child: Text(
                          "Malayalam",
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                      const Expanded(
                        flex: 2,
                        child: Center(
                          child: Text("70", style: TextStyle(fontSize: 13)),
                        ),
                      ),
                      const Expanded(
                        flex: 2,
                        child: Center(
                          child: Text("100", style: TextStyle(fontSize: 13)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFC4005F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.download, color: Colors.white),
                    SizedBox(width: 10),
                    Text('Download', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
