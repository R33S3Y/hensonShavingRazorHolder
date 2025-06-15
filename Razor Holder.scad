include <gridfinity-rebuilt-openscad/gridfinity-rebuilt-bins.scad>;
module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	module build_point(type = "sphere", rotate = [0, 0, 0]) {
		if (type == "sphere") {
			sphere(r = radius);
		} else if (type == "cylinder") {
			rotate(a = rotate)
			cylinder(h = diameter, r = radius, center = true);
		}
	}

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							build_point("sphere");
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							build_point("cylinder", rotate);
						}
					}
				}
			}
		}
	}
}



$fn=25;

difference() { union() { difference() {
        translate([0,-47,-8])
            roundedcube([41.5,125.5,28], center=true, radius = 5, apply_to = "z");
        translate([0,0,51])
            cube([100,250,100], center=true);
    }
        translate([0, -47, -27]) {
            // This uses all your defined parameters above
            // and runs the bin generator and base
            gridfinityInit(gridx, gridy, height(gridz, gridz_define, style_lip, enable_zsnap), height_internal, grid_dimensions=grid_dimensions, sl=style_lip) {
                if (divx > 0 && divy > 0) {
                    cutEqual(n_divx = divx, n_divy = divy, style_tab = style_tab, scoop_weight = scoop, place_tab = place_tab);
                } else if (cdivx > 0 && cdivy > 0) {
                    cutCylinders(n_divx=cdivx, n_divy=cdivy, cylinder_diameter=cd, cylinder_height=ch, coutout_depth=c_depth, orientation=c_orientation, chamfer=c_chamfer);
                }
            }
            gridfinityBase([gridx, gridy], grid_dimensions=grid_dimensions, hole_options=hole_options, only_corners=only_corners || half_grid, thumbscrew=enable_thumbscrew);
        }

    }

    polyhedron(points=[[13,0,-22],[-13,0,-22],[-13, 8,-22],[13,8,-22],[15,-2,0],[-15,-2,0],[-15, 10,0],[15,10,0]],
        faces=[
          [0,1,2,3],  // bottom
          [4,5,1,0],  // front
          [7,6,5,4],  // top
          [5,6,2,1],  // right
          [6,7,3,2],  // back
          [7,4,0,3] 
        ]    
      );
   polyhedron(points=[[15,-2,0],[-15,-2,0],[-15, 10,-0],[15,10,0],[16,-3,1],[-16,-3,1],[-16, 11,1],[16,11,1]],
        faces=[
          [0,1,2,3],  // bottom
          [4,5,1,0],  // front
          [7,6,5,4],  // top
          [5,6,2,1],  // right
          [6,7,3,2],  // back
          [7,4,0,3] 
        ]    
      );

    translate([0,-95,0]) {
        rotate([-90,0,0]) {
            cylinder(96, 6, 5);
        }
        sphere(6);
        cylinder(1, 6, 7);
    }
    translate([0,1,0])
        polyhedron(points=[[5,0,0],[-5,0,0],[-6, -96,0],[6,-96,0],[6,0,1],[-6,0,1],[-7, -96,1],[7,-96,1]],
        faces=[
          [0,1,2,3],  // bottom
          [4,5,1,0],  // front
          [7,6,5,4],  // top
          [5,6,2,1],  // right
          [6,7,3,2],  // back
          [7,4,0,3] 
        ]    
      );
    
    translate([0,-50,10])
        roundedcube([34,80, 40], center=true, radius = 7);
    translate([10,-17,0])
        cylinder(1, 7, 8);
    translate([-10,-17,0])
        cylinder(1, 7, 8);
    translate([10,-83,0])
        cylinder(1, 7, 8);
    translate([-10,-83,0])
        cylinder(1, 7, 8);
    polyhedron(points=[[10,-10,0],[-10,-10,0],[-10, -90,0],[10,-90,0],[11,-9,1],[-11,-9,1],[-11, -91,1],[11,-91,1]],
        faces=[
          [0,1,2,3],  // bottom
          [4,5,1,0],  // front
          [7,6,5,4],  // top
          [5,6,2,1],  // right
          [6,7,3,2],  // back
          [7,4,0,3] 
        ]    
      );
      polyhedron(points=[[17,-17,0],[-17,-17,0],[-17, -83,0],[17,-83,0],[18,-16,1],[-18,-16,1],[-18, -84,1],[18,-84,1]],
        faces=[
          [0,1,2,3],  // bottom
          [4,5,1,0],  // front
          [7,6,5,4],  // top
          [5,6,2,1],  // right
          [6,7,3,2],  // back
          [7,4,0,3] 
        ]    
      );
    
    
        
    

}