declare
fun {FindElement List Element}
    case List of 
    nil then false
    [] H|T then
        if Element == H then true
        else {FindElement T Element}
        end
    end
end

% Tests
{Browse {FindElement [a b c] b} == true}
{Browse {FindElement [a b c] d} == false}
{Browse {FindElement nil b} == false}