with Ada.Numerics.Discrete_Random;

package Random is
    subtype Rand_Range is Positive;
    type Random_Array is array (Positive range <>) of Integer;

    function Get_Rnd_Value return Rand_Range;
    procedure Generate_Rnd_Array (arr : out Random_Array);
    procedure Setup;

private
    package Rand_Int is new Ada.Numerics.Discrete_Random (Rand_Range);
    gen : Rand_Int.Generator;
end Random;
