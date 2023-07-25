import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webflutter/screen/reset_password.dart';
import '../PushNotify/notifyservice.dart';
import '../config/pallete.dart';
import '../api/apifetch.dart';
import 'dashboard_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSignupScreen = true;
  bool isMale = true;
  bool isRememberMe = false;
  bool visiblePassword_1= false,visiblePassword_2= false,visiblePassword_3= false;
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
                SizedBox(height: 30),
                Image.asset('assets/images/shopperr 2.png', height: 130,),
                SizedBox(height: 20),
                Text(
                  'Masuk',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Hai, masukkan detail Anda untuk masuk',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'ke akun Anda',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
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
                      buildSigninSection(),
                      SizedBox(height: 30),
                      Container(
                        height: 50,
                        width: 350,
                        decoration: BoxDecoration(
                          color: Palette.activeColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            if(usernameLogin_editTextController.text.isNotEmpty && passwordLogin_editTextController.text.isNotEmpty){
                              var body = {
                                'username': usernameLogin_editTextController.text,
                                'password': passwordLogin_editTextController.text,
                              };
                              var result = await api.LoginData(body, passwordLogin_editTextController.text, context);
                              if(result == 'success'){
                                if(isRememberMe){
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setString('user_remember', usernameLogin_editTextController.text);
                                  prefs.setString('password_remember', passwordLogin_editTextController.text);
                                }
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Username atau Password salah')));
                              }
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Username atau Password tidak boleh kosong')));
                            }
                          },
                          child: Text(
                            'Masuk',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('Atau',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black54,),),
                      SizedBox(height: 10),
                      google(),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum punya akun?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 5),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()),);
                      },
                      child: Text(
                        'Daftar',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Palette.activeColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
  @override
  void initState() {
    super.initState();

    init();
  }


  slideTop(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isSignupScreen = false;
            });
          },
          child: Container(
            width: 90,
            child: Text(
              "Masuk",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: !isSignupScreen
                      ? Colors.white
                      : Palette.activeColor),
            ),
            padding: EdgeInsets.all(9),
            decoration: BoxDecoration(color: !isSignupScreen?Palette.activeColor: Colors.white, borderRadius: BorderRadius.all(Radius.circular(50))),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isSignupScreen = true;
            });
          },
          child: Column(
            children: [
              Container(
                width: 90,
                child: Text(
                  "Daftar",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isSignupScreen
                          ? Colors.white
                          : Palette.activeColor),
                ),
                padding: EdgeInsets.all(9),
                decoration: BoxDecoration(color: isSignupScreen?Palette.activeColor: Colors.white, borderRadius: BorderRadius.all(Radius.circular(50))),
              ),
            ],
          ),
        )
      ],
    );
  }
  buildBottomHalfContainer() {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      top: isSignupScreen ? MediaQuery.of(context).size.height*76/100 : MediaQuery.of(context).size.height*60.8/100,
      right: 0,
      left: 0,
      child: Center(
        child: InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            var uuid = Random().nextInt(10000);
            Map<String,dynamic> bodyRegist = {'uuid':uuid.toString(),'username':usernameRegist_editTextController.text,'name':nameRegist_editTextController.text, 'email':emailRegist_editTextController.text, 'password':passwordRegist_editTextController.text, 'confirm_password':confirmPassRegist_editTextController.text, 'gender':isMale?'L':'P','birth_of_date':datePickerController.text,'image':''};
            Map<String,dynamic> body = {'email':usernameLogin_editTextController.text,'password':passwordLogin_editTextController.text};
            setState(() {
              print(uuid);
              if(isSignupScreen){
                if(usernameRegist_editTextController.text==''||usernameRegist_editTextController.text==null) {
                  toast(text: 'Masukkan Username Anda');
                }else
                if(nameRegist_editTextController.text==''||nameRegist_editTextController.text==null) {
                  toast(text: 'Masukkan Nama Lengkap Anda');
                }else
                if(emailRegist_editTextController.text==''||emailRegist_editTextController.text==null) {
                  toast(text: 'Masukkan Email Anda');
                }else
                if(!emailRegist_editTextController.text.contains('@')) {
                  toast(text: 'Masukkan Email Dengan Benar');
                }else
                if(datePickerController.text==''||datePickerController.text==null) {
                  toast(text: 'Masukkan Tanggal Lahir Anda');
                }else
                if(passwordRegist_editTextController.text==''||passwordRegist_editTextController.text==null) {
                  toast(text: 'Masukkan Kata Sandi Anda');
                }else
                if(confirmPassRegist_editTextController.text==''||confirmPassRegist_editTextController.text==null) {
                  toast(text: 'Masukkan Konfirmasi Kata Sandi Anda');
                }else
                if(passwordRegist_editTextController.text.length<5) {
                  print(passwordRegist_editTextController.text.length);
                  toast(text: 'Password Harus Lebih Dari 5 Karakter');
                }else
                if(passwordRegist_editTextController.text!=confirmPassRegist_editTextController.text) {
                  toast(text: 'Masukkan Kata Sandi Tidak Sama');
                }
                else{
                  print(bodyRegist.toString());
                  api.RegistData(bodyRegist).then((value) {
                    if(!value.contains('has already been taken')) {
                      usernameRegist_editTextController.text = '';
                      nameRegist_editTextController.text = '';
                      emailRegist_editTextController.text = '';
                      datePickerController.text = '';
                      passwordRegist_editTextController.text = '';
                      confirmPassRegist_editTextController.text = '';
                      print("response"+api.RegistData(bodyRegist).toString());
                      setState(() {
                        isSignupScreen=false;
                      });
                    }else{
                      toast(text: 'Data Anda Sudah Dipakai Pengguna Lain');
                    }
                  });

                }
              }
              else{
                if(usernameLogin_editTextController.text==''||usernameLogin_editTextController.text==null)toast(text: 'Masukkan Username Anda');
                if(passwordLogin_editTextController.text==''||passwordLogin_editTextController.text==null)toast(text: 'Masukkan Nama Lengkap Anda');
                api.LoginData(body, passwordLogin_editTextController.text,context).then((value) => print(value));
                if(isRememberMe) {
                  prefs.setString('user_remember', usernameLogin_editTextController.text);
                  prefs.setString(
                      'password_remember', passwordLogin_editTextController.text);
                }else{
                  prefs.remove('user_remember');
                  prefs.remove('password_remember');
                }
                NotificationService().showNotification(body: 'Selamat Datang di Shopper !',);
              }
            });
          },
          child: Container(
              height: 90,
              width: 90,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        color: Colors.white,
                        offset: Offset(0, 5)
                    )
                  ]),
              child:  Container(
                decoration: BoxDecoration(
                    color: Palette.activeColor,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.3),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ]),
                child: isSignupScreen?Icon(
                    Icons.check_rounded,
                    color: Colors.white):Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              )
          ),
        ),
      ),
    );
  }
  buildSigninSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField("Email atau username", false, true, controller: usernameLogin_editTextController),
          buildTextField("Kata Sandi", true, false, index: 2, controller: passwordLogin_editTextController),
          rememberMe(),
          // button('Masuk', true),
          SizedBox(height: 10,),
        ],
      ),
    );
  }

  toast({text}){
    return Fluttertoast.showToast(
        backgroundColor: Palette.activeColor,
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  rememberMe(){
    return Container(
      margin: EdgeInsets.only(left: 15, top: 10, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                isRememberMe = !isRememberMe;
              });
              if(isRememberMe){
                prefs.setString('user_remember', usernameLogin_editTextController.text);
                prefs.setString('password_remember', passwordLogin_editTextController.text);
              }else{
                prefs.remove('user_remember');
                prefs.remove('password_remember');
              }

            },
            child: Row(
              children: [
                Container(
                  width: 14,
                  height: 14,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      color: isRememberMe
                          ? Palette.activeColor
                          : Colors.transparent,
                      border: Border.all(
                          width: 1,
                          color: isRememberMe
                              ? Colors.transparent
                              : Palette.activeColor),
                      borderRadius: BorderRadius.circular(15)),
                  child: Icon(
                    size: 8,
                    Icons.check_rounded,
                    color: Colors.white,
                  ),
                ),
                Text(
                    "Ingatkan Saya",
                    style: TextStyle(color: Palette.activeColor, fontSize: 11,)
                ),
              ],
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordScreen(),));
            },
            child: Text(
                "Lupa Kata Sandi?",
                style: TextStyle(color: Palette.activeColor, fontSize: 11,)
            ),
          )
        ],
      ),
    );
  }
  buildSignupSection() {
    return Container(
      child: Column(
        children: [
          buildTextField("Nama Pengguna",false, false, controller: usernameRegist_editTextController),
          buildTextField("Nama Lengkap",false, false, controller: nameRegist_editTextController),
          buildTextField("Email", false, true, controller: emailRegist_editTextController),
          buildTextField("Tanggal Lahir", false, true, index: 3, controller: datePickerController),
          buildTextField("Kata Sandi", true, false, index: 0, controller: passwordRegist_editTextController),
          buildTextField("Konfirmasi Kata Sandi", true, false, index: 1, controller: confirmPassRegist_editTextController),
          genderRadioButton(),
          textCondition()
          // button('Daftar', false)
        ],
      ),
    );
  }
  textCondition(){
    return Container(
      width: 200,
      margin: EdgeInsets.only(top: 10),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: "Dengan menekan tanda cek, maka kamu sudah menyetujui ",
            style: TextStyle(color: Palette.textColor2, fontSize: 10),
            children: [
              TextSpan(
                //recognizer: ,
                text: "Ketentuan & Kondisi",
                style: TextStyle(color: Palette.activeColor, fontSize: 10 ,fontWeight: FontWeight.bold),
              ),
            ]),
      ),
    );
  }
  genderRadioButton(){
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 18),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isMale = true;
              });
            },
            child: Row(
              children: [
                Container(
                  width: 25,
                  height: 25,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      color: isMale
                          ? Palette.activeColor
                          : Colors.transparent,
                      border: Border.all(
                          width: 1,
                          color: isMale
                              ? Colors.transparent
                              : Palette.activeColor),
                      borderRadius: BorderRadius.circular(15)),
                  child: Icon(
                    size: 20,
                    Icons.male,
                    color: isMale ? Colors.white : Palette.activeColor,
                  ),
                ),
                Text(
                    "Laki - laki",
                    style: TextStyle(color: Palette.activeColor, fontSize: 13,)
                )
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isMale = false;
              });
            },
            child: Row(
              children: [
                Container(
                  width: 25,
                  height: 25,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      color: isMale
                          ? Colors.transparent
                          : Palette.activeColor,
                      border: Border.all(
                          width: 1,
                          color: isMale
                              ? Palette.activeColor
                              : Colors.transparent),
                      borderRadius: BorderRadius.circular(15)),
                  child: Icon(
                    size: 20,
                    Icons.female,
                    color: isMale ? Palette.activeColor : Colors.white,
                  ),
                ),
                Text(
                  "Perempuan",
                  style: TextStyle(color: Palette.activeColor, fontSize: 12),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  buildTextField(String hintText, bool isPassword, bool isEmail,{index, controller}) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 5),
      child: TextField(
        controller: controller!=null?controller:null,
        style: TextStyle(fontSize: 13),
        onTap: () {
          index==3?
          onTapFunction(context: context):null;
        },
        obscureText: isPassword ? index==0? visiblePassword_1 ? false : true :index==1?visiblePassword_2?false : true:index==2? visiblePassword_3?false : true: false:false,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
            labelText: hintText,
            suffixIcon:  isPassword ? IconButton(
                onPressed: (){
                  setState(() {
                    index==0? visiblePassword_1 ? visiblePassword_1=false : visiblePassword_1=true :index==1?visiblePassword_2?visiblePassword_2=false : visiblePassword_2=true:index==2? visiblePassword_3?visiblePassword_3=false : visiblePassword_3=true: null;
                  });
                },
                icon: index==0?visiblePassword_1 ? Icon(Icons.remove_red_eye) : Icon(Icons.remove_red_eye_outlined):
                index==1?visiblePassword_2?Icon(Icons.remove_red_eye) : Icon(Icons.remove_red_eye_outlined):
                index==2?visiblePassword_3 ? Icon(Icons.remove_red_eye) : Icon(Icons.remove_red_eye_outlined):Icon(null)):null),
      ),
    );
  }
  google (){
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      top: isSignupScreen?MediaQuery.of(context).size.height*88/100:MediaQuery.of(context).size.height*75/100,
      right: 0,
      left: 0,
      child: Column(
        children: [
          //Text(isSignupScreen ? "Atau" : "Atau", style: TextStyle(color: Colors.black54)),
          Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              decoration: BoxDecoration(
                  color: Palette.backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              width: double.infinity,
              child: Container(
                margin: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset('assets/images/google.png',
                                height: 20, width: 20),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Google',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
  openingText(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              text: "Selamat Datang",
              style: TextStyle(
                  fontSize: 25,
                  letterSpacing: 2,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
              children: [
                TextSpan(
                  text: isSignupScreen ? " di Shopper," : " Kembali, di Shopper",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                )
              ]),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          isSignupScreen
              ? "Daftar untuk melanjutkan"
              : "Masuk untuk melanjutkan",
          style: TextStyle(
            letterSpacing: 1,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  onTapFunction({required BuildContext context}) async {
    int firstdate = DateTime.now().year.toInt()-85;
    int lastdate = DateTime.now().year.toInt()-10;
    int commondate = DateTime.now().year.toInt()-17;
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime(lastdate),
      firstDate: DateTime(firstdate),
      initialDate: DateTime(commondate),
    );
    if (pickedDate == null) return;
    datePickerController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  }
}

