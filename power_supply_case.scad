$fn=30;

power_supply_width = 114;
power_supply_height = 50;

bracket_depth = 80;

thickness = 3;

power_connector_w = 20;
power_connector_h = 28;

power_switch_w = 23;
power_switch_h = 29;

power_line_hole_w = 40;
power_line_hole_h = 10;

offset_size = 1.1;
offsetp = ((thickness*offset_size) - thickness) /2;
offsetn = offsetp * -1;

screw_size = 3.5;

part_width = power_supply_width + thickness * 2;
part_height = power_supply_height + thickness;
part_depth = bracket_depth;

module wire_cutout(){
    translate([power_line_hole_w/2 - power_line_hole_h/2,0,0]){
      cylinder(r=power_line_hole_h/2, h=offset_size*thickness, center=true);
    }
    translate([-1 * (power_line_hole_w/2 - power_line_hole_h/2),0,0]){
      cylinder(r=power_line_hole_h/2, h=offset_size*thickness, center=true);
    }
    cube([power_line_hole_w-power_line_hole_h,power_line_hole_h,offset_size*thickness],center=true);
}

module power_connector_cutout(){
  cube([power_connector_w,power_connector_h,thickness*2],center=true);
}

module power_switch_cutout(){
  cube([power_switch_w,power_switch_h,thickness*2], center=true);
}

module faceplate() {
  rotate([0,180,0]){
    difference(){
      translate([0,-1 * thickness/2,0]){
        cube([part_width,part_height,thickness],center=true);
      }
      translate([-1 * (power_supply_width/4 + power_supply_width/8),0,0]){
        power_connector_cutout();
      }
      translate([-1 * power_supply_width/8,0,0]){
        power_switch_cutout();
      }
      translate([power_supply_width/4,0,0]){
        wire_cutout();
      }
    }
  }
}


module topplate(){
  cube([part_width,bracket_depth-thickness,thickness],center=true);
}

module screw_cutout(){
  cylinder(r=screw_size/2,h=offset_size*thickness,center=true);
}
//12 top 10 bottom
top_screw_offset = 12+screw_size/2;
bottom_screw_offset = 10 + screw_size/2;
screw_offset_y = 10;
module sideplate(){
  difference() {
    cube([power_supply_height,bracket_depth-thickness,thickness],center=true);
    translate([power_supply_height/2-bottom_screw_offset,-10 + (bracket_depth-thickness)/2,0]){
      screw_cutout();
    }
    translate([(-1 * power_supply_height/2)+top_screw_offset,-10 + (bracket_depth-thickness)/2,0]){
      screw_cutout();
    }
  }
}

module whole_thing(){
  translate([0,0,thickness/2]){
    faceplate();
    translate([part_width/2 - thickness/2 ,0,part_depth/2]){
      rotate(a=[90,0,90]){
        sideplate();
      }
    }
    translate([-1* (part_width/2 - thickness/2) ,0,part_depth/2]){
      rotate(a=[90,0,90]){
        sideplate();
      }
    }
    translate([0,-1* (part_height/2 ) ,part_depth/2]){
      rotate(a=[90,0,0]){
        topplate();
      }
    }
  }
}

whole_thing();
