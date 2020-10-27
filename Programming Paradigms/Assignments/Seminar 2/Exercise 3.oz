/* Modify the functions bellow for lazy evaluations.
 Write a function {GetAfter N} that will return the first 
 prime number after a given value */

declare
fun lazy {Sieve L}
   case L of
      nil then nil
   [] H|T then H|{Sieve {Filter T H}}
   end
end

fun lazy {Filter L H}
   case L of
      nil then nil
   [] A|As then
      if (A mod H)==0 then {Filter As H}
      else A|{Filter As H} end
   end
end

fun lazy {Prime} {Sieve {Gen 2}} end

fun lazy {Gen N} N|{Gen N+1} end

fun {ExtractNext N L}
   case L of
      nil then nil
   [] H|T then if (H > N) then H
	       else {ExtractNext  N T}
	       end
   end
end

fun {GetAfter N}
   {ExtractNext N {Prime}}
end

% Tests  
{Browse {GetAfter 10} == 11}
{Browse {GetAfter 3} == 5}
{Browse {GetAfter 13} == 17}