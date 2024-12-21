import 'package:flutter/material.dart';

class TenderedAmountRow extends StatelessWidget {
  final double tendered;
  final Function(double) onTenderedChanged;

  const TenderedAmountRow({super.key, 
    required this.tendered,
    required this.onTenderedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Tendered Amount:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        SizedBox(
          width: 100,
          child: TextField(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final newTendered = double.tryParse(value) ?? 0.0;
              onTenderedChanged(newTendered);
            },
          ),
        ),
      ],
    );
  }
}
