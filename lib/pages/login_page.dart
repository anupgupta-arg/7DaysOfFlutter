import '../utils/routes.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _name = "";
  var changeButton = false;
  var changeIcon = false;
  final _formKey = GlobalKey<FormState>();

  void movetohome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(
        const Duration(milliseconds: 300),
      );
      await Navigator.pushNamed(context, MyRoutes.homeRoute);
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                "assets/images/login_image.png",
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Welcome $_name",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter User Name",
                        labelText: "User Name",
                      ),
                      onChanged: (value) {
                        setState(() {
                          _name = value;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "User Name Can't be empty";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        labelText: "Password",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password Cant be empty";
                        } else if (value.length < 6) {
                          return "Password length Shoud be Atlest 6";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(changeButton ? 25 : 8),
                child: InkWell(
                  onTap: () {
                    movetohome(context);
                  },
                  child: AnimatedContainer(
                    duration: Duration(
                      milliseconds: 300,
                    ),
                    height: 50,
                    width: changeButton ? 50 : 150,
                    alignment: Alignment.center,
                    child: changeButton
                        ? Icon(
                            Icons.done,
                            color: Colors.white,
                          )
                        : Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    decoration: BoxDecoration(
                        // shape: changeButton ? BoxShape.circle : BoxShape.rectangle,

                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
