with Parse_Args;  use Parse_Args;
with Ada.Text_IO; use Ada.Text_IO;
with Parse_Args.Integer_Array_Options;

package CliParser is
    AP : Argument_Parser;
    Parse_Usage, Parse_Exception, Parse_Manual_Index_Error : exception;

    procedure Setup;
    procedure Parse;

    function Get_Length return Positive;
    function Get_Thread_Num return Integer;
    function Get_Minimal_Index return Integer;
    function Is_Verbose return Boolean;

private
    Length        : Positive;
    Thread_Num    : Integer;
    Minimal_Index : Integer;

end CliParser;
