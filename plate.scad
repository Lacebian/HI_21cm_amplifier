$fn = 32;

plate_width = 218;
plate_height = 129;
plate_thickness = 2;

lna_width = 45;
lna_height = 25;
lna_screw_width = 39;
lna_screw_height = 19;

zrl_width = 95.25;
zrl_height = 50.8;
zrl_thickness = 20.32;

zrl_screw_g = 41.25;
zrl_screw_f = 85.7;

filter_width = 85;
filter_height = 27;

pwr_width = 65;
pwr_height = 38;
pwr_screw_height = 32;
pwr_screw_width = 58;

amp_screw_width = 45;
amp_screw_height = 45;
amp_width = amp_screw_width + 10;
amp_height = amp_screw_height + 10;

module plate(w, h, t, x0 = 0, y0 = 0)
{
    translate([ 0, 0, -t ])
    {
        cube(size = [ w, h, t ]);
    }
}

module screw2x2(w, h, d, depth)
{
    for (dx = [ -1, 1 ])
    {
        for (dy = [ -1, 1 ])
        {
            translate([ dx * (w / 2), dy * h / 2, -depth ])
            {
                cylinder(h = depth, d = d);
            }
        }
    }
}

module lna()
{
    translate(v = [ -lna_width / 2, -lna_height / 2, 0 ])
    {
        cube(size = [ lna_width, lna_height, 12 ]);
    }

    screw2x2(w = lna_screw_width, h = lna_screw_height, d = 3.5, depth = 5);
    // translate(v = [ 0, 0, 12 / 2 ]) rotate(a = 90, v = [ 0, 1, 0 ]) cylinder(h = 39 + 6 + 11 * 2, d = 5, center =
    // true);
}

module filter()
{
    translate(v = -[ filter_width / 2, filter_height / 2, 0 ]) cube(size = [ filter_width, filter_height, 17 ]);
    screw2x2(w = 56, h = 20, d = 3.5, depth = 5);
}

module zrl()
{
    translate(v = -[ zrl_width / 2, zrl_height / 2, 0 ]) cube(size = [ zrl_width, zrl_height, zrl_thickness ]);
    screw2x2(w = zrl_screw_f, h = zrl_screw_g, d = 3.5, depth = 5);
}

module pwr()
{
    translate(v = -[ pwr_width / 2, pwr_height / 2, 0 ]) cube(size = [ pwr_width, pwr_height, 10 ]);
    screw2x2(w = pwr_screw_width, h = pwr_screw_height, d = 3.5, depth = 5);
}

module amp()
{
    translate(v = -[ amp_width / 2, amp_height / 2, 0 ]) cube(size = [ amp_width, amp_height, 10 ]);
    screw2x2(w = amp_screw_width, h = amp_screw_height, d = 3.5, depth = 5);
}

// lna();
difference()
{
    plate(plate_width, plate_height, plate_thickness);

    translate(v = [ plate_width - lna_width / 2 - 2, plate_height - lna_height / 2 - 5, 0.1 ]) lna();

    translate(v = [ 80, plate_height - lna_height / 2 - 5, 0.1 ]) filter();

    translate(v = [ zrl_width / 2 + 20, 70, 0.1 ]) zrl();

    translate(v = [ pwr_screw_width / 2 + 50, pwr_height / 2 + 4, 0.1 ]) pwr();

    translate(v = [ 0, 10, -5 ]) cube(size = [ 10, plate_height - 20, 10 ]);

    translate(v = [ amp_width / 2 + 50, 70, 0.1 ])
    {
        amp();
    }

    translate([ 160, 70, -5 ])
    {
        cylinder(h = 20, r = 10);
    }

    translate([ 30, 70, -5 ])
    {
        cylinder(h = 20, r = 10);
    }
}