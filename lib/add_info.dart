import 'package:flutter/material.dart';

class AddInformation extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  const AddInformation({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  State<AddInformation> createState() => _AddInformationState();
}

class _AddInformationState extends State<AddInformation> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 110,
      width: deviceWidth * 0.26,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(widget.icon, size: 34),
          Text(widget.label, style: TextStyle(fontSize: 18)),
          Text(
            widget.value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
