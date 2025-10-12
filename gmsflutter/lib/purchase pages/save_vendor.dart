import 'package:flutter/material.dart';
import 'package:gmsflutter/service/purchase_service/vendor_service.dart';

class SaveVendor extends StatefulWidget {
  const SaveVendor({super.key});

  @override
  State<SaveVendor> createState() => _SaveVendorState();
}

class _SaveVendorState extends State<SaveVendor> {
  final VendorService vendorService = VendorService();

  final _vendorNameController = TextEditingController();
  // ekhan theke suru 

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
