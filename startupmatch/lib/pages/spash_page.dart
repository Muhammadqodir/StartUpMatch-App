import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startupmatch/cubit/auth_cubit.dart';
import 'package:startupmatch/pages/auth_page/auth_page.dart';
import 'package:startupmatch/pages/main_page/main_page.dart';
import 'package:startupmatch/utils/dialogs.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double gradientRadius = 0.5;
  bool _hasNavigated = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading();
  }

  void loading() async {
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      gradientRadius = 2;
    });
    await Future.delayed(const Duration(milliseconds: 900));
    context.read<AuthCubit>().checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthorizedState) {
          if (!_hasNavigated) {
            _hasNavigated = true;
            Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                builder: (context) => const MainPage(),
              ),
            );
          }
        } else if (state is UnAuthorizedState) {
          Navigator.of(context).pushReplacement(
            CupertinoPageRoute(
              builder: (context) => const AuthPage(),
            ),
          );
        } else if (state is ErrorAuthState) {
          showAlertDialog(
            context: context,
            title: state.title,
            message: state.message,
            onOk: () {
              context.read<AuthCubit>().logout();
            },
          );
        }
      },
      child: Scaffold(
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 900),
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0, 0),
              radius: gradientRadius,
              colors: const [
                Color(0xFF0141A2),
                Color(0xFF012B6F),
              ],
              stops: const [0.4, 1.0],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Image.asset(
                "assets/icon_white.png",
                width: 170,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
