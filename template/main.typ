#import "../calendar.typ": calendar

#set page(
  "a4",
  flipped: true,
  margin: 8%,
)
#set text(size: 14pt)

#show: calendar.with(
  year: datetime.today().year(),
  sunday_as_start: true,
  normalise_to_five_weeks: true,
)
