import 'package:flutter/material.dart';

class PosCard extends StatefulWidget {
  final String itemName;
  final Color defaultOutlineColor;

  const PosCard({
    Key? key,
    required this.itemName,
    this.defaultOutlineColor = Colors.grey,
  }) : super(key: key);

  @override
  _PosCardState createState() => _PosCardState();
}

class _PosCardState extends State<PosCard> {
  int quantity = 0;
  Color outlineColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    outlineColor = widget.defaultOutlineColor;
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
      outlineColor = Colors.green;
    });
  }

    // Function to decrement quantity and update color
  void decrementQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
        outlineColor = (quantity == 0) ? widget.defaultOutlineColor : Colors.red; // Change color when decrementing
      });
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: outlineColor, // Dynamic outline color
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0, // Flat card with no shadow
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(widget.itemName, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Text('Quantity: $quantity', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: decrementQuantity, // Decrease quantity
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: incrementQuantity, // Increase quantity
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}