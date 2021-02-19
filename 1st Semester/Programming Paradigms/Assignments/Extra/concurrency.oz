% First program
declare X0 X1 X2 X3

thread X1 = 1 + X0 end
thread X3 = X1 + X2 end

{Browse [X0 X1 X2 X3]}
X0 = 4
X2 = 2


% Example of Runnable Threads
thread {Delay 100} 
    for X in 1..100 do {Browse X} end 
end
thread 
    for Y in 100..200 do {Browse Y} end 
end


% Dataflow computation
declare X
{Browse X}
local Y in 
    thread {Delay 1000} Y = 10*10 end
    X = Y + 100*100
end


declare
fun {Double Xs}
   case Xs of
      nil then nil
   [] X|Xr then 2*X|{Double Xr}
   end
end
Ys = {Double [1 2 3]}
{Browse Ys}


declare F
fun {CMap Xs F}
   case Xs
   of nil then nil
   [] X|Xr then thread {F X} end | {CMap Xr F}
   end
end
{Browse {CMap [1 2 3 4] F}}
F = fun {$ X} X+1 end


% Cheap concurrency and data flow
declare
fun {Fib X}
   case X of
      0 then 0
   [] 1 then 1
   [] X then thread {Fib X-1} end + {Fib X-2}
   end
end

% test
{Browse {Fib 6}}



% make consumer be the driver
declare
fun {DConsume ?Xs A Limit}
    if Limit > 0 then
        local X Xr in
            Xs = X|Xr {DConsume Xr A+X Limit}
        end
    else A
    end
end

declare
fun {DProduce N Xs}
    case Xs of
    X|Xr then X=N {DProduce N+1 Xr}
    end
end

local Xs S in
    thread Xs = {DProduce 0 Xs} end
    thread S = {DConsume Xs 0 15} end
    {Browse S}
end


%%%%%%%% AGENTS %%%%%%%%%

declare
local Stream MP Sum Product in

   proc {Evaluate Expr}
      case Expr
      of add(L R Result) then Result = L + R
      [] times(L R Result) then Result = L * R
      end
   end

   MP = {NewPort Stream}
   thread {ForAll Stream Evaluate} end
   thread {Send MP add(2 4 Sum)} end
   thread {Send MP times(3 4 Product)} end
   {Browse Sum#Product}
end


%%%%%%%%%% COMBINATIONS %%%%%%%%%%%%%%%%%%%

declare

fun {OnComb N K Index Prev}
   if (Index >= K) then Prev
   else R A B in
      A = (Prev div (Index + 1)) * (N - Index)
      B = (Prev mod (Index + 1)) * (N - Index)
      R = A + (B div (Index + 1))
      {OnComb N K Index + 1 R}
   end
end

fun {Comb N K}
   if K < (N - K) then {OnComb N K 0 1}
   else {OnComb N (N - K) 0 1} end
end


fun {Combinations N K}
   if {Or (N == K) (K == 0)} then 1
   else {Combinations N - 1 K - 1} + {Combinations N - 1 K}
   end
end

{Browse {Comb 30 5}}


%%%%%%%%%%%%% RELATIONAL %%%%%%%%%%%%%%%%%%%

declare
fun {Digit}
   choice 0 [] 1 [] 2 [] 3 [] 4 [] 5 [] 6 [] 7 [] 8 [] 9 end
end

fun {TwoDigitsNumber}
   10 * {Digit} + {Digit}
end

{Browse {SearchAll Digit}}


%%%%%%%%%%%%%% SERVER %%%%%%%%%%%%%%%%%%

declare
proc {ServerAction Message}
   case Message of 
   double(X Result) then Result = X * 2
   [] sum(Z Y R) then R = Z + Y
   end
end

fun {NewAgent Process} Port Stream in
   Port = {NewPort Stream}
   thread {ForAll Stream Process} end
   Port
end

Server = {NewAgent ServerAction}

proc {ClientAction Message}
   case Message of 
   calculate(Result) then {Send Server double(2 Result)}
   [] add(X Y R) then {Send Server sum(X Y R)}
   end
end

Client = {NewAgent ClientAction}

local R R2 in
   {Send Client calculate(R)}
   {Browse R}
   {Send Client add(3 4 R2)}
   {Browse R2}
end


%%%%%%%%%%%%%%%%%% STACK %%%%%%%%%%%%%%%%%%%%

declare
fun {NewStack}
   stack(values: nil)
end

fun {Push N Stack}
   case Stack
   of nil then stack(values: N)
   [] stack(values: V) then stack(values: N|V)
   end
end

fun {Pop Stack}
   case Stack
   of nil then nil # nil
   [] stack(values: H|T) then H # stack(values: T)
   end
end

fun {IsEmpty Stack}
   case Stack
   of nil then true
   [] stack(values: nil) then true
   [] _ then false end
end

% tests
declare R1 R2
InitStack = {Push 5 {Push 4 {NewStack}}}
thread R1 # NewStack = {Pop InitStack} end
thread R2 # NewStack = {Pop InitStack} end
{Browse R1#R2}
{Browse InitStack}


%%%%%%%%%%%%%%%%%% STREAMS %%%%%%%%%%%%%%%%%%%%

% producer - consumer
% suma numerelor impare din Start-ToLimit

% Foldl - used for folding the elements of Xs by applying a ternary procedure P
declare
fun {From Start ToLimit}
   if Start < ToLimit
   then Start | {From Start + 1 ToLimit}
   else nil end
end

local Stream FilterResult Result in
   thread Stream = {From 0 10} end
   thread FilterResult = {Filter Stream IsOdd} end
   thread Result = {FoldL FilterResult fun {$ X Acc} X + Acc end 0} end
   {Browse Result}
end

declare
fun lazy {Produce N}
   N|{Produce N*2}
end



{Browse {Produce 2}}