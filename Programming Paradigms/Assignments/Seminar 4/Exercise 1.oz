declare
fun {Append List1 List2}
   case List1 of
      nil then List2
   [] H|T then H|{Append T List2}
   end
end

fun {Member List X}
    case List of 
      nil then false
      [] H|T then 
            if H == X then true 
            else {Member T X} 
            end
      end
end

declare
fun {FreeSet_aux Expression List}
   case Expression of
      apply(Expression1 Expression2) then 
            {Append {FreeSet_aux Expression1 List} {FreeSet_aux Expression2 List}}
      
      [] lam(ID Expression1) then 
            {FreeSet_aux Expression1 ID|List}
      
      [] let(ID#Expression1 Expression2) then 
            {Append {FreeSet_aux Expression1 ID|List} {FreeSet_aux Expression2 ID|List}}
      
      [] ID then
            if {Member List ID} then nil 
            else [ID] 
            end
    end
end

fun {FreeSet Expression}
    {FreeSet_aux Expression nil}
end


% Tests

{Browse {FreeSet apply(x let(x#y x))} == [x y]}
{Browse {FreeSet apply(y apply(let(x#x x) y))} == [y y]}
{Browse {FreeSet lam(x apply(y x))} == [y]}