module ProjectHelper
 def options_for_project_amount
  options_for_select([
    ['1 eighth-day', 1],
    ['1 quarter-day', 2],
    ['3 eighth-days', 3],
    ['1 half-day',4],
    ['5 eighth-days', 5],
    ['3 quarter-days', 6],
    ['7 eight-days', 7],
    ['1 whole day',8]])
  end
end