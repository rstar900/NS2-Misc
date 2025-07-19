# Function to calculate the factorial of a given number n
proc factorial n {
    # Base case
    if {$n <= 1} {
        return 1
    }
    # Recursive case
    expr $n * [factorial [expr $n - 1]]
}

# Test
set a  5
set b 10

puts "Value of factorial $a is [factorial $a]"
puts "Value of factorial $b is [factorial $b]"