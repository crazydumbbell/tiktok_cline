import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_cline/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;

  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      //box위젯인데 부모의 크기에 비례해서 크기를 정함
      widthFactor: 1,
      //1은 부모크기 꽉차게
      child: Container(
        padding: const EdgeInsets.all(
          Sizes.size14,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: Sizes.size1,
          ),
        ),
        child: Stack(
          //Stack으로 아이콘은 왼쪽에 text는 가운데 정렬
          //팬케이크처럼 위젯을 쌓음
          alignment: Alignment.center,
          children: [
            Align(
              //Align태그로 Stack에 쌓여있는 위젯중에 고유하게 컨트롤
              alignment: Alignment.centerLeft,
              child: icon,
            ),
            Text(
              text,
              style: const TextStyle(
                  fontSize: Sizes.size16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
