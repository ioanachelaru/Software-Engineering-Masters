/* Write a definition of a function that revers a list without using append calls */

/* Reverse_helper(l, aux) = {
    aux, l == nil
    h,t = l; Reverse_helper(T, h+aux), default    
} */

declare
fun {Reverse_aux L AUX}
    case L of 
    nil then AUX
    [] H|T then {Reverse_aux T H|AUX}
    end
end

/* Reverse(l) = { Reverse_helper(l, nil) } */

declare
fun {Reverse L}
    {Reverse_aux L nil}
end

% Tests
{Browse {Reverse [1 2 3 4 5]}}