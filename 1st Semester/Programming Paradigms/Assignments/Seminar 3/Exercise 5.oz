declare
fun {Evaluate Expression}
    case Expression of
    int(N) then N
    [] add(X Y) then {Evaluate X} + {Evaluate Y}
    [] mul(X Y) then {Evaluate X} * {Evaluate Y}
    end
end

% Tests
{Browse {Evaluate add(int(1) mul(int(3) int(4)))} == 13}