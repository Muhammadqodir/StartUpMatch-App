import 'package:flutter/material.dart';
import 'package:startupmatch/cubit/chat_cubit.dart';
import 'package:startupmatch/cubit/feed_cubit.dart';
import 'package:startupmatch/cubit/auth_cubit.dart';
import 'package:startupmatch/cubit/createpost_cubit.dart';
import 'package:startupmatch/cubit/message_cubit.dart';
import 'package:startupmatch/cubit/my_posts_cubit.dart';
import 'package:startupmatch/cubit/video_player_cubit.dart';
import 'package:startupmatch/di/di.dart';
import 'package:startupmatch/pages/spash_page.dart';
import 'package:startupmatch/utils/themes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await setupDependencies();
  await getIt.allReady();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('ru', 'RU'),
        Locale('en', 'US'),
      ],
      path: 'assets/lang',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedCubit>(
          create: (context) => FeedCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<MessageCubit>(
          create: (context) => MessageCubit(),
        ),
        BlocProvider<MyPostsCubit>(
          create: (context) => MyPostsCubit(),
        ),
        BlocProvider<ChatCubit>(
          create: (context) => ChatCubit(),
        ),
        BlocProvider<CreatePostCubit>(
          create: (context) => CreatePostCubit(),
        ),
        BlocProvider<VideoPlayerCubit>(
          create: (context) => VideoPlayerCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'StartUp Match',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: const SplashPage(),
      ),
    );
  }
}
