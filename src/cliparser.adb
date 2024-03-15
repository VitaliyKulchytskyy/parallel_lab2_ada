with CliParser;

package body CliParser is
    procedure Setup is
    begin
        AP.Add_Option
           (Make_Boolean_Option (False), "help", 'h',
            Usage => "Display this help text");
        AP.Add_Option
           (Make_Boolean_Option (False), "verbose", 'v',
            Usage => "Print verbose information");
        AP.Add_Option
           (Make_Integer_Option (1, Min => 1), "thread", 'n',
            Usage => "Set the number of threads");
        AP.Add_Option
           (Make_Positive_Option (1), "length", 'l',
            Usage => "Set length of the array of randomly generated values");
        AP.Add_Option
           (Make_Integer_Option (0, Min => 1), "min-index", 'm',
            Usage => "Manualy set index with a minimal value");
        AP.Set_Prologue ("Lab2");
        AP.Parse_Command_Line;
    end Setup;

    procedure Parse is
    begin
        if AP.Parse_Success and then AP.Boolean_Value ("help") then
            raise Parse_Usage;
        end if;

        if not AP.Parse_Success then
            raise Parse_Exception
               with
               ("Error while parsing command-line arguments: " &
                AP.Parse_Message);
        end if;

        Length        := AP.Integer_Value ("length");
        Thread_Num    := AP.Integer_Value ("thread");
        Minimal_Index := AP.Integer_Value ("min-index");

        if Minimal_Index > Length then
            raise Parse_Manual_Index_Error
               with
               ("Error while parsing command-line arguments: (Array length)=" & Length'Img & " < (Manual min. index)=" &
                Minimal_Index'Img);
        end if;

        if Is_Verbose then
            Put_Line ("Threads:     " & Get_Thread_Num'Img);
            Put_Line ("Arr length:  " & Get_Length'Img);
            if Minimal_Index > 0 then
                Put_Line ("Manual min:  " & Get_Minimal_Index'Img);
            end if;
            Put_Line ("");
        end if;
    end Parse;

    function Get_Length return Positive is
    begin
        return Length;
    end Get_Length;

    function Get_Thread_Num return Integer is
    begin
        return Thread_Num;
    end Get_Thread_Num;

    function Get_Minimal_Index return Integer is
    begin
        return Minimal_Index;
    end Get_Minimal_Index;

    function Is_Verbose return Boolean is
    begin
        return AP.Boolean_Value ("verbose");
    end Is_Verbose;
end CliParser;
