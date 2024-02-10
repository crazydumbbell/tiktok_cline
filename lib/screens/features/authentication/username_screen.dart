import 'package:flutter/material.dart';
import 'package:tiktok_cline/constants/gaps.dart';
import 'package:tiktok_cline/constants/sizes.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();
  //텍스트입력을 감지하는 컨트롤러를 선언.

  String _username = "";

  @override
  void initState() {
    //초기화 하는 이유는 그래야 이벤트 리스너를 등록할수 있기 때문
    super.initState();

    _usernameController.addListener(() {
      //컨트롤러에 이벤트 리스너를 달고 setState안에다 새로운 값을 갱신
      setState(() {
        _username = _usernameController.text;
        //리스너를 통해서 감지한 값을 setState를 통해서 계속 값을 업데이트 해줌
      });
    });
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
              "Create username",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gaps.v8,
            const Text(
              "You can always change this later.",
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black54,
              ),
            ),
            Gaps.v16,
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: "Username",
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
            FractionallySizedBox(
              widthFactor: 1,
              child: AnimatedContainer(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Sizes.size5,
                  ),
                  color: _username.isEmpty
                      ? Colors.grey.shade300
                      : Theme.of(context).primaryColor,
                ),
                duration: const Duration(milliseconds: 300),
                child: const Text(
                  'Next',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
