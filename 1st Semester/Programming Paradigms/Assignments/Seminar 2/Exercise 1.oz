/* Write a function that computes the number of possible combinations */

declare
fun {Numerator N CopyN K}
   if N < CopyN - K + 1 then 1
   else N * {Numerator N - 1 CopyN K}
   end
end


declare
fun {Denominator K}
   if K == 1 then 1
   else K * {Denominator K-1}
   end
end

declare
fun {Comb N K}
   if K == 0 then 1
   else
      {Numerator N N K} div {Denominator K}
   end
end

% Tests
{Browse {Comb 3 0} == 1}
{Browse {Comb 6 1} == 6}
{Browse {Comb 12 4} == 495}



/* Comb2(n, k) = {
    1, k == 0
    n, k == 1
    Comb2(n, k-1) * (n-k+1)/k, otherwise 
}*/

declare
fun {Comb2 N K}
    if K == 0 then 1
    else if K == 1 then N
        else 
            {Comb2 N K-1} * (N-K+1) div K
        end
    end
end

% Tests
{Browse {Comb2 3 0} == 1}
{Browse {Comb2 6 1} == 6}
{Browse {Comb2 12 4} == 495}