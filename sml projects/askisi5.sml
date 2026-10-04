datatype 'a tree = Empty | Node of 'a * 'a tree * 'a tree

fun leaves Empty list = list
  | leaves (Node (x, Empty, Empty)) list = x :: list
  | leaves (Node (x, left, Empty)) list = leaves left list 
  | leaves (Node (x, Empty, right)) list = leaves right list
  | leaves (Node (x, left, right)) list = leaves left (leaves right (list))

(* Function to create a sample tree *)
fun sampleTree () =
    Node (1,
          Node (2,
                Node (4, Empty, Empty),
                Node (5, Empty, Empty)),
          Node (3,
                Node (6, Empty, Empty),
                Node (7, Empty, Empty)))

(* Function to test the leaves function with a sample tree *)
fun testLeaves () =
    let
        val tree = sampleTree ()
    in
        leaves tree []
    end

(* Test the leaves function *)
val result = testLeaves ()
