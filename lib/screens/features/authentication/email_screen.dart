import 'package:flutter/material.dart';
import 'package:tiktok_cline/constants/gaps.dart';
import 'package:tiktok_cline/constants/sizes.dart';
import 'package:tiktok_cline/screens/features/authentication/password_screen.dart';
import 'package:tiktok_cline/screens/features/authentication/widgets/form_button.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  //텍스트입력을 감지하는 컨트롤러를 선언.

  String _email = "";

  @override
  void initState() {
    //초기화 하는 이유는 그래야 이벤트 리스너를 등록할수 있기 때문
    super.initState();

    _emailController.addListener(() {
      //컨트롤러에 이벤트 리스너를 달고 setState안에다 새로운 값을 갱신
      setState(() {
        _email = _emailController.text;
        //리스너를 통해서 감지한 값을 setState를 통해서 계속 값을 업데이트 해줌
      });
    });
  }

//이벤트리스너를 꼭 꺼줘야함
//안그러면 앱 crashing남 메모리를 잡아먹기 때문
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
    //initstate에서는 super.initState로 일단 정리하고 시작
    //dispose에서는 다 끝나고 나서 super.dispose로 청소
  }

  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    //이것은 정규표현식이라고 하는것
    //이메일 형식과 일치하지 않으면 낫발리드를 리턴
    if (!regExp.hasMatch(_email)) {
      return "Email not valid";
    }
    return null;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }
  //포커스 되어있는 텍스트창 바깥 아무데나 터치하면 언포커스 됨
  //그러면서 아래 키보드창이 내려감

  void _onSubmit() {
    if (_email.isEmpty || _isEmailValid() != null) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PasswordScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
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
                "What is your email?",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.v16,
              TextField(
                //텍스트입력창 위젯
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                //이메일을 치기 쉽게 키보드에 @가 추가됨
                onEditingComplete: _onSubmit,
                autocorrect: false,
                //자동수정기능 끄기
                decoration: InputDecoration(
                  hintText: "Email",
                  errorText: _isEmailValid(),
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
                onTap: _onSubmit,
                child: FormButton(
                  disabled: _email.isEmpty || _isEmailValid() != null,
                ),
              ),
              //isEmailValid를 추가 하므로써 올바른 이메일 형식이왔을때
              //버튼이 활성화
            ],
          ),
        ),
      ),
    );
  }
}
