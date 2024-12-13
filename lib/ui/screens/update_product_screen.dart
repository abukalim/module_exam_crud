import 'package:flutter/material.dart';
import 'package:module_exam_crud/models/product.dart';
import 'package:module_exam_crud/services/api_service.dart';

class UpdateProductScreen extends StatefulWidget {
  final Product product;

  UpdateProductScreen({required this.product});

  @override
  _UpdateProductScreenState createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _productCodeController;
  late TextEditingController _productNameController;
  late TextEditingController _qtyController;
  late TextEditingController _unitPriceController;
  late TextEditingController _imgController;
  late TextEditingController _totalPriceController;

  bool _isLoading = false;

  void _calculateTotalPrice() {
    final int? quantity = int.tryParse(_qtyController.text);
    final double? unitPrice = double.tryParse(_unitPriceController.text);

    if (quantity != null && unitPrice != null) {
      setState(() {
        _totalPriceController.text = (quantity * unitPrice).toStringAsFixed(2);
      });
    } else {
      setState(() {
        _totalPriceController.text = '0.00';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _productCodeController = TextEditingController(text: widget.product.productCode);
    _productNameController = TextEditingController(text: widget.product.productName);
    _qtyController = TextEditingController(text: widget.product.qty.toString());
    _unitPriceController = TextEditingController(text: widget.product.unitPrice.toString());
    _imgController = TextEditingController(text: widget.product.img);
    _totalPriceController = TextEditingController(
      text: (widget.product.qty * widget.product.unitPrice).toStringAsFixed(2),
    );

    _qtyController.addListener(_calculateTotalPrice);
    _unitPriceController.addListener(_calculateTotalPrice);
  }

  @override
  void dispose() {
    _qtyController.removeListener(_calculateTotalPrice);
    _unitPriceController.removeListener(_calculateTotalPrice);

    _qtyController.dispose();
    _unitPriceController.dispose();
    _productCodeController.dispose();
    _productNameController.dispose();
    _imgController.dispose();
    _totalPriceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _productCodeController,
                decoration: InputDecoration(labelText: 'Product Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product code';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _productNameController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _qtyController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _unitPriceController,
                decoration: InputDecoration(labelText: 'Unit Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the unit price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imgController,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _totalPriceController,
                decoration: InputDecoration(labelText: 'Total Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the total price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        final updatedProduct = Product(
                          id: widget.product.id,
                          img: _imgController.text,
                          productCode: _productCodeController.text,
                          productName: _productNameController.text,
                          qty: int.parse(_qtyController.text),
                          totalPrice: double.parse(_totalPriceController.text),
                          unitPrice: double.parse(_unitPriceController.text),
                        );

                        await ApiService().updateProduct(widget.product.id, updatedProduct);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Product updated successfully')),
                        );

                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to update product: $e')),
                        );
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    }
                  },
                  child: _isLoading
                      ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                      : Text('Update Product'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
