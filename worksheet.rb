########################################################
# Step 1: Establish the layers
# In this section of the file, as a series of comments,
# create a list of the layers you identify.
# headings/info: driver ID, date, cost, rider ID, rating
# LAYERS:
#drivers, riders, and rides
#---------------------------------------
# Which layers are nested in each other?
# drivers (layer) contain rides
# riders (layer) contain rides
# ratings (layer) contain ride info (different options such as driver ID, cost)
# the ID numbers of the riders and drivers could be nested: IDs => {driver_ID => number, rider_ID => number}
# --------------------------------------
# Which layers of data "have" within it a different layer?
# Id numbers can have different layers, dates can also have different layers
# Dates could be nested, although that won't help for the step 4 questions: {2016 => [{February => [01..28]}]}
# rides could have different layers based on ratings
# -------------------------------------
# Which layers are "next" to each other?
#Id numbers of the drivers are next to each other
########################################################
# Step 2: Assign a data structure to each layer
# driver -> ID, rides
# rider -> ID, rides
# ride -> driver, rider, date, cost, rating
# Copy your list from above, and in this section
# determine what data structure each layer should have

# driver -> ID number
# rides -> date, cost, rating, rider_id

########################################################
# Step 3: Make the data structure!
# Setup the entire data structure:
# based off of the notes you have above, create the
# and manually write in data presented in rides.csv
# You should be copying and pasting the literal data
# into this data structure, such as "DR0004"
# and "3rd Feb 2016" and "RD0022"

ride_data = [
  {
    driver_id: "DR0001",
    rides: [
      {
        date: "3rd Feb 2016",
        cost: 10,
        rating: 3,
        rider_id: "RD0003"
      },
      {
        date: "3rd Feb 2016",
        cost: 30,
        rating: 4,
        rider_id: "RD0015"
      },
      {
        date: "5th Feb 2016",
        cost: 45,
        rating: 2,
        rider_id: "RD0003"
      }
    ]
  },
  {
    driver_id: "DR0002",
    rides: [
      {
        date: "3rd Feb 2016",
        cost: 25,
        rating: 5,
        rider_id: "RD0073"
      },
      {
        date: "4th Feb 2016",
        cost: 15,
        rating: 1,
        rider_id: "RD0013"
      },
      {
        date: "5th Feb 2016",
        cost: 35,
        rating: 3,
        rider_id: "RD0066"
      }
    ]
  },
  {
    driver_id: "DR0003",
    rides: [
      {
        date: "4th Feb 2016",
        cost: 5,
        rating: 5,
        rider_id: "RD0066"
      },
      {
        date: "5th Feb 2016",
        cost: 50,
        rating: 2,
        rider_id: "RD0003"
      }
    ]
  },
  {
    driver_id: "DR0004",
    rides: [
      {
        date: "3rd Feb 2016",
        cost: 5,
        rating: 5,
        rider_id: "RD0022"
      },
      {
        date: "4th Feb 2016",
        cost: 10,
        rating: 4,
        rider_id: "RD0022"
      },
      {
        date: "5th Feb 2016",
        cost: 20,
        rating: 5,
        rider_id: "RD0073"
      }
    ]
  }
]


########################################################
# Step 4: Total Driver's Earnings and Number of Rides
# Use an iteration blocks to print the following answers:
# QUESTION 1: the number of rides each driver has given

def get_total_rides_per_driver(ride_data)
  number_of_rides = {}
  # access driver's IDs to be used as keys in hash "ride_info", then
  # access the cost of each ride per driver, to be the corresponding value
  ride_data.length.times do |driver_index|
    driver_id = ride_data[driver_index][:driver_id]
    rides = ride_data[driver_index][:rides].length
    number_of_rides[driver_id] = rides
  end
  return number_of_rides
end

puts "\nTotal number of rides per driver:\n\n"
ride_data.length.times do |i|
  puts "Driver #{get_total_rides_per_driver(ride_data).keys[i]} " +
         "completed #{get_total_rides_per_driver(ride_data).values[i]} rides."
end
puts "-------------------------------------------------------"
#------------------------------------------------------#
# QUESTION 2: the total amount of money each driver has made

def get_amount_each_driver_made(ride_data)
  driver_income = {}
  #outer loop accesses the driver ID No.
  ride_data.length.times do |driver_index|
    income = 0
    driver_id = ride_data[driver_index][:driver_id]
    # inner loop accesses (and sums) the cost associated with each
    # ride the driver has given
    ride_data[driver_index][:rides].length.times do |ride_index|
      cost = ride_data[driver_index][:rides][ride_index][:cost]
      income += cost
    end
    #store the key-value pair of the driver ID and their total ride income
    driver_income[driver_id] = income
  end
  return driver_income
end

puts "\nEach driver made the following amount:\n\n"
ride_data.length.times do |i|
  puts "Driver #{get_amount_each_driver_made(ride_data).keys[i]} " +
         "made $#{get_amount_each_driver_made(ride_data).values[i]}."
end
puts "-------------------------------------------------------"

#------------------------------------------------------#
# QUESTION 3: Find the average rating for each driver
def get_driver_average_rating(ride_data)
  driver_rating = {}
  # outer loop accesses the driver ID No. & how
  # many rides given (how many ratings received)
  ride_data.length.times do |driver_index|
    rating_value = 0.0
    driver_id = ride_data[driver_index][:driver_id]
    number_of_ratings = ride_data[driver_index][:rides].length
    # inner loop accesses and sums rating of each ride a driver has given
    ride_data[driver_index][:rides].length.times do |ride_index|
      rating = ride_data[driver_index][:rides][ride_index][:rating]
      rating_value += rating
    end
    # store the key-value pair of the driver ID and the average rating
    avg_rating = rating_value/number_of_ratings
    driver_rating[driver_id] = avg_rating
  end
  return driver_rating
end

puts "\nAverage rating for each driver:\n\n"
ride_data.length.times do |i|
  puts "Driver #{get_driver_average_rating(ride_data).keys[i]} has " +
         "an average rating of %.2f." % get_driver_average_rating(ride_data).values[i]
end
puts "-------------------------------------------------------"


#------------------------------------------------------#
# QUESTION 4: Which driver made the most money?
# (compare costs from question 1)

def find_who_made_the_most(ride_data)
  driver_income = get_amount_each_driver_made(ride_data)
  amount = 0
  highest_income_driver = nil
  # find and store/save the driver who made the most
  # and the value of their income
  driver_income.each do |driver, income|
    if income > amount
      amount = income
      highest_income_driver = driver
    end
  end
  # return an array with two values for the driver
  # with the highest earnings: the driver ID and the amount they made
  return highest_income_driver, amount
end

puts "\nThe most money, $#{find_who_made_the_most(ride_data)[1]}, " +
       "was made by driver #{find_who_made_the_most(ride_data)[0]}."
puts "-------------------------------------------------------"
#------------------------------------------------------#
# QUESTION 5: Which driver has the highest average rating?
# ()compare ratings from question 3)

def find_highest_average_rating(ride_data)
  driver_rating = get_driver_average_rating(ride_data)
  highest_rating = 0
  driver_with_highest_rating = nil
  # find and store/save the driver with the highest average
  # ratings and what their average rating is
  driver_rating.each do |driver, rating|
    if rating > highest_rating
      highest_rating = rating
      driver_with_highest_rating = driver
    end
  end
  # return an array with two values for the driver with the
  # highest average rating: the driver ID and the highest average rating
  return driver_with_highest_rating, highest_rating
end

puts "\nDriver #{find_highest_average_rating(ride_data)[0]} has the " +
       "highest rating value of %.2f." % find_highest_average_rating(ride_data)[1]
puts "-------------------------------------------------------"
