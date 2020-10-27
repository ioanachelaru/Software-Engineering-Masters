declare

fun {Insert R N}
   if R == nil then node(left:nil right:nil val:N)
   else if N < R.val then node(left:{Insert R.left N} right:R.right val:R.val)
	else
	   node(left:R.left right:{Insert R.right N} val:R.val)
	end
   end
end

% ii) smallest
fun {Smallest R}
   if R==nil then false
   else if R.left==nil then R.val
	else {Smallest R.left}
	end
   end
end

% iii) biggest
fun {Biggest R}
   if R==nil then false
   else if R.right==nil then R.val
	else {Biggest R.right}
	end
   end
end

% iv) isSorted
fun {IsSortedBST R}
   if R==nil then true
   else if {Smallest R} > R.val then false
	else if {Biggest R} < R.val then false
	     else if {And {IsSortedBST R.left} {IsSortedBST R.right}} then true
		  else false
		  end
	     end
	end
   end
end


proc {Preorder X}
   if X \= nil then {Browse X.val}
      if X.left \= nil then {Preorder X.left} end
      if X.right \= nil then {Preorder X.right} end
   end
end

declare

R = node(left:X1 right:X2 val:5)
X1 = node(left:nil right:nil val:3)
X2 = node(left:nil right:nil val:6)
T = node(left:T1 right:T2 val:2)
T1 = node(left:nil right:nil val:3)
T2 = node(left:nil right:nil val:6)

A={Insert R 4}

{Browse 'A tree'}
{Browse A}
{Browse 'A preorder'}
{Preorder A}
{Browse 'Smallest A'}
{Browse {Smallest A}}
{Browse 'Biggest A'}
{Browse {Biggest A}}
{Browse 'Is Sorted A'}
{Browse {IsSortedBST A}}
{Browse 'T tree'}
{Browse T}
{Browse 'Is Sorted T'}
{Browse {IsSortedBST T}}