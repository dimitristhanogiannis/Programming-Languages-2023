fun perfect_number x = 
    let 
        fun producer y z = if (y>0 andalso z>0 andalso z mod y = 0) then true  else false;
        fun loop 0 l = l 
          | loop n l = if producer n x then loop(n-1) (n::l) else loop(n-1) l
        fun sum [] = 0 
          | sum (h::t) = h + sum t
    in 
        if x>0 andalso sum (loop (x-1) []) = x then true else false
    end