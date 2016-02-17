#For check in page
module CheckInHelper
HOURS_WORKED = [[nil], ["1 hour or less"], ["1-2 hours"], ["2-4 Hours"], ["4-6 hours"], ["6-8 hours"], ["8-10 hours"], ["10-12 hours"], ["12-14 hours"], ["+14 hours"]]
ATTENTION_QUALITY=[[nil], ["Bad, I was pretty distracted", 1],
                          ["Medicore, I was neither overly focused nor distracted",2],
                          ["Good! I was REALLY focused", 3],
                          ["Great! It was Like I was super powered!", 4].freeze
end
