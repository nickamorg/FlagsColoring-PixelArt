import 'package:flutter/material.dart';
import 'package:flagscoloring_pixelart/AppTheme.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ContactScreen extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
        return Contact();
	}
}

class ContactState extends State<Contact> {
	final TextEditingController ctrlField = TextEditingController();
    final formKey = GlobalKey<FormState>();

	@override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                            AppTheme.MAIN_COLOR,
                            Color(0xFF085F5F)
                        ]
                    ),
                    image: DecorationImage(
                        colorFilter: ColorFilter.linearToSrgbGamma(),
                        image: AssetImage('assets/world.png'),
                        fit: BoxFit.cover
                    )
                ),
                child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            Stack(
                                children: [
                                    Card(
                                        color: AppTheme.CARD_EXPAND,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: MediaQuery.of(context).size.height - 60,
                                            width: (MediaQuery.of(context).size.width - 60),
                                            child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                    Container(
                                                        padding: EdgeInsets.all(10),
                                                        height: MediaQuery.of(context).size.height - 60,
                                                        width: (MediaQuery.of(context).size.width - 60) / 2
                                                    ),
                                                    Expanded(
                                                        child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                                formWidget(),
                                                                Card(
                                                                    color: Colors.white,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(15)
                                                                    ),
                                                                    child: TextButton(
                                                                        style: TextButton.styleFrom(
                                                                            padding: EdgeInsets.all(5)
                                                                        ),
                                                                        onPressed: () => {
                                                                            if (formKey.currentState!.validate()) {
                                                                                sendEmail()
                                                                            }
                                                                        },
                                                                        child: Container(
                                                                            padding: EdgeInsets.all(10),
                                                                            height: 40,
                                                                            width: MediaQuery.of(context).size.height / 1.6,
                                                                            color: Colors.white,
                                                                            child: Center(
                                                                                child: Text(
                                                                                    'Send Email',
                                                                                    style: TextStyle(
                                                                                        color: Colors.black,
                                                                                        fontStyle: FontStyle.italic
                                                                                    )
                                                                                )
                                                                            )
                                                                        )
                                                                    )
                                                                )
                                                            ]
                                                        )
                                                    )
                                                ]
                                            )
                                        )
                                    ),
                                    Container(
                                        height: MediaQuery.of(context).size.height - 45,
                                        color: Colors.transparent,
                                        alignment: Alignment.topCenter,
                                        child: Card(
                                            color: AppTheme.SECONDARY_COLOR,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20)
                                            ),
                                            child: Container(
                                                padding: EdgeInsets.all(20),
                                                height: MediaQuery.of(context).size.height - 60,
                                                width: (MediaQuery.of(context).size.width - 60) / 2,
                                                child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                        Text(
                                                            'Do you have anything to share with us?',
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold
                                                            )
                                                        ),
                                                        Text(
                                                            'Tell us about it!',
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold
                                                            )
                                                        ),
                                                        Text(
                                                            'We are always open to suggestions in order to provide the best experience.',
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold
                                                            )
                                                        )
                                                    ]
                                                )
                                            )
                                        )
                                    )
                                ]
                            )
                        ]
                    )
                )
            )
        );
    }

    Form formWidget() {
        bool validateProposals() {
            return ctrlField.text.isEmpty;
        }
        
        return Form(
            key: formKey,
            child: TextFormField(
                minLines: 3,
                maxLines: 10,
                controller: ctrlField,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: 'Type something...',
                    hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontStyle: FontStyle.italic
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                ),
                validator: (value) {
                    if (validateProposals()) {
                        return 'Field is required';
                    }
                    return null;
                }
            )
        );
    }

    sendEmail() async {
        final Email email = Email(
            body: '${ctrlField.text}\n',
            subject: 'World Countries Quiz: Proposals',
            recipients: ['zirconworks@gmail.com'],
            isHTML: false,
        );

        await FlutterEmailSender.send(email);
    }
}

class Contact extends StatefulWidget {

	@override
	State createState() => ContactState();
}