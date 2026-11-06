import 'package:flutter/material.dart';
import 'package:my_multi_screen_project/constant/app_colors.dart';
import 'package:my_multi_screen_project/view/new_todo.dart';


class LoginScreenUi extends StatefulWidget {
  const LoginScreenUi({super.key});

  @override
  State<LoginScreenUi> createState() => _LoginScreenUiState();
}

class _LoginScreenUiState extends State<LoginScreenUi> {
  bool isProtected = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    bool isKeyboardOpen = keyboardHeight > 0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: isKeyboardOpen
            ? const BouncingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.only(top: isKeyboardOpen ? 20.0 : sh * 0.16),
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topRight,
              colors: [AppColors.appbarColor, AppColors.bgColor],
              radius: 0.5,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.task_alt_rounded,
                    color: AppColors.taskCardBorderColor,
                    size: sh * 0.13,
                  ),
                  SizedBox(width: sw * 0.01),
                  const Text(
                    "DSTP-TODO",
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: sh * 0.02),
              const Text(
                "Welcome Back",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: AppColors.primaryText,
                  fontSize: 30,
                ),
              ),

              const Text(
                "Sign in to continue your journey",
                style: TextStyle(color: Colors.white70),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: sh * 0.06,
                  left: sw * 0.07,
                  right: sw * 0.07,
                ),
                decoration: BoxDecoration(
                  boxShadow: emailFocus.hasFocus
                      ? [
                          const BoxShadow(
                            color: AppColors.appbarColor,
                            blurRadius: 6,
                            spreadRadius: 0.4,
                          ),
                        ]
                      : null,
                ),
                child: TextField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  focusNode: emailFocus,
                  onTap: () {
                    setState(() {});
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(passFocus);
                  },
                  keyboardType: TextInputType.emailAddress,
                  enableSuggestions: true,
                  style: const TextStyle(color: AppColors.secondaryText),
                  decoration: InputDecoration(
                    fillColor: AppColors.inputFieldBgColor,
                    filled: true,
                    labelText: 'Email Address',
                    hintText: "muneebsheikh@gmail.com",
                    hintStyle: const TextStyle(color: AppColors.secondaryText),
                    prefixIcon: const Icon(Icons.email_outlined),
                    prefixIconColor: Colors.blue,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: AppColors.taskCardBorderColor,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: AppColors.taskCardBorderColor,
                        width: 2.0,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: sh * 0.02,
                  left: sw * 0.07,
                  right: sw * 0.07,
                ),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.appbarColor,
                      blurRadius: 6,
                      spreadRadius: 0.4,
                    ),
                  ],
                ),
                child: TextField(
                  obscureText: isProtected,
                  focusNode: passFocus,
                  autofillHints: const [AutofillHints.password],
                  style: const TextStyle(color: AppColors.secondaryText),
                  decoration: InputDecoration(
                    fillColor: AppColors.inputFieldBgColor,
                    filled: true,
                    hintText: "Password",
                    hintStyle: const TextStyle(color: AppColors.secondaryText),
                    prefixIcon: const Icon(Icons.lock_outline),
                    prefixIconColor: Colors.blue,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: AppColors.taskCardBorderColor,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: AppColors.taskCardBorderColor,
                        width: 2.0,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        isProtected = !isProtected;
                        setState(() {});
                      },
                      icon: isProtected
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.visibility_outlined,
                              color: Colors.green,
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: sh * 0.02),
              Padding(
                padding: EdgeInsets.only(right: sw * 0.02, left: sw * 0.02),
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    child: const Text("Forgot Password"),
                    onPressed: () {},
                  ),
                ),
              ),
              SizedBox(height: sh * 0.05),
              Container(
                padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
                width: double.infinity,
                height: sh * 0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.appbarColor,
                  ),
                  onPressed: () async {
                    isLoading = true;
                    setState(() {});
                    await Future.delayed(Duration(seconds: 3));

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyNewScreen(),
                      ),
                    );
                    isLoading = false;
                    setState(() {});
                  },

                  child: isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: AppColors.primaryText,
                                strokeWidth: 2,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              "Signing...",
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        )
                      : const Text(
                          "LOGIN",
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              SizedBox(height: sh * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: AppColors.primaryText),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: AppColors.fabColor),
                    ),
                  ),
                ],
              ),
              SizedBox(height: sh * 0.2),
            ],
          ),
        ),
      ),
    );
  }
}
