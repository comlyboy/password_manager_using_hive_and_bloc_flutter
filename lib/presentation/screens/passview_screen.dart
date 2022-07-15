import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:password_manager/data/models/pass_model.dart';
import 'package:password_manager/logic/bloc/pass/pass_bloc.dart';

class PassViewScreen extends StatefulWidget {
  final SuperPassModel pass;
  const PassViewScreen({Key? key, required this.pass}) : super(key: key);

  @override
  State<PassViewScreen> createState() => _PassViewScreenState();
}

class _PassViewScreenState extends State<PassViewScreen> {
  final _nameTEC = TextEditingController();
  final _userNameTEC = TextEditingController();
  final _passwordTEC = TextEditingController();
  final _notesTEC = TextEditingController();
  Uuid uuid = const Uuid();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pass.title),
      ),
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Title",
                ),
                validator: (_) =>
                    _nameTEC.text.isEmpty ? "Title is required" : null,
                controller: _nameTEC,
              ),
              const SizedBox(height: 15),

              //
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Username",
                ),
                controller: _userNameTEC,
              ),
              const SizedBox(height: 15),

              //
              TextFormField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                ),
                validator: (_) =>
                    _passwordTEC.text.isEmpty ? "Password is required" : null,
                controller: _passwordTEC,
              ),
              const SizedBox(height: 15),

              //
              TextFormField(
                enableSuggestions: false,
                autocorrect: false,
                maxLines: 10,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  labelText: "Notes",
                ),
                controller: _notesTEC,
              ),
              const SizedBox(height: 20),

              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel")),
                  ElevatedButton(
                    onPressed: () {
                      final isValidForm = _formKey.currentState!.validate();

                      if (isValidForm) {
                        context.read<PassBloc>().add(PassAddEvent(
                              pass: SuperPassModel(
                                id: uuid.v4(),
                                title: _nameTEC.text,
                                username: _userNameTEC.text,
                                password: _passwordTEC.text,
                                notes: _notesTEC.text,
                              ),
                            ));
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}