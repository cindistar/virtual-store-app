import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/validators.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Create Account',
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  padding: EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Full Name'),
                      enabled: !userManager.loading,
                      validator: (name) {
                        if (name.isEmpty)
                          return 'Required Field';
                        else if (name.trim().split(' ').length <= 1)
                          return 'Please fill in your name';
                        return null;
                      },
                      onSaved: (name) => user.name = name,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      enabled: !userManager.loading,
                      validator: (email) {
                        if (email.isEmpty)
                          return 'Required Field';
                        else if (!emailValid(email)) return 'Invalid Email';
                        return null;
                      },
                      onSaved: (email) => user.email = email,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Password'),
                      obscureText: true,
                      enabled: !userManager.loading,
                      validator: (pass) {
                        if (pass.isEmpty)
                          return 'Required Field';
                        else if (pass.length < 6) return 'Password is too short';
                        return null;
                      },
                      onSaved: (pass) => user.password = pass,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Repeat your password'),
                      obscureText: true,
                      enabled: !userManager.loading,
                      validator: (pass) {
                        if (pass.isEmpty)
                          return 'Required Field';
                        else if (pass.length < 6) return 'Password is too short';
                        return null;
                      },
                      onSaved: (pass) => user.confirmPassword = pass,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: userManager.loading
                          ? null
                          : () {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();
                                if (user.password != user.confirmPassword) {
                                  // ignore: deprecated_member_use
                                  scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text('Passwords don\'t match!'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }
                                userManager.signUp(
                                    user: user,
                                    onSuccess: () {
                                      Navigator.of(context).pop();
                                    },
                                    onFail: (e) {
                                      // ignore: deprecated_member_use
                                      scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Fail to register: $e'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    });
                              }
                            },
                      child: userManager.loading
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(Colors.white),
                            )
                          : Text(
                              'Create Account',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                      style: ButtonStyle(
                        //primary: Theme.of(context).primaryColor,
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return null;
                            else if (states.contains(MaterialState.disabled))
                              return Theme.of(context)
                                  .primaryColor
                                  .withAlpha(100);
                            return Theme.of(context).primaryColor;
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
