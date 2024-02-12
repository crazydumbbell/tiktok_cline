import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_cline/constants/gaps.dart';
import 'package:tiktok_cline/constants/sizes.dart';
import 'package:tiktok_cline/screens/features/main_navigation/main_navigation_screen.dart';

enum Direction { right, left }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.right;
  Page _showingPage = Page.first;

  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      setState(() {
        _direction = Direction.right;
      });
    } else {
      setState(() {
        _direction = Direction.left;
      });
    }
  }

  void _onPanEnd(DragEndDetails detail) {
    if (_direction == Direction.left) {
      setState(() {
        _showingPage = Page.second;
      });
    } else {
      setState(() {
        _showingPage = Page.first;
      });
    }
  }

  void _onEnterTap() {
    Navigator.of(context).pushAndRemoveUntil(
      //push는 뒤로가기가 가능해서 RemoveUntill로 이전페이지 삭제
      MaterialPageRoute(
        builder: (context) => const MainNavigationScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      //onPanUpdate는 사용자의 드래깅을 감지하고 매개변수로 DragUpdateDetails 를 받음
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: SafeArea(
            child: AnimatedCrossFade(
                firstChild: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v80,
                    Text(
                      "Watch cool videos!",
                      style: TextStyle(
                        fontSize: Sizes.size40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v16,
                    Text(
                      "Videos are personalized for you based on what you watch, like, and share",
                      style: TextStyle(
                        fontSize: Sizes.size20,
                      ),
                    ),
                  ],
                ),
                secondChild: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v80,
                    Text(
                      "Follow the rules",
                      style: TextStyle(
                        fontSize: Sizes.size40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v16,
                    Text(
                      "Take care of one another! please!",
                      style: TextStyle(
                        fontSize: Sizes.size20,
                      ),
                    ),
                  ],
                ),
                crossFadeState: _showingPage == Page.first
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 300)),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size48,
              horizontal: Sizes.size24,
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _showingPage == Page.first ? 0 : 1,
              //AnimatedOpacity 로감싸고 opacity를 조건부로 달아서 second page에서만 보에게됨
              child: CupertinoButton(
                onPressed: _onEnterTap,
                color: Theme.of(context).primaryColor,
                child: const Text("Enter the app!!"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
