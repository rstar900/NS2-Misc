# Inheritance of classes

# Create a Mom class with instance functions/procedures greet() and print_name
# and instance variable as age and class variable name
Class Mom
# after function name space is required before parameter list '{}'
Mom instproc greet {} {
    $self instvar age
    puts "Mom of age $age says: Hi, how are you my son?"
}

Mom instproc destroy {} {
puts "Destructor of Mom!"
}

# Create a subclass of Mom named Kid (Kid inherits from Mom)
Class Kid -superclass Mom
Kid instproc greet {} {
    $self instvar age
    puts "Son of age $age says: Hi, I am fine mom :)"
}

Kid instproc destroy {} {
puts "Destructor of Kid!!"
# Need this to call the destructor of parent class
$self next
}

# Test

# Create new Instance
set a [new Mom]
# Set instance variable value
$a set age 50
# Call instance procedure
$a greet

set b [new Kid]
$b set age 21
$b greet
# You should see the output from Kid and Mom's destructor
$b destroy
