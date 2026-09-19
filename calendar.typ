#let calendar(
  year: "",
  sunday_as_start: false,
  normalise_to_five_weeks: false,
  body,
) = {
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

    #let empty_cell = none

    // if month has 31 days, and the first day is second to last/last day of the week,
    // then the month will have 6 weeks
    // if month has 30 days, and the first day is the last day of the week,
    // then the month will have 6 weeks
    // otherwise, no need to normalise

    #let month_length = monthly_days.len()

    #let total_rows = if (
      month_length == 28 and first_day == 0
    ) {
      4
    } else if month_length == 30 and first_day == 7 {
      6
    } else if month_length == 31 and first_day in (6, 7) {
      6
    } else {
      5
    }

    #let monthly_days = (
      range(1, first_day).map(empty_day => empty_cell) + monthly_days
    )

    #if total_rows > 5 and normalise_to_five_weeks {
      total_rows = 5

      let _ = monthly_days.remove(0)
      monthly_days.insert(0, monthly_days.pop())

      if month_length == 31 and first_day == 7 {
        // first cell is the moved day, so remove the next cell of padding
        let _ = monthly_days.remove(1)
        monthly_days.insert(0, monthly_days.pop())
      }
    }

    #show table.cell.where(y: 0): strong
    #pad(
      y: 5%,
      table(
        columns: (1fr,) * 7,
        rows: (0.4fr,) + 5 * (1fr,),
        inset: 0.8em,
        table.header(..week_header),
        ..monthly_days.map(day => {
          if type(day) == type(empty_cell) { return }
          [#day.display(
            "[day padding:none]",
          )]
        }),
        stroke: (x, y) => {
          if y == 0 { return none }
          let cell_index = (y - 1) * 7 + x
          if (
            type(monthly_days.at(cell_index, default: empty_cell))
              == type(empty_cell)
          ) {
            return none
          }
          (thickness: 1.5pt)
        },
      ),
    )

    #pagebreak(weak: true)
  ]
}
