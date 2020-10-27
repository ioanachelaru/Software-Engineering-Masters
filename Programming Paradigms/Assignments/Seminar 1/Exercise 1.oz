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