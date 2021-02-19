declare
fun {Take List Nr}
    case List of
    nil then nil
    [] H|T then
        if Nr > 0 then H|{Take T Nr-1}
        else nil
        end
    end
end

fun {Drop List Nr}
    case List of
    nil then nil
    [] H|T then
        if Nr > 0 then {Drop T Nr-1}
        else H|{Drop T Nr}
        end
    end
end

fun {Drop2 List Nr}
    if Nr == 0 then List
    else 
        case List of
            nil then nil
            [] H|T then {Drop T Nr-1}
        end
    end
end

% Tests

{Browse {Take [a b c d] 2} == [a b]}

{Browse {Drop [a b c d] 2} == [c d]}
{Browse {Drop2 [a b c d] 2} == [c d]}