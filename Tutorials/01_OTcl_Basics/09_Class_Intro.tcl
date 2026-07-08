# Declare a class (C should be uppercase)
Class Student

# Procedure (like a method in this case) for objects of this class
Student instproc show {} {
# Try to display the student's info in a more beautiful way
# $self to reference the calling object and instvar to declare the variables used
$self instvar name roll city
puts "-----------------Show{}-------------------------"
puts "Name:     $name"
puts "Roll No.: $roll"
puts "City:     $city"
puts "------------------------------------------"
}

# Create an object
Student s1

# Set the attributes for this object
s1 set name "John"
s1 set roll "1234"
s1 set city "Stockholm"

# Print the attributes
# set without value returns the current value
puts [s1 set name]
puts [s1 set roll]
puts [s1 set city]

# Print using the show procedure of Student
s1 show
