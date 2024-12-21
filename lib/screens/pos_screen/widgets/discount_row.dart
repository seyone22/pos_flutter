import 'package:flutter/material.dart';

class DiscountRow extends StatelessWidget {
  final bool isPercentageDiscount;
  final double discount;
  final Function(bool) onDiscountChanged;

  const DiscountRow({super.key, 
    required this.isPercentageDiscount,
    required this.discount,
    required this.onDiscountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Discount:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        Switch(
          value: isPercentageDiscount,
          onChanged: onDiscountChanged,
        ),
        Text(
          isPercentageDiscount ? '%' : '#',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 100,
          child: TextField(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final newDiscount = double.tryParse(value) ?? 0.0;
              //onDiscountChanged(newDiscount);
            },
          ),
        ),
      ],
    );
  }
}
