import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBarGenerator extends StatefulWidget {
  const AppBarGenerator({Key? key}) : super(key: key);

  @override
  _AppBarGeneratorState createState() => _AppBarGeneratorState();
}

class _AppBarGeneratorState extends State<AppBarGenerator> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 0,
      child: Container(
        color: const Color(0xff161B22),
        child: Row(
          children: [
            Row(
              children: const [
                SizedBox(
                  width: 5,
                ),
                Icon(
                  EvaIcons.plusCircleOutline,
                  color: Colors.white,
                  size: 28,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'New',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const FaIcon(EvaIcons.arrowBackOutline),
                  color: const Color(0xffffffff),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const FaIcon(EvaIcons.arrowForwardOutline),
                  color: const Color(0xffffffff),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                EvaIcons.saveOutline,
                size: 30,
              ),
              color: const Color(0xffffffff),
            ),
          ],
        ),
      ),
    );
  }
}
