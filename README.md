# October

This template generates a monthly calendar, designed to be printed in landscape.

## Usage

The calendar function requires one parameter for the year, which should be formatted as an integer,
as well as two optional arguments. 
One for if Sunday or Monday should be considered the start of the week (it is Monday by default).
Another for if months with 6 weeks should be modified so that the layout uses 5
rows instead of 6.

```typst
#show: calendar.with(
  year: 2026,
  sunday_as_start: true,
  normalise_to_five_weeks: true
)
```

Otherwise, the current year can be passed in with `datetime.today().year()`.

```typst
#show: calendar.with(
  year: datetime.today().year()
)
```

When printed on A4 paper there isn't much space for writing in each day box, the calendar is more suited to blocking out days with a highlighter.
For example, to mark days of rest in a variable pattern of work shifts.

## License

[MIT No Attribution](https://github.com/extua/october/blob/main/LICENSE) © Pierre Marshall.

