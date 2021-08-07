part of 'widgets.dart';

class DateTimeWidget extends StatefulWidget {
  final BuildContext context;

  DateTimeWidget(this.context);
  @override
  _DateTimeWidgetState createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  late double _height;
  late double _width;

  late String _setTime, _setDate;

  late String _hour, _minute, _time;

  late String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        timeController.text = _time;
        timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void initState() {
    dateController.text = DateFormat.yMd().format(DateTime.now());

    timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.width / 3;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd().format(DateTime.now());
    return Container(
      height: _height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                'Choose Date',
                style: Theme.of(context).textTheme.caption,
              ),
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  width: _width / 4,
                  height: 46,
                  margin: EdgeInsets.only(top: 15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: TextFormField(
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: dateController,
                    onSaved: (String? val) {
                      _setDate = val!;
                    },
                    decoration: InputDecoration(
                        disabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        // labelText: 'Time',
                        contentPadding: EdgeInsets.only(top: 0.0)),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                'Choose Time',
                style: Theme.of(context).textTheme.caption,
              ),
              InkWell(
                onTap: () {
                  _selectTime(context);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  width: _width / 4,
                  height: 46,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: TextFormField(
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                    onSaved: (String? val) {
                      _setTime = val!;
                    },
                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: timeController,
                    decoration: InputDecoration(
                        disabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        // labelText: 'Time',
                        contentPadding: EdgeInsets.all(5)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
