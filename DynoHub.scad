use <hexagonalprism.scad>
use <MCAD/bearing.scad>

/*
    A very basic and unrefined proof-of-concept sketch for a 
    Greenspeed dynamo hub. It's designed to use 6x KK-P10/10 
    electromagnets and 12x 10x3, 3mm drilled N35 rare earth magnets.
    Actual GT20 hubs have yet to be accurately measured, so the axle 
    hole, hub flanges and spokes are yet to be accurately positiond,
    the bearing seats have no seating lips and the magnet clearances
    have yet to be finessed. There certainly appears to be sufficient
    room for rectifier diodes and a port for unfiltered DC output
    cables. (+/- 12v P-P) The coils won't produce enough current for
    regenerative braking, but with a hub on each front wheel, there
    should be at least 12x 40mA * 12v, or 3 watts from 2 hubs. More than enough to charge a pair of USB lights.
*/

axis();
for(z=[0.1,45.9]) translate([0,0,z]) bearing(model=6905);
for(a=[0:60:300]) rotate([0,0,a]) 
        translate([0,-9,27.5]) rotate([90,0,0]) inductor();
shell();
for(a=[0:60:300]) rotate([0,0,a]) 
        translate([0,24,27.5]) rotate([90,0,0]) magnet();
for(a=[30:60:330]) rotate([0,0,a]) 
        translate([0,21,27.5]) rotate([-90,0,0]) magnet();

module shell() color("silver") difference(){
    $fn = 60;
    union(){
        cylinder(r=28,h=55);
        for(z=[3,52]) translate([0,0,z]) 
                rotate_extrude() translate([27,0]) hull(){
            circle(2);
            translate([12,0]) circle(1);
        }
    }
    translate([0,0,-1]) cylinder(r=21.2,h=57);
    translate([0,0,9.2]) cylinder(r=25,h=36.8);
    translate([22.5,-60,-10]) rotate([0,-30,0]) cube([60,120,90]);
    for(a=[0:30:330]) rotate([0,0,a]){
        translate([0,0,27.5]) rotate([90,0,0]) cylinder(r=1.2,h=32);
    }
    for(a=[0:360/16:360-360/16]) rotate([0,0,a]) 
            translate([0,-35,0]) cylinder(r=1.5,h=20);
    for(a=[0:360/16:360-360/16]) rotate([0,0,a+360/32]) 
            translate([0,-35,45]) cylinder(r=1.5,h=20);
}

module axis() color("silver") difference(){
    $fn = 60;
    union(){
        cylinder(r=12.45,h=55);
        translate([0,0,18.5]) hexPrism(r=17.5,h=18);
    }
    translate([0,0,-1]) cylinder(r=6.4,h=57);
    for(a=[0:60:330]) rotate([0,0,a]){
        translate([0,0,27.5]) rotate([90,0,0]) cylinder(r=1.2,h=20);
        translate([0,-12.5,27.5]) 
                rotate([90,0,0]) cylinder(r1=5.2,r2=23.5,h=20);
    }
}

module magnet() difference(){
    $fn = 60;
    union(){
        color("blue") cylinder(r=5,h=1.5);
        color("red") translate([0,0,1.5]) cylinder(r=5,h=1.5);
    }
    translate([0,0,-1]) cylinder(r=1.7,h=8);
}

module inductor(){
    $fn = 60;
    color("gray") difference(){
        cylinder(r=5,h=10);
        translate([0,0,1]) difference(){
            cylinder(r=3.5,h=10);
            translate([0,0,-1]) cylinder(r=2,h=12);
        }
    }
    color("black") translate([0,0,1]) difference(){
        cylinder(r=3.5,h=8);
        translate([0,0,-1]) cylinder(r=2,h=12);
    }
}