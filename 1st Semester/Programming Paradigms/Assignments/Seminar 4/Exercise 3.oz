declare
Cnt={NewCell 0}
fun {NewId}
   Cnt:=@Cnt+1
   {String.toAtom {Append "id<" {Append {Int.toString @Cnt} ">"}}}
end

declare
fun {Rename_aux Expression Environment}
   if {IsAtom Expression} then 
      if {IsMember Environment Expression} then {Fetch Environment Expression} 
      else Expression 
      end
   else
   case Expression of
   nil then nil
   
   [] apply(Expression1 Expression2) then 
         apply({Rename_aux Expression1 Environment} {Rename_aux Expression2 Environment})
   
   [] lam(ID Ex) then
         if {IsMember Environment ID} then lam({Fetch Environment ID} {Rename_aux Ex Environment})
         else
            local Envs in
               Envs = {Adjoin Environment ID#{NewId}}
               lam({Fetch Envs ID} {Rename_aux Ex Envs})
            end
         end  
   
   [] let(ID#Expression1 Expression2) then
         if {IsMember Environment ID} then
            let({Fetch Environment ID}#{Rename_aux Expression1 Environment} {Rename_aux Expression2 Environment})
         else
            local Envs in
               Envs = {Adjoin Environment ID#{NewId}}
               let({Fetch Envs ID}#{Rename_aux Expression1 Envs} {Rename_aux Expression2 Envs})
            end
         end  
   end
   end
end

fun {Rename E}
   {Rename_aux E nil}
end


% Tests

{Browse {Rename lam(z lam(x z))} == lam('id<1>' lam('id<2>' 'id<1>'))}
{Browse {Rename let(id#lam(z z) apply(id y))} == let('id<3>'#lam('id<4>' 'id<4>') apply('id<3>' y))}