#let calendar(year: "", sunday_as_start: false, body) = {
  set document(title: str(year) + " calendar")

  for month in range(1, 13) [

    #let month_date = datetime(
      year: year,
      month: month,
      day: 1,
    )

    #let monthly_days = ()

    #for day in range(0, 31) [
      #let month_accumulator = (month_date + duration(days: day))
      #if month_accumulator.month() != month {
        break
      }
      #monthly_days.push(month_accumulator)
    ]

    #align(left)[
      #heading(level: 1)[
        #text(size: 27pt)[#month_date.display("[month repr:long]") #year
        ]
      ]
    ]

    #let start_of_week = if sunday_as_start { "sunday" } else { "monday" }
    #let first_day = int(monthly_days
      .first()
      .display("[weekday repr:" + start_of_week + "]"))

    #let week_header = (
      [Monday],
      [Tuesday],
      [Wednesday],
      [Thursday],
      [Friday],
      [Saturday],
      [Sunday],
    )
    #if sunday_as_start {
      week_header.insert(0, week_header.pop())
    }

    #show table.cell.where(y: 0): strong
    #pad(
      y: 5%,
      table(
        columns: (1fr,) * 7,
        rows: (0.4fr,) + 5 * (1fr,),
        inset: 0.8em,
        table.header(..week_header),
        ..range(1, first_day).map(empty_day => []),
        ..monthly_days.map(day => [#day.display("[day padding:none]")]),
        stroke: (x, y) => if y != 0 {
          (thickness: 1.5pt)
        },
      ),
    )

    #pagebreak(weak: true)
  ]
}
