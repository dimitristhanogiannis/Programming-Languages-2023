fun powerset [] = [[]]
  | powerset (h :: t) = powerset t @ map (fn x => h :: x) (powerset t)

fun powerset1 [] = [[]]
  | powerset1 (h :: t) =
      let 
        val powerset_of_t = powerset1 t
      in 
        map (fn x => h :: x) powerset_of_t @ powerset_of_t
      end 

fun powerset2 [] = [[]]
  | powerset2 (h :: t) = foldl (fn(x,acc) => x :: (h :: x) :: acc) [] (powerset t)