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