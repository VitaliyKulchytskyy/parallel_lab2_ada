with Random;

package body Random is
    function Get_Rnd_Value return Rand_Range is
    begin
        return Rand_Int.Random (gen);
    end Get_Rnd_Value;

    procedure Generate_Rnd_Array (arr : out Random_Array) is
        I : Integer := 0;
    begin
        for I in arr'Range loop
            arr (I) := Get_Rnd_Value;
        end loop;
    end Generate_Rnd_Array;

    procedure Setup is
    begin
        Rand_Int.Reset (gen);
    end Setup;
end Random;
