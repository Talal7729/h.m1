import 'package:flutter/material.dart';
import 'dart:convert';
import 'view_registration_data.dart';
import 'user_input_data.dart';


class LoginData extends StatefulWidget {
  

  const LoginData({super.key,});

  @override
  State<LoginData> createState() => _LoginDataState();
}

class _LoginDataState extends State<LoginData> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
 final TextEditingController dateController = TextEditingController();
 final TextEditingController timeController = TextEditingController();
DateTime selectedDate = DateTime.now();
  TimeOfDay? _selectedTime;
  final List<String> _gender = ['ذكر', 'انثى',];
  String? _selectedGender;
		
		
		final List<String> _country= ['اليمن',' السعودية',' مصر','سوريا ', ' الاردن',' لبنان', ];
  String? _selectedCountry;
  bool _isPrimary = false;
  bool _isActive = true;
  
  double _rating = 1;
  double _percentage = 50;
  RangeValues _priceRange = const RangeValues(10, 100);

  String _message = '';
  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _phoneNoController.dispose();
    _ageController.dispose();
    super.dispose();
  }
  
  

  Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker( 
    context: context, 
    initialDate: selectedDate, 
    firstDate: DateTime(2000),
    lastDate: DateTime(2100), );
    if (picked != null && picked != selectedDate) 
    setState(() {
      selectedDate = picked; 
    });
  dateController.text = ' ${'${selectedDate.year}/${selectedDate.month}/${selectedDate.day}'}';
}
  
  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );
    if (d != null) setState(() => _selectedDate = d);
  }
  
  
  Future<void> _selectTime() async {
    final t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (t != null) setState(() => _selectedTime = t);
  }
  
  void _submit(BuildContext context) {
if (!_formKey.currentState!.validate()) return;
  		
    try {
  final String fullName = _fullNameController.text;
  final String email = _emailController.text;
  final String password = _passwordController.text;
  final String phoneNo = _phoneNoController.text;
  final String age = _ageController.text;
  
  final String dateString = dateController.text;
  final String timeString = timeController.text;
  final String? gender = _selectedGender;
  final String? country = _selectedCountry;
  final bool notifications = _isPrimary;
  final bool agreePolicy = _isActive;
  
  final double ratingValue = _rating;
  final double percentageValue = _percentage;
  
  final String priceRangeString = 'من ${_priceRange.start.toStringAsFixed(0)} إلى ${_priceRange.end.toStringAsFixed(0)}';
  
  final UserInputData data = UserInputData(
    fullName: fullName,
    email: email,
    password: password,
    phoneNo: phoneNo,
    age: age,
    gender: gender,
    country: country,
    selectedDate: dateString,
    selectedTime: timeString,
    rating: ratingValue,
    percentage: percentageValue,
    priceRange: priceRangeString,
    notifications: notifications,
    agreePolicy: agreePolicy,
  );
  
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ViewRegistrationDataDialog(data: data);
    },
  );
    } catch (e) {
      setState(() { _isLoading = false; _message = ' خطأ: $e'; });
    }

}
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('إضافة حساب جديد', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

              Text('البيانات الأساسية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
              const Divider(color: Colors.indigoAccent),

              
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'الاسم ', border: OutlineInputBorder(), prefixIcon: Icon(Icons.numbers)),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'هاذا الحقل الزامي إلزامي' : null,
              ),
              const SizedBox(height: 5),

    
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'الايميل', border: OutlineInputBorder(), prefixIcon: Icon(Icons.account_balance_wallet)),
                validator: (value) => value!.isEmpty ? 'هاذا الحقل الزامي إلزامي' : null,
              ),
              const SizedBox(height: 5),

    
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
  	                	labelText: ' كلمة المرور', 
  		                border: OutlineInputBorder(), 
  		                prefixIcon: Icon(Icons.language)
  		),
  		validator: (value) => value!.isEmpty ? 'هاذا الحقل إلزامي' : null,
              ),
              const SizedBox(height: 5),
  		
  		TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
  	                	labelText: 'رقم الهاتف', 
  		                border: OutlineInputBorder(), 
  		                prefixIcon: Icon(Icons.language)
  		),
               ),
              const SizedBox(height: 5),
  		
  		TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
  	                	labelText: ' العمر',
  		                border: OutlineInputBorder(), 
  		                prefixIcon: Icon(Icons.language)
  		),
               ),
  		
              const SizedBox(height: 5),
  		
              Text('Demographics.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
              const Divider(color: Colors.indigoAccent),
  		DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: ' select your gender', border: OutlineInputBorder()),
                      value: _selectedGender,
                      items: _gender.map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
                      onChanged: (newValue) => setState(() => _selectedGender = newValue),
                      
                    ),
  		
  		const SizedBox(height: 5),
  		
  		DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'select your country', border: OutlineInputBorder()),
                      value: _selectedCountry,
                      items: _country.map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
                      onChanged: (newValue) => setState(() => _selectedCountry = newValue),
                      
                    ),
    
    Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: InputDecorator(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.calendar_today,color: Colors.purple),
                      ),
                      child: TextField(
                        readOnly: true,
                        controller: dateController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),),


                    ),
                  ),
                ),
    
    Expanded(
                  child: InkWell(
                    onTap: () => _selectTime(context),
                    child: InputDecorator(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.calendar_today,color: Colors.purple),
                      ),
                      child: TextField(
                        readOnly: true,
                        controller: timeController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),),


                    ),
                  ),
                )
    
              ],
            ),
  		
  		
              Text("Rating: ${_rating.toStringAsFixed(1)}"),
              Slider(
                min: 1,
                max: 5,
                divisions: 4,
                label: _rating.toStringAsFixed(1),
                value: _rating,
                onChanged: (v) => setState(() => _rating = v),
              ),
    const SizedBox(height: 5),
    Text("Percentage: ${_percentage.toInt()}%"),
              Slider(
                min: 0,
                max: 100,
                divisions: 100,
                label: "${_percentage.toInt()}%",
                value: _percentage,
                onChanged: (v) => setState(() => _percentage = v),
              ),

              const SizedBox(height: 5),

              Text(
                "Price Range: ${_priceRange.start.toInt()} - ${_priceRange.end.toInt()}",
              ),
              RangeSlider(
                min: 0,
                max: 1000,
                divisions: 100,
                labels: RangeLabels(
                  "${_priceRange.start.toInt()}",
                  "${_priceRange.end.toInt()}",
                ),
                values: _priceRange,
                onChanged: (v) => setState(() => _priceRange = v),
              ),

    
                    Text('خيارات إضافية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
                    const Divider(color: Colors.indigoAccent),
                    SwitchListTile(
                      title: const Text('حساب أساسي (Is Primary)', style: TextStyle(fontWeight: FontWeight.w500)),
                      subtitle: const Text('يحدد ما إذا كان هذا الحساب يمكن أن يكون له حسابات فرعية.'),
                      value: _isPrimary,
                      onChanged: (bool value) { setState(() { _isPrimary = value; }); },
                    ),
    
                    
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(color: Colors.indigo.shade200, blurRadius: 10, offset: const Offset(0, 5))],
                      ),
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submit(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: _isLoading
                            ? const SizedBox(width: 25, height: 25, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3,))
                            : const Text('Submit Form', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
              ),
            ),
        ),
    );
  }
  
  
  Widget _buildSwitchListTile({required String title, required bool value, required ValueChanged<bool> onChanged, required IconData icon}) {
    return SwitchListTile.adaptive(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      value: value,
      onChanged: onChanged,
      secondary: Icon(icon, color: value ? Colors.teal : Colors.grey),
      activeColor: Colors.teal,
      contentPadding: EdgeInsets.zero,
    );
  }
  
}


