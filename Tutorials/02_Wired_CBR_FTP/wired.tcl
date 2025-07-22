# Inspiration from https://youtu.be/FS0jnfNCwBA?list=PLX6MKaDw0naZBi0R-6_IAuYA9Yk_yuyXp
# and https://www.geeksforgeeks.org/computer-networks/basics-of-ns2-and-otcltcl-script/ 

# Create the Simulator object
set ns [new Simulator]

# Define different colours for 2 different data flows
$ns color 1 Blue
$ns color 2 Red

# Open the trace file and nam file for writing
set tracefile [open wired.tr w]
set namfile [open wired.nam w]

# Set these files for their respective roles
$ns trace-all $tracefile
$ns namtrace-all $namfile

# Define finish function which runs automatically at the end of simulation
proc finish {} {
    # Bring the required variables into the function's scope
    global ns tracefile namfile
    # Close files and exit with return code 0
    $ns flush-trace 
    close $tracefile
    close $namfile
    exit 0
}

# Create 6 nodes (n0,...,n5)
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

# Connect these nodes via duplex links of different bandwidths and latencies
# Set the queue as DropTail, which drops incoming packets if queue is full
$ns duplex-link $n0 $n1 5Mb 2ms DropTail
$ns duplex-link $n2 $n1 10Mb 5ms DropTail
$ns duplex-link $n1 $n4 3Mb 10ms DropTail
$ns duplex-link $n4 $n3 100Mb 2ms DropTail
$ns duplex-link $n4 $n5 4Mb 10ms DropTail

# Create and attach UDP agent at n0, and NULL agent at n3
set udp [new Agent/UDP]
set null [new Agent/Null]
$ns attach-agent $n0 $udp
$ns attach-agent $n3 $null
# Assign red color to UDP flow
$udp set fid_ 2

# Create and attach TCP agent at n2, and TCP Sink agent at n5
set tcp [new Agent/TCP]
set tcpsink [new Agent/TCPSink]
$ns attach-agent $n2 $tcp
$ns attach-agent $n5 $tcpsink
# Assign blue color to TCP flow
$tcp set fid_ 1

# Create udp logical connection between n0 and n3
$ns connect $udp $null
# Create tcp logical connection between n2 and n5
$ns connect $tcp $tcpsink

# Create CBR and FTP application traffic source at udp and tcp agents
set cbr [new Application/Traffic/CBR]
set ftp [new Application/FTP]

# Attach agents to the applications
$cbr attach-agent $udp
$ftp attach-agent $tcp

# Define the events at 1 and 2s
$ns at 1.0 "$cbr start"
$ns at 2.0 "$ftp start"

# End the simulation at 10s
$ns at 10.0 "finish"

# run the simulation
puts "Starting ns2 wired CBR and FTP Simulation...."
$ns run