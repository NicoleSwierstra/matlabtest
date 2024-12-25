classdef Battery
    properties
        MaxVoltage
        NomVoltage
        MinVoltage
        Resistance
        MaxCurrent
        MaxCharge
        CellMass
    end
    methods
        function bat = Battery(celltype, parallel, series)
            bats = readtable("CellDefs.xlsx");
            c_row = 1;
            for i = 1:1:height(bats)
                cellname = bats.('Cellname')(i);
                if strcmp(cellname, celltype)
                    c_row = i;
                    disp(cellname)
                end
            end

            n_cells = parallel * series;
            disp(n_cells);

            bat.CellMass   = n_cells * bats.('Mass')(c_row);
            bat.MaxVoltage = series  * bats.('MaxVoltage')(c_row); 
            bat.NomVoltage = series  * bats.('NomVoltage')(c_row);
            bat.MinVoltage = series  * bats.('MinVoltage')(c_row);
            bat.Resistance = series  * bats.('Resitance')(c_row) / parallel;
            bat.MaxCurrent = parallel * bats.('Ampacity')(c_row) * bats.('Crate')(c_row);
            bat.MaxCharge  = series  * bats.('Ampacity')(c_row) * bats.('NomVoltage')(c_row);
        end
    end
end