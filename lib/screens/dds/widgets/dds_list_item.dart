import 'package:flutter/material.dart';

import 'package:ediwallet/screens/dds/models/dds.dart';

class DDSListItem extends StatelessWidget {
  const DDSListItem({Key? key, required this.dds}) : super(key: key);

  final DDS dds;

  @override
  Widget build(BuildContext context) {
    // return Text(
    //   dds.name.replaceAll('', '\u{200B}'),
    //   style: const TextStyle(fontSize: 18.0),
    //   overflow: TextOverflow.ellipsis,
    // );

    // final textTheme = Theme.of(context).textTheme;
    // return Text(dds.name, style: textTheme.caption);

    return ListTile(
      leading: dds.isComing
          ? const Icon(
              Icons.add,
              color: Colors.green,
            )
          : const Icon(
              Icons.remove,
              color: Colors.red,
            ),
      title: Text(
        dds.name.replaceAll('', '\u{200B}'),
        style: const TextStyle(fontSize: 18.0),
        // overflow: TextOverflow.ellipsis,
      ),
      onTap: () => Navigator.of(context).pop(),
      // isThreeLine: true,
      // subtitle: Text(dds.id),
      // dense: true,
    );
  }
}

// Row _buildListItem(DDS dds) {
//   return Row(
//     children: [
//       Expanded(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Flexible(
//               child: Text(
//                 dds.name.replaceAll('', '\u{200B}'),
//                 style: const TextStyle(fontSize: 18.0),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }
