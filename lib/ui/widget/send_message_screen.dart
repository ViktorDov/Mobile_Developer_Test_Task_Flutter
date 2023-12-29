import 'package:flutter/material.dart';
import 'package:flutter_test_message/ui/view_model/send_message_screen_model.dart';
import 'package:provider/provider.dart';

class ContactUsScreenWidget extends StatelessWidget {
  const ContactUsScreenWidget({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => ContactUsWidgetModel(),
      child: const ContactUsScreenWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact us'),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 20,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NameTextFieldWidget(),
                EmailTextFieldWidget(),
                MessageTextFieldWidget(),
                ResponseMessageWidget(),
                ButtonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NameTextFieldWidget extends StatelessWidget {
  const NameTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ContactUsWidgetModel>();
    return Row(
      children: [
        const IconWidget(),
        const SizedBox(width: 32),
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Name',
              labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent)),
            ),
            onChanged: (value) => model.changeName(value),
          ),
        ),
      ],
    );
  }
}

class EmailTextFieldWidget extends StatelessWidget {
  const EmailTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ContactUsWidgetModel>();

    return Row(
      children: [
        const IconWidget(),
        const SizedBox(width: 32),
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent)),
            ),
            onChanged: (value) => model.changeEmail(value),
          ),
        ),
      ],
    );
  }
}

class MessageTextFieldWidget extends StatelessWidget {
  const MessageTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ContactUsWidgetModel>();
    return Row(
      children: [
        const IconWidget(),
        const SizedBox(width: 32),
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Message',
              labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent)),
            ),
            onChanged: (value) => model.changeMessage(value),
          ),
        ),
      ],
    );
  }
}

class IconWidget extends StatelessWidget {
  const IconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
          color: Colors.orangeAccent.withOpacity(0.1), shape: BoxShape.circle),
      child: Icon(
        Icons.lock_open_sharp,
        size: 22,
        color: Colors.orangeAccent.withOpacity(0.7),
      ),
    );
  }
}

class ResponseMessageWidget extends StatelessWidget {
  const ResponseMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final message = context
        .select((ContactUsWidgetModel vm) => vm.state.responseTitleMessage);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        message,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ContactUsWidgetModel>();
    final buttonState =
        context.select((ContactUsWidgetModel vm) => vm.state.buttonState);

    final onPress = buttonState == ViewModelButtonState.enable
        ? model.onButtonSendMessage
        : null;
    final elevatedButtonChild = buttonState == ViewModelButtonState.inProces
        ? const Text('Please wait')
        : const Text('Send');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 14),
      child: SizedBox(
        width: double.infinity,
        height: 44,
        child: ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(152, 109, 142, 0.9),
              foregroundColor: Colors.white),
          child: elevatedButtonChild,
        ),
      ),
    );
  }
}
