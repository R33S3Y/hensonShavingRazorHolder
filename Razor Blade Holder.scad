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
        translate([-20.75,-((42*4)-0.5)/2,5])
            roundedcube([41.5,(42*4)-0.5,22], radius = 3.75, apply_to = "z");
    }
        translate([0, 0,0]) {
            gridy = 4;
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
    L = 155;
    polyhedron(points=[[14,-L/2,6],[-14,-L/2,6],[-14, L/2,6],[14,L/2,6],[15,(-L/2)-2,26],[-15,(-L/2)-2,26],[-15, (L/2)+2,26],[15,(L/2)+2,26]],
        faces=[
          [0,1,2,3],  // bottom
          [4,5,1,0],  // front
          [7,6,5,4],  // top
          [5,6,2,1],  // right
          [6,7,3,2],  // back
          [7,4,0,3] 
        ]    
      );
 
   polyhedron(points=[[15,(-L/2)-2,26],[-15,(-L/2)-2,26],[-15, (L/2)+2,26],[15,(L/2)+2,26],[16,(-L/2)-3,27],[-16,(-L/2)-3,27],[-16, (L/2)+3,27],[16,(L/2)+3,27]],
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