//아래는 추출한 녀석
//추출하는 이유는 색의 변화를 감지해서 다음단계로 넘어가는 기능을 만드려고
import 'package:flutter/material.dart';
import 'package:tiktok_cline/constants/sizes.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.disabled,
  });

  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        //컨테이너위젯에 애니메이션 효과 추가.
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Sizes.size5,
          ),
          color:
              disabled ? Colors.grey.shade300 : Theme.of(context).primaryColor,
        ),
        duration: const Duration(milliseconds: 300),
        child: AnimatedDefaultTextStyle(
          //AnimatedContainer는 자식까지 애니매이션 안시켜서 자식도 이렇게 해줘야됨
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            color: disabled ? Colors.grey.shade400 : Colors.white,
            fontWeight: FontWeight.w600,
          ),
          child: const Text(
            'Next',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
