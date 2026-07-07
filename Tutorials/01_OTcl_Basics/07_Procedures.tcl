# proc -> Procedure definition (like a function)
proc max {a b} {
if {$a > $b} {
return $a
} else {
return $b
}
}

# procedure call
set x 9
set y 10
puts "Maximum of x and y is: [max $x $y]"

# Return multiple values
proc fun {} {
return [list 1 2 3 4 89.5 "Hei!"]
}

puts "List contains [fun]"

# Global scope (Outside of any function)
set a 5
set b 10

puts "a before: $a"
puts "b before: $b"

# If we want to change any global variable within a function, we use global keyword
proc modify {} {
global a
set a 20
set b 100
}

# a gets modified, b doesnt
modify
puts "a after: $a"
puts "b after: $b"
