/* Consider a BST of the following form:
    <BTree> ::= leaf(<Int>) | node(<Int>, <BTree>, <BTree>)
*/

% Insertions of new value in BST
declare

proc {Preorder X}
   if X \= nil then {Browse X.value}
      if X.left \= nil then {Preorder X.left} end
      if X.right \= nil then {Preorder X.right} end
   end
end

fun {Insert R N}
   if R == nil then node(value:N left:nil right:nil)
   else if N < R.value then node(value:R.value left:{Insert R.left N} right:R.right)
	else
	   node(value:R.value left:R.left right:{Insert R.right N})
	end
   end
end

% Return smallest value in BST
fun {Smallest R}
   if R == nil then false
   else if R.left == nil then R.value
	else {Smallest R.left}
	end
   end
end

% Return largest value BST
fun {Biggest R}
   if R == nil then false
   else if R.right == nil then R.value
	else {Biggest R.right}
	end
   end
end

% Checks if the given tree is sorted
fun {IsSortedBST R}
   if R == nil then true
   else if {Smallest R} > R.value then false
	else if {Biggest R} < R.value then false
	     else if {And {IsSortedBST R.left} {IsSortedBST R.right}} then true
		  else false
		  end
	     end
	end
   end
end

declare

R = node(value:5 left:X1 right:X2)
X1 = node(value:3 left:nil right:nil)
X2 = node(value:6 left:nil right:nil)

T = node(value:2 left:T1 right:T2)
T1 = node(value:3 left:nil right:nil)
T2 = node(value:6 left:nil right:nil)

% Tests

{Browse 'Visualize tree'}
{Preorder R}

A = {Insert R 4}

{Browse 'Visualize tree after insertion'}
{Preorder A}

{Browse 'Smallest A'}
{Browse {Smallest A}}

{Browse 'Biggest A'}
{Browse {Biggest A}}

{Browse 'A is Sorted'}
{Browse {IsSortedBST A}}

{Browse 'Visualize T'}
{Browse T}

{Browse 'T is Sorted'}
{Browse {IsSortedBST T}}