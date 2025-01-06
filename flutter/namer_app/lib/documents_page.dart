import 'package:flutter/material.dart';

import 'data.dart';

// class DocumentScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(flex: 3, child: DocumentBody(document: Document())),
//       ],
//     );
//   }
// }

class DocumentScreen extends StatelessWidget {
  final Document document;

  const DocumentScreen({
    required this.document,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final (title, modified: modified) = document.metadata;
    final (title, :modified) = document.metadata;
    final formattedModifiedDate = formatDate(modified);
    final blocks = document.getBlocks();

    return Center(
      child: Column(
        children: [
          Text(title),
          Text(
            'Last Modified $formattedModifiedDate',
          ),
          Expanded(
            child: ListView.builder(
                itemCount: blocks.length,
                itemBuilder: (context, index) {
                  return BlockWidget(block: blocks[index]);
                }),
          )
          // ListView.builder(
          //     itemCount: blocks.length,
          //     itemBuilder: (context, index) {
          //       return BlockWidget(block: blocks[index]);
          //     }),
        ],
      ),
    );
  }
}

class BlockWidget extends StatelessWidget {
  final Block block;

  const BlockWidget({required this.block, super.key});

  @override
  Widget build(BuildContext context) {
    // TextStyle? textStyle;
    // textStyle = switch (block.type) {
    //   'h1' => Theme.of(context).textTheme.displayMedium,
    //   'p' || 'checkbox' => Theme.of(context).textTheme.bodyMedium,
    //   _ => Theme.of(context).textTheme.bodySmall
    // };
    // switch (block.type) {
    //   case 'h1':
    //     textStyle = Theme.of(context).textTheme.displayMedium;
    //   case 'p' || 'checkbox':
    //     textStyle = Theme.of(context).textTheme.bodyMedium;
    //   case _:
    //     textStyle = Theme.of(context).textTheme.bodySmall;
    // }

    return Container(
        margin: const EdgeInsets.all(8),
        child: switch (block) {
          HeaderBlock(:final text) => Text(
              text,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ParagraphBlock(:final text) => Text(text),
          CheckboxBlock(:final text, :final isChecked) => Row(
              children: [
                Checkbox(value: isChecked, onChanged: (_) {}),
                Text(text),
              ],
            )
        });
    // return Container(
    //   margin: const EdgeInsets.all(8),
    //   child: Text(
    //     block.text,
    //     style: textStyle,
    //   ),
    // );
  }
}

String formatDate(DateTime datetime) {
  final today = DateTime.now();
  final difference = datetime.difference(today);

  return switch (difference) {
    Duration(inDays: 0) => 'today',
    Duration(inDays: 1) => 'tomorrow',
    Duration(inDays: -1) => 'yesterday',
    Duration(inDays: final days) when days > 7 => '${days ~/ 7} weeks from now',
    Duration(inDays: final days) when days < -7 =>
      '${days.abs() ~/ 7} weeks ago',
    Duration(inDays: final days, isNegative: true) => '${days.abs()} days ago',
    Duration(inDays: final days) => '$days days from now',
  };
}
