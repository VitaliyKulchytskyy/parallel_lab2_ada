with Ada.Exceptions; use Ada.Exceptions;
with Ada.Text_IO;    use Ada.Text_IO;
with CliParser;      use CliParser;
with Random;         use Random;
with ParallelMin;    use ParallelMin;


procedure Lab2 is
begin
    CliParser.Setup;
    CliParser.Parse;
    Random.Setup;

    declare
        Rnd_Arr   : Random_Array (1 .. CliParser.Get_Length);
        Rnd_Index : Positive := (Get_Rnd_Value mod CliParser.Get_Length) + 1;
    begin
        Generate_Rnd_Array (Rnd_Arr);

        if CliParser.Get_Minimal_Index > 0 then
            Rnd_Index := CliParser.Get_Minimal_Index;
        end if;

        Rnd_Arr (Rnd_Index) := -10;

        if Is_Verbose then
            Put_Line ("Defined min index: " & Rnd_Index'Img);
            Put_Line ("");
        end if;

        -- for I in Rnd_Arr'Range loop
        --      Put_Line ("[" & I'Img & "]: " & Rnd_Arr (I)'Img);
        -- end loop;

        ParallelMin.Setup (Rnd_Arr, CliParser.Get_Thread_Num);
        Put_Line ("Answer: " & ParallelMin.Find_Min_Index'Img);
    end;

exception
    when e : Parse_Exception =>
        Put_Line (Exception_Message (e));
    when er : Parse_Manual_Index_Error =>
        Put_Line (Exception_Message (er));
    when Parse_Usage         =>
        AP.Usage;

end Lab2;
