import 'package:_2geda/pages/ticketPages/sellTicket/presentation/comps/ticket_form.dart';
import 'package:flutter/material.dart';

class CreateTicketStep extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController quantityController;
  final TextEditingController priceController;
  final TextEditingController freeTicketController;
  final TextEditingController paidTicketController;

  const CreateTicketStep({
    Key? key, // Add a key parameter to the constructor
    required this.formKey,
    required this.nameController,
    required this.quantityController,
    required this.priceController,
    required this.freeTicketController,
    required this.paidTicketController,
  }) : super(key: key); // Use the key parameter to initialize the super class

  @override
  State<CreateTicketStep> createState() => _CreateTicketStepState();
}

class _CreateTicketStepState extends State<CreateTicketStep> {
  final List<bool> _selection = [true, false];

  final List<TicketFormData> _ticketForms = [TicketFormData()];

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Render ticket forms dynamically based on the length of _ticketForms
          for (int i = 0; i < _ticketForms.length; i++)
            Column(
              children: [
                TicketForm(
                  ticketFormData: _ticketForms[i],
                  onDelete: () {
                    setState(() {
                      if (_ticketForms.length > 1) {
                        _ticketForms.removeAt(i);
                      }
                    });
                  },
                  getSelectedController: _getSelectedController,
                  isSelected: _selection[0],
                  onSelectionChanged: (bool isSelected1, bool isSelected2) {
                    setState(() {
                      _selection[0] = isSelected1;
                      _selection[1] = isSelected2;
                    });
                  },
                  onAdd: () {
                    setState(() {
                      _ticketForms.add(TicketFormData());
                    });
                  },
                ),
                
              ],
            ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  TextEditingController _getSelectedController() {
    return _selection[0]
        ? widget.freeTicketController
        : widget.paidTicketController;
  }
}

class TicketFormData {
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController freeTicketController = TextEditingController();
  TextEditingController paidTicketController = TextEditingController();
}
