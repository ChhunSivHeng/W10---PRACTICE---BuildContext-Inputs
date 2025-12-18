import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
  
}

class _ExpenseFormState extends State<ExpenseForm> {
 
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.food;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose(){
    super.dispose();

    _titleController.dispose();
    _amountController.dispose();
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(context: context, initialDate: _selectedDate, firstDate: DateTime(2000), lastDate: DateTime.now());
    if (pickedDate != null ){
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void onCreate() {
    //  1 Build an expense    
    // TODO YOUR CODE HERE
    final  title = _titleController.text;
    final amount = double.tryParse(_amountController.text);

    if(title.isEmpty || amount == null || amount <= 0){
      return;
    }
    
    final newExpense = Expense(title: title, amount: amount, date: _selectedDate, category: _selectedCategory);

    
    Navigator.pop(context, newExpense);
    
    

  }
  
  void onCancel() {
   
    // Close the modal
    Navigator.pop(context,);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController, 
            decoration: InputDecoration(label: Text("Title")),
            maxLength: 50,
          ),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(label: Text("Amount")),
          ),
          const SizedBox(height: 20,),
          DropdownButton<Category>(
            value: _selectedCategory,
            items: Category.values.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category.name),
              );
            }).toList(),
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                _selectedCategory = value;
              });
            },
          ),
          Row(
            children: [
              SizedBox(height: 50),
              Text("Date: ${_selectedDate.toString().split(' ')[0]}",),
              const Spacer(),
              IconButton(onPressed: _pickDate, icon: const Icon(Icons.calendar_month))
            ],         
          ),
           Row(
             children: [
               ElevatedButton(onPressed: onCancel, child: Text("Cancel")),
               SizedBox(width: 10,),
              ElevatedButton(onPressed: onCreate, child: Text("Create")),
             ],
           ),
        ],
      ),
    );
  }
}
