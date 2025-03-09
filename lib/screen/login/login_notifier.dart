import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valbury_test/data/model/response/profile_model.dart';
import 'package:valbury_test/domain/usecase/remote/get_login.dart';
import 'package:valbury_test/helper/helper_enum.dart';
import 'package:valbury_test/screen/base/base_notifier.dart';
import 'package:valbury_test/screen/dashboard/dashboard_screen.dart';

class LoginNotifier extends BaseNotifier {
  final GetLogin _getLogin;

  LoginNotifier(this._getLogin);

  ProfileModel _profileModel = ProfileModel();
  bool? isAuthenticated;

  ProfileModel get profileModel => _profileModel;

  RequestState stateLogin = RequestState.empty;

  void resetData() {}

  Future<void> doLogin(
    BuildContext context,
    String email,
    String password,
  ) async {
    stateLogin = RequestState.loading;
    notifyListeners();

    final result = await _getLogin.execute(email, password);

    result.fold(
      (failure) {
        setMessage(failure.message);
        stateLogin = RequestState.error;
        notifyListeners();
      },
      (data) async {
        _profileModel = data;

        if (_profileModel.email != null &&
            _profileModel.email!.isNotEmpty &&
            _profileModel.imagePath != null &&
            _profileModel.imagePath!.isNotEmpty) {
          isAuthenticated = true;

          saveDataLogin(context);
        } else {
          isAuthenticated = false;
        }

        Future.delayed(const Duration(milliseconds: 2000), () {
          stateLogin = RequestState.loaded;
          notifyListeners();
        });
      },
    );
  }

  Future<void> saveDataLogin(BuildContext context) async {
    await SharedPreferences.getInstance().then((data) async {
      await data.setString('email', _profileModel.email!);
      await data.setString('imagePath', _profileModel.imagePath!);
      await data.setInt('userId', _profileModel.userId!);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    });
  }
}
