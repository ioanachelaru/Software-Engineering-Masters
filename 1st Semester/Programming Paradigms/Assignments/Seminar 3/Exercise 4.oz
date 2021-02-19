declare
fun {Position_aux List Element Acc}
    case List of
    nil then 0
    [] H|T then 
        if H == Element then Acc
        else {Position_aux T Element (Acc+1)}
	    end
   end
end

fun {Position List Element}
    {Position_aux List Element 1}
end

% Tests
{Browse {Position [1 2 3] 2} == 2}
{Browse {Position [1 2 3] 5} == 0}