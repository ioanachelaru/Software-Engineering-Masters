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