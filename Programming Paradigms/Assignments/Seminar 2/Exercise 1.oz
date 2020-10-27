/* Write a function that computes the number of possible combinations */

/* Comb(n, k) = {
    1, k == 0
    n, k == 1
    n * Comb(n, k) / k, otherwise 
} */

declare
fun {Comb N K}
    if K == 0 then 1
    else
        if K == 1 then N
        else N * {Comb N-1 K-1} div K
        end
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