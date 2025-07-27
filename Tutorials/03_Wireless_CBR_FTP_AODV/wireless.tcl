# Inspiration taken from https://youtu.be/ws6kCbhdrWw?list=PLX6MKaDw0naZBi0R-6_IAuYA9Yk_yuyXp

# Initialize variables
# Here val is an associative array like a map or a dict
set val(chan)               Channel/WirelessChannel             ;# Channel Type
set val(prop)               Propagation/TwoWayGround            ;# Radio Propagation Model
set val(netif)              Phy/WirelessPhy                     ;# Network Interface Type
set val(mac)                Mac/802_11                          ;# MAC Type
set val(ifq)                Queue/DropTail/PriQueue             ;# Interface Queue Type
set val(ll)                 LL                                  ;# Link Layer Type
set val(ant)                Antenna/OmniAntenna                 ;# Antenna Model
set val(ifqlen)             50                                  ;# Max Packets in ifq
set val(nn)                 6                                   ;# Number of Nodes
set val(rp)                 AODV                                ;# Routing Protocol
set val(x)                  500                                 ;# Max X coordinate of simulation area (in Metres)
set val(y)                  500                                 ;# Max Y coordinate of simulation area (in Metres)

# Create Simulator object
set ns [new Simulator]

# Create trace and animation file
set tracefile [open wireless.tr w]
set namfile [open wireless.nam w]
$ns trace-all $tracefile
$ns namtrace-all $namfile

# Finish procedure
proc finish {} {
    # Bring the required variables into the function's scope
    global ns tracefile namfile
    # Close files and exit with return code 0
    $ns flush-trace
    close $tracefile
    close $namfile
    exit 0
}

# Topography

# GOD - General Operations Director

# Create Nodes

# Create channel (Communication path)

# Position of the nodes (Wireless nodes need location)

# Mobility code (For moving some of the nodes here)

# TCP (with FTP application), UDP (with CBR) traffic

# Run the simulation
$ns run