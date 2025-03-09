import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valbury_test/helper/helper_enum.dart';
import 'package:valbury_test/helper/helper_online_status.dart';
import 'package:valbury_test/screen/dashboard/dashboard_screen.dart';
import 'package:valbury_test/screen/login/login_notifier.dart';
import 'package:valbury_test/widget/progress_dot.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  SupportState _supportState = SupportState.unknown;
  var isObscureText = false;

  late SharedPreferences prefs;
  var email = '';
  var imagePath = '';
  var isFingerPrint = false;

  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecPassword = TextEditingController();
  late HelperOnlineStatus helperOnlineStatus;

  @override
  void initState() {
    super.initState();

    getDataLogin();

    auth.isDeviceSupported().then(
      (bool isSupported) => setState(
        () =>
            _supportState =
                isSupported ? SupportState.supported : SupportState.unsupported,
      ),
    );
  }

  Future<void> getDataLogin() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? '';
      imagePath = prefs.getString('imagePath') ?? '';
      isFingerPrint = prefs.getBool('isFingerPrint') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset('assets/images/waves.jpg', fit: BoxFit.cover),
          ),
          buildLoginForm(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/images/valbury_2.jpeg', height: 75),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Transform.translate(
              offset: Offset(0, -100),
              child: IconButton(
                onPressed: () {
                  if (isFingerPrint) _authenticateWithBiometrics();
                },
                icon: Icon(
                  Icons.fingerprint,
                  size: 50,
                  color: isFingerPrint ? Colors.blueAccent : Colors.grey,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Transform.translate(
              offset: Offset(0, -85),
              child: Text(
                _supportState == SupportState.supported
                    ? isFingerPrint
                        ? 'Fingerprint supported'
                        : 'Fingerprint disabled'
                    : 'Fingerprint not Supported',
                style: GoogleFonts.montserrat(fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Align buildLoginForm() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.all(20),
        width: 300,
        height: 375,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 6, offset: Offset(1, 3)),
          ],
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 4),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  'assets/images/valbury.jpg',
                  height: 50,
                  width: 50,
                ),
              ),
            ),
            Spacer(),
            TextField(
              controller: tecEmail,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                labelText: 'Email',
                labelStyle: GoogleFonts.montserrat(),
              ),
              onChanged: (text) {
                setState(() {});
              },
            ),
            Container(height: 20),
            TextField(
              controller: tecPassword,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  key: Key('button_login'),
                  icon: Icon(
                    isObscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscureText = !isObscureText;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                labelText: 'Password',
                labelStyle: GoogleFonts.montserrat(),
              ),
              style: const TextStyle(fontSize: 14),
              autocorrect: false,
              enableSuggestions: false,
              textAlign: TextAlign.start,
              maxLines: isObscureText ? 1 : null,
              obscureText: isObscureText,
            ),
            Container(height: 15),
            Consumer<LoginNotifier>(
              builder: (context, data, child) {
                return data.stateLogin == RequestState.loading
                    ? WidgetDotBounce(color: Colors.blue)
                    : TextButton(
                      onPressed: () {
                        context.read<LoginNotifier>().doLogin(
                          context,
                          tecEmail.text,
                          tecPassword.text,
                        );
                      },
                      style: ButtonStyle(
                        padding: WidgetStateProperty.resolveWith((state) {
                          return EdgeInsets.symmetric(
                            horizontal: 60,
                            vertical: 10,
                          );
                        }),
                        backgroundColor: WidgetStateProperty.resolveWith((
                          state,
                        ) {
                          return Colors.blueAccent;
                        }),
                        foregroundColor: WidgetStateProperty.resolveWith((
                          state,
                        ) {
                          return Colors.white;
                        }),
                      ),
                      child: Text('Login', style: GoogleFonts.montserrat()),
                    );
              },
            ),
            SizedBox(height: 15),
            Consumer<LoginNotifier>(
              builder: (context, data, child) {
                return data.stateLogin == RequestState.loading
                    ? Container()
                    : data.isAuthenticated != null
                    ? Text(
                      data.isAuthenticated!
                          ? ''
                          : 'Credential anda tidak sesuai, mohon coba kembali!',
                      style: GoogleFonts.montserrat(
                        color: Colors.red,
                        fontSize: 17,
                      ),
                    )
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      return;
    }

    if (!mounted) {
      return;
    }

    if (authenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    }
  }
}
