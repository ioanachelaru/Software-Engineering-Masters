declare
fun {Zip List1#List2}
    case List1 of
    nil then nil
    [] H|T then
        case List2 of
        nil then nil
        [] H1|T1 then H#H1|{Zip T#T1}
        end
    end
end

declare
fun {Unzip_aux L L1 L2}
   case L of nil then L1#L2
   [] H|T then
      case H of 
      A#B then {Unzip_aux T {List.append L1 [A]} {List.append L2 [B]}}
      end
   end
end

fun {Unzip L}
   {Unzip_aux L nil nil}
end

% Tests
{Browse {Zip nil#[1 2]} == nil}
{Browse {Zip [1 2]#nil} == nil}
{Browse {Zip [a b c]#[a b c]} == [a#a b#b c#c]}

{Browse {Unzip [a#1 b#2 c#3]} == [a b c]#[1 2 3]}
{Browse {Unzip nil} == nil#nil}