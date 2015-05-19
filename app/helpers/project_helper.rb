module ProjectHelper
  AMOUNT_OPTIONS = [
    ['1 eighth-day', 1],
    ['1 quarter-day', 2],
    ['3 eighth-days', 3],
    ['1 half-day', 4],
    ['5 eighth-days', 5],
    ['3 quarter-days', 6],
    ['7 eight-days', 7],
    ['1 whole day', 8]
  ]

  WORST = 1
  BAD = 2
  OKAY = 3
  GOOD = 4
  BEST = 5
  QUALITY_OPTIONS = [WORST, BAD, OKAY, GOOD, BEST]

  def options_for_project_amount
    options_for_select(AMOUNT_OPTIONS)
  end
end
