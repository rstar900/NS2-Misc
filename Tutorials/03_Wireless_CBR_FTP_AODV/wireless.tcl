# Inspiration taken from https://youtu.be/ws6kCbhdrWw?list=PLX6MKaDw0naZBi0R-6_IAuYA9Yk_yuyXp

# Initialize variables
# Here val is an associative array like a map or a dict
set val(chan)               Channel/WirelessChannel             ;# Channel Type
set val(prop)               Propagation/TwoRayGround            ;# Radio Propagation Model
set val(netif)              Phy/WirelessPhy                     ;# Network Interface Type (WAVELAN DSSS 2.4GHz)
set val(mac)                Mac/802_11                          ;# MAC Type
set val(ifq)                Queue/DropTail/PriQueue             ;# Interface Queue Type
set val(ll)                 LL                                  ;# Link Layer Type
set val(ant)                Antenna/OmniAntenna                 ;# Antenna Model
set val(ifqlen)             50                                  ;# Max Packets in ifq
set val(nn)                 6                                   ;# Number of Nodes
set val(rp)                 AODV                                ;# Routing Protocol (Adhoc On-demand Distance Vector)
set val(x)                  500                                 ;# Max X coordinate of simulation area (in Metres)
set val(y)                  500                                 ;# Max Y coordinate of simulation area (in Metres)

# Create Simulator object
set ns [new Simulator]

# Create trace and animation file
set tracefile [open wireless.tr w]
set namfile [open wireless.nam w]
$ns trace-all $tracefile
$ns namtrace-all-wireless $namfile $val(x) $val(y) ;# Use namtrace-all-wireless to be able to provide X and Y coordinates as well

# Finish procedure
proc finish {} {
    puts "Stopping Simulation ...."
    # Bring the required variables into the function's scope
    global ns tracefile namfile
    # Close files and exit with return code 0
    $ns flush-trace
    close $tracefile
    close $namfile
    exit 0
}

# Topography
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y) 

# GOD - General Operations Director
create-god $val(nn)

# Create channel (Communication path)
set channel1 [new $val(chan)]
set channel2 [new $val(chan)]

# Before creating nodes, we need to configure them
# Then automatically the last configuration is used by nodes created via $ns node
$ns node-config -adhocRouting $val(rp) \
                -llType $val(ll) \
                -macType $val(mac) \
                -ifqType $val(ifq) \
                -ifqLen $val(ifqlen) \
                -antType $val(ant) \
                -propType $val(prop) \
                -phyType $val(netif) \
                -topoInstance $topo \
                -agentTrace ON \
                -macTrace ON \
                -routerTrace ON \
                -movementTrace ON \
                -channel $channel1

# Create Nodes (n1, n4 and n5 are mobile, rest are stationary)
set n0 [$ns node]   ;# FTP, TCP Source Node
set n1 [$ns node]   ;# Mobile Node
set n2 [$ns node]   ;# CBR, UDP Source Node 
# For changing the channel or any other property, just change that in node-config and rest will follow those settings 
# commented line below is an example, setting n3-n5 in channel2
#$ns node-config -channel $channel2
set n3 [$ns node]   ;# Null Agent (Sink for UDP)
set n4 [$ns node]   ;# Mobile Node
set n5 [$ns node]   ;# Mobile Node, TCP Sink

# Disable any random motion for all the nodes
$n0 random-motion 0
$n1 random-motion 0
$n2 random-motion 0
$n3 random-motion 0
$n4 random-motion 0
$n5 random-motion 0

# Set sizes of nodes (make n5 larger than others)
$ns initial_node_pos $n0 20
$ns initial_node_pos $n1 20
$ns initial_node_pos $n2 20
$ns initial_node_pos $n3 20
$ns initial_node_pos $n4 20
$ns initial_node_pos $n5 50

# Position of the nodes (Wireless nodes need location)
# We use X and Y coordinates less than or equal to 500, as the max coordinates are 500 each

$n0 set X_ 10.0
$n0 set Y_ 20.0
$n0 set Z_ 0.0 ;# Since we are using flatgrid (2d space), so no Z coordinate

$n1 set X_ 100.0
$n1 set Y_ 200.0
$n1 set Z_ 0.0

$n2 set X_ 155.0
$n2 set Y_ 300.0
$n2 set Z_ 0.0

$n3 set X_ 340.0
$n3 set Y_ 400.0
$n3 set Z_ 0.0

$n4 set X_ 111.0
$n4 set Y_ 222.0
$n4 set Z_ 0.0

$n5 set X_ 400.0
$n5 set Y_ 300.0
$n5 set Z_ 0.0

# Mobility code (Time? Which node? Where to? What speed (m/s)?)
$ns at 1.0 "$n1 setdest 450.0 325.0 25.0"
$ns at 1.0 "$n4 setdest 350.0 225.0 5.0"
$ns at 1.0 "$n5 setdest 127.0 225.0 15.0"
$ns at 20.0 "$n5 setdest 170.0 25.0 30.0"   ;# Let's move n5 again to some place at 20s with 30 m/s speed

# Creation of agents

# TCP (with FTP application)
set tcp [new Agent/TCP]
set tcpsink [new Agent/TCPSink]
$ns attach-agent $n0 $tcp
$ns attach-agent $n5 $tcpsink
$ns connect $tcp $tcpsink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 1.0 "$ftp start"

# UDP (with CBR) traffic
set udp [new Agent/UDP]
set nullagent [new Agent/Null]
$ns attach-agent $n2 $udp
$ns attach-agent $n3 $nullagent
$ns connect $udp $nullagent
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$ns at 1.0 "$cbr start"

# Finish Simulation at 30s
$ns at 30.0 "finish"

# Run the simulation
puts "Starting Simulation ...."
$ns run