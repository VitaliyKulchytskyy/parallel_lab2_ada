with ParallelMin;

package body ParallelMin is
    procedure Setup (In_Array : in Random_Array; Thread_Num : Positive) is
    begin
        ParallelMin.In_Array   := new Random_Array'(In_Array);
        ParallelMin.Thread_Num := Thread_Num;
    end Setup;

    protected body Parallel_Handler is
        procedure Set_Min_Index (min : Positive) is
        begin
            if In_Array (min) < In_Array (Parallel_Handler.min_index) then
                Parallel_Handler.min_index := min;
            end if;

            Parallel_Handler.thread_count := Parallel_Handler.thread_count + 1;
        end Set_Min_Index;

        entry Get_Min_Index (min : out Positive) when thread_count = Thread_Num
        is
        begin
            min := Parallel_Handler.min_index;
        end Get_Min_Index;
    end Parallel_Handler;

    task body Seek_Thread is
        min                    : Integer := 1;
        Start_Index, End_Index : Integer := 1;
    begin
        accept Seek (Start_Index, End_Index : Positive) do
            Seek_Thread.Start_Index := Start_Index;
            Seek_Thread.End_Index   := End_Index;
        end Seek;

        Seek_Thread.min := Get_Min_Index (Start_Index, End_Index);
        Parallel_Handler.Set_Min_Index (Seek_Thread.min);
    end Seek_Thread;

    function Find_Min_Index return Positive is
        output  : Positive := 1;
        threads : array (1 .. Thread_Num) of Seek_Thread;
        step    : Positive := Integer (In_Array'Length / Thread_Num);
    begin
        if Thread_Num - 1 > 0 then
            for I in 1 .. Thread_Num - 1 loop
                threads (I).Seek (step * (I - 1) + 1, step * I);
            end loop;
        end if;
        threads (Thread_Num).Seek
           (step * (Thread_Num - 1) + 1, In_Array'Length);

        Parallel_Handler.Get_Min_Index (output);

        return output;
    end Find_Min_Index;

    function Get_Min_Index (Start_Index, End_Index : Positive) return Positive
    is
        output : Positive := Start_Index;
    begin
        for I in Start_Index .. End_Index loop
            if In_Array (I) < In_Array (output) then
                output := I;
            end if;
        end loop;

        return output;
    end Get_Min_Index;

end ParallelMin;
