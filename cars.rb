class Car

	@@total_car_count = 0 
	@@cars_per_color = {} # created a class variable that is an empty hash. 

# class methods use self because it belongs to the class instead of the instance ... 
# @@total_car_count is a class variable

	def self.total_car_count
		@@total_car_count
	end

	def self.cars_per_color
		@@cars_per_color
	end

	# def self.most_popular_color
	# 	@@cars_per_color.max_by {|color, amount| amount}[0]
	# end

	def to_s()
		"I'm a car! I've driven #{@distance} and have #{@fuel} gallons gas left"
	end


# each time a new instance of car is created, the
# class variable @@total_car_count increases by one.
# each car has a 10 unit tank and starts with 0. 

	def initialize(color)
		@@total_car_count += 1
		@color = color
		@fuel = 10
		@distance = 0
	end

	def color=(new_color)
		@@cars_per_color[@color] -= 1
		@color = new_color
		if @@cars_per_color.include?(new_color)
			@@cars_per_color[new_color] += 1
		else
			@@cars_per_color[new_color] = 1
		end
	end

	def drive(miles)
		if (@fuel - miles/20.0) >= 0
			@distance += miles
			@fuel -= miles/20.0
		else
			@distance += @fuel * 20.0
			@fuel = 0
			puts "You're out of gas!"
		end
	end

	def fuel_up()
		gallons_needed = 10.0 - @fuel
		puts "You must pay $#{3.5 * gallons_needed}"
		@fuel = 10.0
	end

end #end of Car class


class ConvertibleCar < Car

  attr_accessor :roof_status

  def initialize(color, convertible)
    super(color)
    @convertible = convertible
    @roof_status = "closed"
  end

  def top_down
    @roof_status = "open top"
  end

  def close_top
    @roof_status = "close top"

  end
end


car_a = Car.new("purple")
puts car_a
car_a.drive(10)
puts car_a
car_a.drive(232)
puts car_a
car_b = ConvertibleCar.new("blue",true)
puts car_b.roof_status
Car.most_popular_color


=begin

Class methods are used only on the class. 
Instance methods are used only on instances. 
Instance variables can be accessed only in instance methods.
Class variables can be accessed anywhere.

Doesn't quite work - says 0 0 0 
puts Car.total_car_count
c1 = Car.new
puts Car.total_car_count
c2 = Car.new
puts Car.total_car_count

1 - Class methods on instance
Class methods can only be used on the class,
which is why this one does not work (undefined method total_car_count)
c = Car.new
c.total_car_count

2 - Class method on class (works because it's on a class)
Car.total_car_count
puts Car.total_car_count

3 - Instance method on class
doesn't work because instance methods are used only on instances.
Car.drive(10)

4 - Instance method on instance, this one works
c= Car.new
c.drive(10)

=end
