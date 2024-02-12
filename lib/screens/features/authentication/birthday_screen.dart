import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_cline/constants/gaps.dart';
import 'package:tiktok_cline/constants/sizes.dart';
import 'package:tiktok_cline/screens/features/authentication/widgets/form_button.dart';
import 'package:tiktok_cline/screens/features/onbording/interests_screen.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();
  //텍스트입력을 감지하는 컨트롤러를 선언.

  DateTime initialDate = DateTime.now();

  @override
  void initState() {
    //초기화 하는 이유는 그래야 이벤트 리스너를 등록할수 있기 때문
    super.initState();
    _setTextFieldDate(initialDate);
  }

//이벤트리스너를 꼭 꺼줘야함
//안그러면 앱 crashing남 메모리를 잡아먹기 때문
  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
    //initstate에서는 super.initState로 일단 정리하고 시작
    //dispose에서는 다 끝나고 나서 super.dispose로 청소
  }

  void _onNextTap() {
    //참고로 여기서 buildContext context를 안받는 이유는
    //state안에 존재하기때문에 context는 이미 공유되고있는 상태이기 때문

    Navigator.of(context).pushAndRemoveUntil(
      //push는 뒤로가기가 가능해서 RemoveUntill로 이전페이지 삭제
      MaterialPageRoute(
        builder: (context) => const InterestsScreen(),
      ),
      (route) => false,
    );
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(text: textDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Sign Up",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              "When's your birthday",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gaps.v8,
            const Text(
              "Your birthday won't be publicly",
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black54,
              ),
            ),
            Gaps.v16,
            TextField(
              enabled: false,
              controller: _birthdayController,
              decoration: InputDecoration(
                hintText: "Birthda",
                enabledBorder: UnderlineInputBorder(
                  //활성화전 색상
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  //활성화후 색상 (동일)
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v16,
            GestureDetector(
              onTap: _onNextTap,
              child: const FormButton(
                disabled: false,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 300,
          child: CupertinoDatePicker(
            maximumDate: initialDate,
            initialDateTime: initialDate,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: _setTextFieldDate,
          ),
        ),
      ),
    );
  }
}
