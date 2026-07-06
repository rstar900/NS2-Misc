# Increment a till 100, with a step of 2 and keep printing the value
# in each iteration
for {set a 0} {$a < 101} {set a [expr $a + 2]} {
puts -nonewline "a = "
puts $a
}

# For incrementing by just one, use {incr a} in third block instead
