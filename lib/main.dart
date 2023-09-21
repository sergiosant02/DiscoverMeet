import 'package:discover_meet/src/models/user_model.dart';
import 'package:discover_meet/src/pages/Question/question_list_page.dart';
import 'package:discover_meet/src/pages/Questionnaire/my_questionnaire_list_page.dart';
import 'package:discover_meet/src/pages/Questionnaire/questionnaire_list_page.dart';
import 'package:discover_meet/src/pages/UserPage/list_partcipants_room.dart';
import 'package:discover_meet/src/pages/UserPage/user_form.dart';
import 'package:discover_meet/src/pages/menu_page.dart';
import 'package:discover_meet/src/providers/page_provider.dart';
import 'package:discover_meet/src/sharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final UserPreferences pref = UserPreferences();
bool validToken = true;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await pref.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(initialLocation: '/', routes: [
    // GoRoute(path: '/home', builder: (context, state) => const MenuPage()),
    GoRoute(
        path: '/',
        routes: [
          GoRoute(
              path: ':roomId/questionnaire',
              builder: (context, state) => QuestionnaireListPage(
                  roomId: state.pathParameters['roomId']!),
              routes: [
                GoRoute(
                    path: ':questionnaireId/question',
                    builder: (context, state) => QuestionListPage(
                          questionnaireId:
                              state.pathParameters["questionnaireId"]!,
                        )),
              ]),
          GoRoute(
              path: ':roomId/questionnaire/mine',
              builder: (context, state) => MyQuestionnaireListPage(
                  roomId: state.pathParameters['roomId']!),
              routes: [
                GoRoute(
                    path: ':questionnaireId/question',
                    builder: (context, state) => QuestionListPage(
                          questionnaireId:
                              state.pathParameters["questionnaireId"]!,
                        )),
              ]),
          GoRoute(
            path: ':roomId/participants',
            builder: (context, state) => ListParticipantsRoom(
                roomModelId: state.pathParameters['roomId']!),
          ),
          GoRoute(
              name: '/updateUser',
              path: 'updateUser',
              builder: (context, state) {
                return UserForm(
                  user: UserModel.fromJson(state.queryParameters),
                );
              })
        ],
        builder: (context, state) => const MenuPage())
  ]);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PageProvider(),
      child: MaterialApp.router(
        title: 'Discover meet',
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
