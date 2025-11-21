class ViewRegistrationDataDialog extends StatelessWidget {
  final UserInputData data;
		
  const ViewRegistrationDataDialog({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('✅ تفاصيل التسجيل (مُجمّعة)'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildInfoRow('الاسم الكامل:', data.fullName),
            _buildInfoRow('البريد الإلكتروني:', data.email),
            _buildInfoRow('كلمة المرور:', data.password != null ? '********' : null),
            _buildInfoRow('رقم الهاتف:', data.phoneNo),
            _buildInfoRow('العمر:', data.age),
            _buildInfoRow('النوع:', data.gender),
            _buildInfoRow('الدولة:', data.country),
            _buildInfoRow('التاريخ المختار:', data.selectedDate),
            _buildInfoRow('الوقت المختار:', data.selectedTime),
            _buildInfoRow('التقييم (Rating):', data.rating?.toStringAsFixed(1)),
            _buildInfoRow('النسبة المئوية:', data.percentage != null ? '${data.percentage!.toStringAsFixed(0)}%' : null),
            _buildInfoRow('نطاق السعر:', data.priceRange),
            _buildInfoRow('الإشعارات (Notifications):', data.notifications == true ? 'مفعلة' : 'معطلة'),
            _buildInfoRow('الموافقة على السياسة:', data.agreePolicy == true ? 'موافق' : 'غير موافق'),
          ].where((widget) => widget != null).toList().cast<Widget>(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('إغلاق'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
		
  Widget _buildInfoRow(String label, String? value) {
    if (value == null || value.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8.0),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
