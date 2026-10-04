fun mergesort [] = []
  | mergesort [x] = [x]
  | mergesort [x,y] = if x < y then [x,y] else [y,x]
  | mergesort list = 
    let
        fun merge ([], ys) = ys
          | merge (xs, []) = xs
          | merge (x::xs, y::ys) = 
                if x < y then x :: merge (xs, y :: ys) 
                else y :: merge (x::xs, ys)

        fun halve nil = (nil, nil)
          | halve [a] = ([a], nil)
          | halve (a::b::cs) =
            let
              val (x, y) = halve cs
            in
              (a::x, b::y)
            end
        val (left, right) = halve list 
    in
        merge (mergesort left, mergesort right)
    end 