with Random;      use Random;
with CliParser;   use CliParser;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;

package ParallelMin is
    procedure Setup (In_Array : in Random_Array; Thread_Num : Positive);
    function Find_Min_Index return Positive;

private
    protected Parallel_Handler is
        procedure Set_Min_Index (min : Positive);
        entry Get_Min_Index (min : out Positive);
    private
        min_index    : Positive := 1;
        thread_count : Integer  := 0;
    end Parallel_Handler;

    task type Seek_Thread is
        entry Seek (Start_Index, End_Index : Positive);
    end Seek_Thread;

    function Get_Min_Index (Start_Index, End_Index : Positive) return Positive;

    In_Array   : access Random_Array;
    Thread_Num : Positive := 1;

end ParallelMin;
