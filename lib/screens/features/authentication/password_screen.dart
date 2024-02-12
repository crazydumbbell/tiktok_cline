import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_cline/constants/gaps.dart';
import 'package:tiktok_cline/constants/sizes.dart';
import 'package:tiktok_cline/screens/features/authentication/birthday_screen.dart';
import 'package:tiktok_cline/screens/features/authentication/widgets/form_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  //텍스트입력을 감지하는 컨트롤러를 선언.

  String _password = "";

  bool _obscureText = true;

  @override
  void initState() {
    //초기화 하는 이유는 그래야 이벤트 리스너를 등록할수 있기 때문
    super.initState();

    _passwordController.addListener(() {
      //컨트롤러에 이벤트 리스너를 달고 setState안에다 새로운 값을 갱신
      setState(() {
        _password = _passwordController.text;
        //리스너를 통해서 감지한 값을 setState를 통해서 계속 값을 업데이트 해줌
      });
    });
  }

//이벤트리스너를 꼭 꺼줘야함
//안그러면 앱 crashing남 메모리를 잡아먹기 때문
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
    //initstate에서는 super.initState로 일단 정리하고 시작
    //dispose에서는 다 끝나고 나서 super.dispose로 청소
  }

  bool _isPasswordValid() {
    return _password.isNotEmpty && _password.length > 8;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }
  //포커스 되어있는 텍스트창 바깥 아무데나 터치하면 언포커스 됨
  //그러면서 아래 키보드창이 내려감

  void _onSubmit() {
    if (!_isPasswordValid()) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BirthdayScreen(),
      ),
    );
  }

  void _onClearTap() {
    _passwordController.clear();
  }
  //입력된 패스워드 전제 삭제

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    //아주아주 심플해진 모습
    setState(() {});
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
                "What is your password?",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.v16,
              TextField(
                //텍스트입력창 위젯
                controller: _passwordController,
                //이메일을 치기 쉽게 키보드에 @가 추가됨
                onEditingComplete: _onSubmit,
                obscureText: _obscureText,
                autocorrect: false,
                //자동수정기능 끄기
                decoration: InputDecoration(
                  suffix: Row(
                      mainAxisSize: MainAxisSize.min,
                      //이걸 안해주면 아이콘이 칸 전부를 차지해 버려서
                      //안에 make it strong도 안보임
                      children: [
                        GestureDetector(
                          onTap: _onClearTap,
                          child: FaIcon(
                            FontAwesomeIcons.solidCircleXmark,
                            color: Colors.grey.shade400,
                            size: Sizes.size20,
                          ),
                        ),
                        Gaps.h16,
                        GestureDetector(
                          onTap: _toggleObscureText,
                          child: FaIcon(
                            _obscureText
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: Colors.grey.shade400,
                            size: Sizes.size20,
                          ),
                        ),
                      ]),
                  hintText: "Make it strong!",
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
              Gaps.v10,
              const Text(
                'Your password must have:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v10,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size20,
                    color: _isPasswordValid()
                        ? Colors.green
                        : Colors.grey.shade400,
                  ),
                  Gaps.h5,
                  const Text("8 to 20 characters")
                ],
              ),
              Gaps.v16,
              GestureDetector(
                onTap: _onSubmit,
                child: FormButton(
                  disabled: !_isPasswordValid(),
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
