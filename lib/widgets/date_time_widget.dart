part of 'widgets.dart';

class DateTimeWidget extends StatefulWidget {
  @override
  _DateTimeWidgetState createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  late DateTime pickedDate;
  late TimeOfDay time;
  @override
  void initState() {
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTimeProvider dateTimeProvider = Provider.of(context);
    dateTimeProvider
        .addDate("${pickedDate.day}/${pickedDate.month}/${pickedDate.year}");
    dateTimeProvider.addTime("${time.hour}:${time.minute}");

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () async {
              DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: pickedDate,
                  firstDate: DateTime(DateTime.now().year),
                  lastDate: DateTime(DateTime.now().year + 100));
              if (date != null) {
                setState(() {
                  pickedDate = date;
                });
                dateTimeProvider.addDate(
                    "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}");
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Date:"),
                Container(
                  width: 130,
                  height: 55,
                  child: ListTile(
                    title: Text(
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}"),
                  ),
                ),
                Icon(Icons.arrow_drop_down_circle)
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              TimeOfDay? newTime =
                  await showTimePicker(context: context, initialTime: time);
              if (newTime != null) {
                setState(() {
                  time = newTime;
                });
                dateTimeProvider.addTime("${time.hour}:${time.minute}");
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Time:'),
                Container(
                  width: 130,
                  height: 55,
                  child: ListTile(
                    title: Text("${time.hour}:${time.minute}"),
                  ),
                ),
                Icon(Icons.arrow_drop_down_circle)
              ],
            ),
          )
        ],
      ),
    );
  }
}
