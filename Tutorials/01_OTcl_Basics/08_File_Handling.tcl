# File modes : r, w, r+, w+

# Write to a file
# Get a file handle (f)
set f [open "hello.txt" w]
# Write to the handle
puts $f "Hei fra Norge!"
# close the handle
close $f

# Read a file
# Get a file handle (f)
set f [open "hello.txt" r]
# Read from the handle to a variable d
gets $f d
# Display the contents of d
puts "Contents of hello.txt: $d"
# close the handle
close $f
