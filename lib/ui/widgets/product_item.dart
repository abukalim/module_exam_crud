import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductItem({
    Key? key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: product.img.isNotEmpty
          ? Image.network(
        product.img,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.image_not_supported, size: 50);
        },
      )
          : Icon(Icons.image_not_supported, size: 50),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(product.productName, style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text('Code: ${product.productCode}')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text('Qty: ${product.qty}')),
              Expanded(child: Text('Total Price: ₹${product.totalPrice.toStringAsFixed(2)}')),
            ],
          ),
          Text('Unit Price: ₹${product.unitPrice.toStringAsFixed(2)}'),
        ],
      ),
      trailing: Wrap(
        spacing: 12, // Space between buttons
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: onEdit,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
