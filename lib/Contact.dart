import 'package:flutter/material.dart';
import 'package:random_name_generator/random_name_generator.dart';

class Contact {
  Contact({
    required this.fullName,
    required this.id,
  });

  String fullName;
  int id;
}

class AddContactButton extends StatelessWidget {
  AddContactButton({Key? key, required this.onAddContact}) : super(key: key);

  VoidCallback onAddContact;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton.icon(
        onPressed: onAddContact,
        icon: Icon(Icons.add, size: 24),
        label: Text('Add Contact'),
      ),
    );
  }
}

class ContactItem extends StatefulWidget {
  const ContactItem({
    super.key,
    required this.contact,
    required this.onRemoveContact,
    required this.animationController,
  });

  final Contact contact;
  final Function(Contact contact) onRemoveContact;
  final AnimationController animationController;

  @override
  _ContactItemState createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();

    opacityAnimation = TweenSequence([
        TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.1), weight: 1.0),
        TweenSequenceItem(tween: Tween<double>(begin: 0.1, end: 1.0), weight: 1.0),
    ]).animate(widget.animationController);    
    
    widget.animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: opacityAnimation.value,
        duration: Duration(milliseconds: 1000),
        child:  Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                color: Colors.white30,
                ),
            ),
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Text(
                            widget.contact.fullName,
                        ),
                    ),
                    SizedBox(
                        width: 8,
                    ),
                    IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => widget.onRemoveContact(widget.contact),
                    ),
                ],
            ),
        ),
    );
  }
}

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  int _nextId = 0;
  List<Contact> _contacts = [
    Contact(
      fullName: "Kintu Musoke",
      id: 0,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  void _onAddContact() {
    setState(() {
        _nextId++;
        var randomNames = RandomNames(Zone.uganda);
        _contacts = [
            ..._contacts,
            Contact(
                fullName: randomNames.fullName(),
                id: _nextId,
            ),
        ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AddContactButton(
            onAddContact: _onAddContact,
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  final contact = _contacts[index];
                  return ContactItem(
                    contact: contact,
                    onRemoveContact: (contact) {
                      setState(() {
                        _contacts.removeWhere(
                            (existingContact) =>
                                existingContact.id == contact.id);
                        _controller.reverse();
                      });
                    },
                    animationController: _controller,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
