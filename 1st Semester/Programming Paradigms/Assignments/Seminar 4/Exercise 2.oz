declare
fun {IsMember Environment ID}
   case Environment of
      nil then false
      [] A#B|T then 
            if ID == A then true 
            else {IsMember T ID} 
            end
      end
end


declare
fun {Fetch Environment ID}
   case Environment of
      nil then ID
   []  A#B|T then 
        if ID == A then B 
        else {Fetch T ID} 
        end
   end
end


declare
fun {Adjoin_aux Environment Expression}
   case Environment of
      nil then nil
   [] A#B|T then
      case Expression of
        X#Y then 
            if A == X then {Adjoin_aux T Expression}
            else (A#B)|{Adjoin_aux T Expression} 
            end
        end	 
   end
end

fun {Adjoin Environment Expression}
   Expression | {Adjoin_aux Environment Expression}
end


% Tests

{Browse {IsMember [a#e1 b#y c#e3] c} == true}
{Browse {IsMember [a#e1 b#y c#e3] y} == false}

{Browse {Fetch [a#e1 b#y c#e3] c} == e3}
{Browse {Fetch [a#e1 b#y c#e3] d} == d}

{Browse {Adjoin [a#e1 b#y c#e3] c#e4} == [c#e4 a#e1 b#y]}
{Browse {Adjoin [a#e1 b#y c#e3] d#e4} == [d#e4 a#e1 b#y c#e3]}