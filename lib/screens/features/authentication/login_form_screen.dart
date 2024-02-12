import 'package:flutter/material.dart';
import 'package:tiktok_cline/constants/gaps.dart';
import 'package:tiktok_cline/constants/sizes.dart';
import 'package:tiktok_cline/screens/features/authentication/widgets/form_button.dart';
import 'package:tiktok_cline/screens/features/onbording/interests_screen.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        //이 save는 onsave콜백을 호출함.
        Navigator.of(context).pushAndRemoveUntil(
            //push는 뒤로가기가 가능해서 RemoveUntill로 이전페이지 삭제
            MaterialPageRoute(
              builder: (context) => const InterestsScreen(),
            ),
            (route) => false);
      }
    }

    //유효성 검사가 이렇게 한줄에 쌉가능!
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Gaps.v28,
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "i dont  like your email";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  if (newValue != null) {
                    formData['email'] = newValue;
                  }
                },
              ),
              Gaps.v16,
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'wronog password';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  if (newValue != null) {
                    formData['password'] = newValue;
                  }
                },
                //폼에 입력한 값을 저장
              ),
              Gaps.v28,
              GestureDetector(
                onTap: _onSubmitTap,
                child: const FormButton(disabled: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
