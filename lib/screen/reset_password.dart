import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webflutter/screen/confirm_password.dart';
import '../config/pallete.dart';
import '../api/apifetch.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool isSignupScreen = true;
  bool isMale = true;
  bool isRememberMe = false;
  bool visiblePassword_1= false;
  TextEditingController datePickerController = TextEditingController();

  TextEditingController usernameLogin_editTextController = TextEditingController();
  TextEditingController passwordLogin_editTextController = TextEditingController();

  TextEditingController usernameRegist_editTextController = TextEditingController();
  TextEditingController passwordRegist_editTextController = TextEditingController();
  TextEditingController nameRegist_editTextController = TextEditingController();
  TextEditingController datebirthRegist_editTextController = TextEditingController();
  TextEditingController emailRegist_editTextController = TextEditingController();
  TextEditingController confirmPassRegist_editTextController = TextEditingController();

  APiFetch_Authentication api = APiFetch_Authentication();


  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.get('user_remember')!=null && prefs.get('password_remember')!=null){
      usernameLogin_editTextController.text = prefs.getString('user_remember').toString();
      passwordLogin_editTextController.text = prefs.getString('password_remember').toString();
      isRememberMe = true;
      isSignupScreen = false;
    }else{
      isRememberMe = false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                Image.asset('assets/images/shopperr 2.png', height: 130,),
                SizedBox(height: 40),
                Container(
                  height: 400,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Palette.activeColor.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
                      Text(
                        'Atur Ulang Kata',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Sandi',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Masukan Email Anda Untuk Membuat Kata',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Sandi Baru',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 50),
                      buildTextField("Email",false, controller: usernameLogin_editTextController),
                      // button('Masuk', true),
                      SizedBox(height: 10,),
                      //button masuk menggunakai uu id
                      SizedBox(height: 30),
                      // Container(
                      //   padding: EdgeInsets.only(
                      //     left: 70,
                      //     right: 70,
                      //     bottom: 10,
                      //     top: 10,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     color: Palette.activeColor,
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   child: Text(
                      //     'Kirim',
                      //     style: TextStyle(
                      //       color: Colors.white, // Warna teks tombol
                      //       fontSize: 16.0,
                      //     ),
                      //   ),
                      // ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmPasswordScreen(),));
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 70,
                            right: 70,
                            bottom: 10,
                            top: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Palette.activeColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Kirim',
                            style: TextStyle(
                              color: Colors.white, // Warna teks tombol
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ]),
        ),
      ),
    );
  }
  }
  Widget buildTextField(
      String hintText,
      bool isEmail,
      {TextEditingController? controller}
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(),
        ),
      ),
    );
}