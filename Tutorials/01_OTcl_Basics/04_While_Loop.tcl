set a 0

# Increment a till 100, with a step of 2 and keep printing the value
# in each iteration
while {$a < 101} {
puts -nonewline "a = "
puts $a
set a [expr $a + 2]
}
