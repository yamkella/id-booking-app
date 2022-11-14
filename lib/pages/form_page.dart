import 'package:flutter/material.dart';


class SecondPage extends StatelessWidget {
  const SecondPage({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ID booking APP ',
      theme: ThemeData(brightness: Brightness.dark),
      home: const FormPage(title: 'ID booking APP'),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SignUpForm()),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState>();

  String _firstName = '';
  String _lastName = '';
  String _location = '';
  String _bookingDay = '';
  int _age = -1;
  String _maritalStatus = '';
  int _selectedGender = 0;
  bool _termsChecked = true;

  List<DropdownMenuItem<int>> genderList = [];

  void loadGenderList() {
    genderList = [];
    genderList.add(const DropdownMenuItem(
      child: Text('Male'),
      value: 0,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('Female'),
      value: 1,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('Others'),
      value: 2,
    ));
  }

  @override
  Widget build(BuildContext context) {
    loadGenderList();
    // Build a Form widget using the _formKey we created above
    return Form(
        key: _formKey,
        child: ListView(
          children: getFormWidget(),
        ));
  }


  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(TextFormField(
      decoration:
      const InputDecoration(labelText: 'Enter firstName', hintText: 'firstName'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a firstName';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _firstName = value.toString();
        });
      },
    ));



    formWidget.add(TextFormField(
      decoration:
      const InputDecoration(labelText: 'Enter lastName', hintText: 'lastName'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a lastName';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _lastName = value.toString();
        });
      },
    ));
    formWidget.add(TextFormField(
      decoration:
      const InputDecoration(labelText: 'Enter location', hintText: 'location'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a location';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _location= value.toString();
        });
      },
    ));

    formWidget.add(TextFormField(
      decoration:
      const InputDecoration(hintText: 'Age', labelText: 'Enter Age'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter age';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _age = int.parse(value.toString());
        });
      },
    ));


    formWidget.add(DropdownButton(
      hint: const Text('Select Gender'),
      items: genderList,
      value: _selectedGender,
      onChanged: (value) {
        setState(() {
          _selectedGender = int.parse(value.toString());
        });
      },
      isExpanded: true,
    ));

    formWidget.add(Column(
      children: <Widget>[
        RadioListTile<String>(
          title: const Text('Single'),
          value: 'single',
          groupValue: _maritalStatus,
          onChanged: (value) {
            setState(() {
              _maritalStatus = value.toString();
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Married'),
          value: 'married',
          groupValue: _maritalStatus,
          onChanged: (value) {
            setState(() {
              _maritalStatus = value.toString();
            });
          },
        ),
      ],
    ));


      formWidget.add(TextFormField(
        decoration:
        const InputDecoration(labelText: 'Enter the day you want to book', hintText: 'BookingDay'),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter BookingDay';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          setState(() {
            _bookingDay = value.toString();
          });
        },
      ));

    formWidget.add(CheckboxListTile(
      value: _termsChecked,
      onChanged: (value) {
        setState(() {
          _termsChecked = value.toString().toLowerCase() == 'true';
        });
      },
      subtitle: !_termsChecked
          ? const Text(
        'Required',
        style: TextStyle(color: Colors.red, fontSize: 12.0),
      )
          : null,
      title: const Text(
        'I agree to the terms and condition',
      ),
      controlAffinity: ListTileControlAffinity.leading,
    ));

    void onPressedSubmit() {
      if (_formKey.currentState!.validate() && _termsChecked) {
        _formKey.currentState?.save();

        print("firstName " + _firstName);
        print("lastName " + _lastName);
        print("location " + _location);
        print("Age " + _age.toString());
        switch (_selectedGender) {
          case 0:
            print("Gender Male");
            break;
          case 1:
            print("Gender Female");
            break;
          case 3:
            print("Gender Others");
            break;
        }
        print("Marital Status " + _maritalStatus);
        print("Which day you are booking? " + _bookingDay);
        print("Termschecked " + _termsChecked.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Form Submitted')));
      }
    }

    formWidget.add(ElevatedButton(
        child: const Text('SUBMIT BOOKING'), onPressed: onPressedSubmit));

    return formWidget;
  }
}