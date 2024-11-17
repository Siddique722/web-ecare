// import 'package:flutter/material.dart';

// class LighDarkDropDown extends StatelessWidget {
//   final String hint;
//   final List<String> items;
//   final String? value;
//   final ValueChanged<String?> onChanged;

//   const LighDarkDropDown({
//     Key? key,
//     required this.hint,
//     required this.items,
//     this.value,
//     required this.onChanged,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: DropdownButtonFormField<String>(
//         decoration: InputDecoration(
//          enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(
//               color: Theme.of(context).colorScheme.primary,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(
//               color: Theme.of(context).colorScheme.primary,
//             ),
//           ),
//         ),
//         hint: Text(
//           hint,
//           style: TextStyle(
//             color: Theme.of(context).colorScheme.primary,
//           ),
//         ),
//         value: value,
//         items: items.map((String item) {
//           return DropdownMenuItem<String>(
//             value: item,
//             child: Text(
//               item,
//               style: TextStyle(
//                 color: Theme.of(context).colorScheme.primary,
//               ),
//             ),
//           );
//         }).toList(),
        
//         onChanged: onChanged,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class LighDarkDropDown extends StatelessWidget {
  final String hint;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final bool enabled;  // New parameter

  const LighDarkDropDown({
    Key? key,
    required this.hint,
    required this.items,
    this.value,
    required this.onChanged,
    this.enabled = true,  // Default value set to true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        hint: Text(
          hint,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        value: value,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        }).toList(),
        onChanged: enabled ? onChanged : null,  // Disable onChanged if not enabled
        disabledHint: enabled
            ? null
            : Text(
                hint,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                ),
              ),
      ),
    );
  }
}


class LightDarkDropDown2 extends StatefulWidget {
  final String hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? value;
  final bool enabled;

  LightDarkDropDown2({
    required this.hint,
    required this.items,
    required this.onChanged,
    this.value,
    this.enabled = true,
  });

  @override
  _LightDarkDropDown2State createState() => _LightDarkDropDown2State();
}

class _LightDarkDropDown2State extends State<LightDarkDropDown2> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value; // Initialize with the passed value if any
  }

  @override
  Widget build(BuildContext context) {
    // Creating a unique list of dropdown items
    List<DropdownMenuItem<String>> dropdownItems = widget.items
        .asMap()
        .entries
        .map((entry) {
          int index = entry.key;
          String value = entry.value;
          return DropdownMenuItem<String>(
            value: '$value-$index', // Make value unique
            child: Text(
              value,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        })
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        hint: Text(
          widget.hint,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        value: selectedValue,
        items: dropdownItems,
        onChanged: widget.enabled
            ? (value) {
                setState(() {
                  selectedValue = value;
                });
                widget.onChanged(selectedValue);
              }
            : null, // Disable onChanged if not enabled
        disabledHint: widget.enabled
            ? null
            : Text(
                widget.hint,
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(0.5),
                ),
              ),
      ),
    );
  }
}
