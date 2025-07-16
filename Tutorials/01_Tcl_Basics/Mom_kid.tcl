# Definition of classes

# Create a Mom class with instance functions/procedures greet() and print_name
# and instance variable as age and class variable name
Class Mom
# after function name space is required before parameter list '{}'
Mom instproc greet {} {
    $self instvar age
    puts "Mom of age $age says: Hi, how are you my son?"
}

# Create a subclass of Mom named Kid
Class Kid -superclass Mom
Kid instproc greet {} {
    $self instvar age
    puts "Son of age $age says: Hi, I am fine mom :)"
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