declare
fun {ReplaceIn Expression ID NewId}
   case Expression of 
   nil then Expression
   
   [] let(Left#Right Result) then
        let({ReplaceIn Left ID NewId}#{ReplaceIn Right ID NewId} {ReplaceIn Result ID NewId})
   
   [] lam(T Body) then
        lam({ReplaceIn T ID NewId} {ReplaceIn Body ID NewId})
   
   [] apply(Left Right) then
        apply({ReplaceIn Left ID NewId} {ReplaceIn Right ID NewId})
   
   [] T then 
        if T == ID then NewId 
        else T 
        end
   end
end

fun {Subs Binding InExpression}
    case Binding of 
    nil then nil
    [] Id#Expression then
        {ReplaceIn {Rename InExpression} Id Expression}
    end
end


% Tests

{Browse {Subs x#lam(x x) apply(x y)} == apply(lam(x x) y)}
{Browse {Subs x#lam(z z) apply(x lam(x apply(x z)))} == apply(lam(z z) lam('id<5>' apply('id<5>' z)))}