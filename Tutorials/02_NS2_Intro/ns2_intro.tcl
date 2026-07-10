# Inspiration from https://youtu.be/Z3SYhhYvsFU?si=LgidEPtIaw8G_Ze6

# Procedure to clean up the resources (open files via their handles)
proc cleanup {} {
    # Note: the globals can be declared here before their definition,
    # as long as they are available before the function call
    global ns tr namtr
    $ns flush-trace
    close $tr
    close $namtr
    # Execute if nam is also on the same system (uncomment below)
    # exec nam out.nam &
    exit
}

# Create the ns-2 Simulator Object
set ns [new Simulator]

# Set the file for trace
set tr [open "out.tr" w]
$ns trace-all $tr

# Set the file for nam (network animator) trace
set namtr [open "out.nam" w]
$ns namtrace-all $namtr

# Create 2 nodes
set n0 [$ns node]
set n1 [$ns node]

# Create a wired duplex link between n0 and n1 with 2Mb bandwidth, 4ms delay and DropTail queue
$ns duplex-link $n0 $n1 2Mb 4ms DropTail

# Create TCP (Sender) and TCPsink (receiver) agents
set tcp1 [new Agent/TCP]
set tcp2 [new Agent/TCPSink]

# Attach the agents to the respective nodes and connect them
$ns attach-agent $n0 $tcp1
$ns attach-agent $n1 $tcp2
$ns connect $tcp1 $tcp2

# Create an FTP Application (Traffic source) and connect it to tcp1 agent
set ftp [new Application/FTP]
$ftp attach-agent $tcp1

# Create events at specific times 0.1s, 2s, 2.1s
$ns at .1 "$ftp start"
$ns at 2.0 "$ftp stop"
# End the simulation at 2.1s by calling the cleanup command
$ns at 2.1 "cleanup"

# Run the simulation
$ns run
