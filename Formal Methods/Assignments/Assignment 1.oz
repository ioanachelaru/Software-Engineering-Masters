/*Write a function Abs that computes the absolute value of a number.
  This should work for both integersandrealnumbers. */

declare
fun {MyAbs X}
    local Y B in
        % checks if X is Float
        B = {IsFloat X}
        if B == true then
            % converts it to Integer
            Y = {FloatToInt X}
        else Y=X
        end

        if Y < 0 then ~X
        else X
        end
    end
end 

% test cases
{Browse {MyAbs 2}}
{Browse {MyAbs ~2}}
{Browse {MyAbs 2.23}}
{Browse {MyAbs ~2.23}}


/*Computenmwhere n^m where n is an integer
 and m is a natural number*/

declare
fun {MyPow N M}
 if M == 0 then 1
else N * {MyPow N M-1}
end
end

% test cases
{Browse {MyPow 2 3}}
{Browse {MyPow ~2 3}}


/*Compute the maximum of two natural numbers,
 knowing that the only allowed test with a conditional
 is the test whether a number is zero.
 */

declare
fun{MaxRec N M C}
    if N == 0 then M + C
    else if M == 0 then N + C
        else {MaxRec N-1 M-1 C+1}
        end
    end
end

% test cases
{Browse {MaxRec 34 56 0}}
{Browse {MaxRec 32 0 0}}
