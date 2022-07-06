import 'package:flutter/material.dart';
import 'package:qube/dashboard/support/kcolors.dart';

class FeelingTile extends StatelessWidget {
  final String title;
  final String emoji;
  final String percentage;
  const FeelingTile({
    Key? key,
    required this.title,
    required this.emoji,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: percentage != "0" ? 1 : 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 40,
            decoration: BoxDecoration(
              color: KColors.gray,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(4, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      percentage != "0" ? "$percentage%" : "",
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: KColors.green,
                    ),
                    child: Center(
                      child: Text(
                        emoji,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
  //
}
