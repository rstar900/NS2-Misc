# Initialize a few variables
set a 1
set b "Hello World!"
set c 2.3

# Assign a new variable the value of a
set x $a

# Assign a new variable value of a calculation (or another function)
set y [expr $a * 100]

# -nonewline makes puts command not end with a new line
puts -nonewline "a: "
puts $a
puts -nonewline "b: "
puts $b
puts -nonewline "c: "
puts $c
puts -nonewline "x: "
puts $x
puts -nonewline "y: "
puts $y
