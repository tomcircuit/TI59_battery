/*
  TI-58/59 Battery Lid
  This is intended to hold a PCB and a LiPo battery,
  and charge from USB. 

  Dimensions more or less 'cribbed' from a BP-1 and an
  existing STL model that I imported into FreeCAD to measure.

  Version 1.1
  T. LeMense
  December 21, 2020
*/


$fa = 1;
$fs = 0.4;

// baseplate (first surface)
base_t = 1.0;
base_w = 44.85;
base_l = 56.4;
ledge_t = 1.25;
ledge_t1 = 0.75;
ledge_t2 = 1.85;

// PCB information
pcb_t = 1.6;
pcb_w = 28;
pcb_l = 53;
pcb_z = 13.5-pcb_t;
pcb_x = 6.5;

// USB connector cutout
// MOLEX 1050170001
usb_t = 3.75;
usb_w = 9.5;

// "superstructure"
super_w = base_w - ledge_t2 + ledge_t1;
super_l = base_l - 2*ledge_t;
super_h = 5.7;  // the "straight rise" from baseplate
super_z = base_t;  // the "altitude" at which everything starts
super_wall_t = 1.5;
super_floor_t = 0.5;
round_rad = (pcb_z+pcb_t+super_z)/2;

// latch 'tab' is extruded 2D
latch_tab_t = super_wall_t + 0.75;
latch_tab_h = 2.8;
latch_tab_t2 = 0.25;
latch_tab_w = 16.9;
latch_tab_z = 4.95;

p0 = [0, 0];
p1 = [0, latch_tab_h];
p2 = [latch_tab_t2,latch_tab_h];
p3 = [latch_tab_t,0];
tab_points = [p0, p1, p2, p3];
    
// hinge cutouts is extruded 2D
latch_tab_w2 = 12.0;
latch_tab_h2 = super_h+latch_tab_h;

p4 = [0, 0];
p5 = [0, latch_tab_h2];
p6 = [(latch_tab_w - latch_tab_w2)/2,latch_tab_h2];
p7 = [latch_tab_t2,0];
cutout_points = [p4, p5, p6, p7];

echo("inside cavity width is", super_w-2*super_wall_t);
echo("inside cavity length is", super_l-2*super_wall_t);
echo("PCB dimensions are ",pcb_w," x ",pcb_l);

module RoundedBoss(side,height,hole_dia){
    difference() {
        union() {
        cube([side,side/2,height]);
        translate([side/2,side/2,0])
        cylinder(r=side/2,h=height);
        }
        
        translate([side/2,side/2,height/3])
        cylinder(r=hole_dia/2,h=height/1.5);
    }
}

function RoundedBossHoleCenter(side,height,hole_dia) = [side/2,side/2,0];
   

/* 
  Define some "cuts" to export as DXF, to help
  guide the PCB size (cut 1) and PCB hole placement
  (cut 2).

  uncomment the projection.. and the desired translate line
*/

//projection(cut = true) 
//translate([0,0,-base_t/2])   //cut1
//translate([0,0,-pcb_z])   //cut2
//translate([0,0,-10.5])  //cut3
//translate([0,0,-20]) //cut4

union(){
difference() {
    union() {
        
// additive items        
        
    // the baseplate
    cube(size=[base_w, base_l, base_t]);
        
    // the superstructure inner volume
    translate([-0.75, 1.25, super_z])
    cube([super_w, super_l,super_h]); 

    // the locking tab
    translate([-ledge_t1-super_wall_t+super_w,ledge_t+(super_l/2)+(latch_tab_w/2),latch_tab_z+super_z]) 
    rotate([90,0,0]) 
    linear_extrude(height=latch_tab_w) polygon(tab_points);
        
    // the rounded rear wall
    translate([-ledge_t1+5.5,ledge_t,round_rad]) 
    rotate([-90,0,0]) 
    cylinder(r=round_rad,h=super_l);
        
    // the two rounded walls on either side of latch
    translate([-ledge_t1+super_w-round_rad,ledge_t,round_rad]) 
    rotate([-90,0,0]) 
    cylinder(r=round_rad,h=super_l/2-latch_tab_w/2);

    translate([-0.75+super_w-round_rad,base_l-ledge_t,round_rad]) 
    rotate([90,0,0]) 
    cylinder(r=round_rad,h=super_l/2-latch_tab_w/2);
        
    // complete the side walls
    translate ([(5-0.75),ledge_t,super_z])
    cube([super_w-12,super_wall_t,2*round_rad-super_z]);        

    translate ([(5-0.75),base_l-ledge_t-super_wall_t,super_z])
    cube([super_w-12,super_wall_t,2*round_rad-super_z]);
    }
    
// subtractive items            
    
    // remove the locking tab release slot
    translate([base_w - 1.85,1.25+(super_l/2)-(latch_tab_w*0.9/2),-0.25]) 
    cube([2,latch_tab_w*0.9,2]);
    
    // remove the polarizing baseplate notch
    translate([13.8,-1.25,-0.5]) cube([16.4,2.5,2]);
        
    // remove the two hinge cutouts
    translate([-1-super_wall_t+super_w,1.25+(super_l/2)-(latch_tab_w/2)-0.1,super_z])
    rotate([90,0,90])
    linear_extrude(height=2*super_wall_t)
    polygon(cutout_points);
    
    translate([-1+super_wall_t+super_w,1.25+(super_l/2)+(latch_tab_w/2)+0.1,super_z])
    rotate([90,0,-90]) 
    linear_extrude(height=2*super_wall_t) 
    polygon(cutout_points);

    // flatten the rounded wall edges
    translate([-2, 1.25+super_wall_t, super_z+11.5])
    cube([5,super_l-2*super_wall_t,5]);
    translate([base_w-4, 1.25+super_wall_t, super_z+10])
    cube([5,super_l-2*super_wall_t,5]);

    // remove cutout for PCB
    translate([pcb_x,0,super_z+pcb_z])
    cube([pcb_w, pcb_l+4, pcb_t+1]);
    
    // remove cutout for USB micro B
    translate([pcb_x+6,0,super_z+pcb_z-usb_t])
    cube([usb_w,5,5]);

    // remove the superstructure insides
    translate([-0.75+super_wall_t, 1.25+super_wall_t, super_z+super_floor_t])
    cube([super_w-2*super_wall_t, super_l-2*super_wall_t, 20]); 
 
}


// mounting screw bosses
boss_l = 4.5;
boss_dia = 2.1;
boss_inset = (boss_l - boss_dia)/4;

translate([pcb_x,ledge_t+super_wall_t-boss_inset,super_z])
RoundedBoss(boss_l,pcb_z,boss_dia);  // for #2 screw
h1 = [pcb_x+boss_l/2,ledge_t+super_wall_t-boss_inset+boss_l/2,0];

translate([pcb_x+pcb_w-boss_l,ledge_t+super_wall_t-boss_inset,super_z])
RoundedBoss(boss_l,pcb_z,boss_dia);  // for #2 screw
h2 = [pcb_x+pcb_w-boss_l/2,ledge_t+super_wall_t-boss_inset+boss_l/2,0];

translate([pcb_x+boss_l,base_l-ledge_t-super_wall_t+boss_inset,super_z])
rotate([0,0,180])
RoundedBoss(boss_l,pcb_z,boss_dia);  // for #2 screw
h3 = [pcb_x+boss_l/2,base_l-ledge_t-super_wall_t+boss_inset-boss_l/2,0];

translate([pcb_x+pcb_w,base_l-ledge_t-super_wall_t+boss_inset,super_z])
rotate([0,0,180])
RoundedBoss(boss_l,pcb_z,boss_dia);  // for #2 screw
h4 = [pcb_x+pcb_w-boss_l/2,base_l-ledge_t-super_wall_t+boss_inset-boss_l/2,0];


// uncomment this block if a pcb "model" is desired
pcb_model_z = 20;
pcb_model_z = pcb_z+pcb_t/2;
//hole_dia = 0.086 * 25.4;
pad_width = 5;
pad_length = 15;
hole_dia = 1;
pad1_x = 10;
pad2_x = 27;
echo ("pad1 center ",[pad1_x,base_l/2]);
echo ("pad2 center ",[pad2_x,base_l/2]);

translate([0,0,pcb_model_z]) 
    color("green") 
    linear_extrude(height=pcb_t) 
    difference(){
       translate ([pcb_x,(base_l-pcb_l)/2,0]) square ([pcb_w,pcb_l],false); 
       translate([pad1_x,base_l/2,pcb_model_z])        square([pad_width,pad_length],true);
       translate([pad2_x,base_l/2,pcb_model_z])        square([pad_width,pad_length],true);
       translate(h1) circle(d = hole_dia);
       translate(h2) circle(d = hole_dia);
       translate(h3) circle(d = hole_dia);
       translate(h4) circle(d = hole_dia);
    }
//*/
}


