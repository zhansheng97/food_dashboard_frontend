import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_dashboard/constants.dart';
import 'package:food_dashboard/responsive.dart';
import 'package:food_dashboard/screens/bloc/page_bloc.dart';
import 'package:food_dashboard/screens/home/home_screen.dart';
import 'package:food_dashboard/screens/sign_in/sign_in_screen.dart';
import 'package:food_dashboard/widgets/side_menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'di/get_it.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PageBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme:
              GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
          primarySwatch: Colors.blue,
        ),
        // home: MainScreen(),
        home: FutureBuilder<Widget>(
          initialData: SignInScreen(),
          future: checkWhetherUserHaveJwtToken(),
          builder: (context, snapshot) {
            return snapshot.data!;
          },
        ),
      ),
    );
  }

  Future<Widget> checkWhetherUserHaveJwtToken() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      return SignInScreen();
    } else {
      return MainScreen();
    }
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PageBloc>().add(ChangePageEvent(index: 0));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        children: [
          ResponsiveWidget(
            mobile: mobileWidget(),
            tablet: tabletWidget(),
            desktop: Container(
              height: 753.59,
              child: Row(
                children: [
                  Expanded(
                    flex: (width < 1200) ? 2 : 1,
                    child: SideMenu(),
                  ),
                  Expanded(
                    flex: (width < 1200) ? 7 : 5,
                    child: BlocBuilder<PageBloc, PageState>(
                      builder: (context, state) {
                        if (state is PageLoaded) {
                          return state.page;
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mobileWidget() {
    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) {
        if (state is PageLoaded) {
          return state.page;
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget tabletWidget() {
    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) {
        if (state is PageLoaded) {
          return state.page;
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;

  const ActionButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              text,
              style: normalText.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
