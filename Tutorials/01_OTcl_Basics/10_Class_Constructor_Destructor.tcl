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

# Define a constructor
Student instproc init {} {
$self instvar name roll city
set name "Default_Name"
set roll 0
set city "Default_City"
}

# Define a destructor
Student instproc destroy {} {
puts "Student Destructor called!"
}

# Create an object
Student s1

# Print attributes using the show procedure of Student
# If this displays defaults set in init, means constructor is already called
s1 show
# Destructor needs to be called manually
s1 destroy
