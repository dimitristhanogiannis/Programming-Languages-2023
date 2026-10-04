fun hanoi 0 _ _ _ = ()
  | hanoi n source target middle = 
    let 
        val () = hanoi (n-1) source middle target
        val () = print ("Move disk from " ^ source ^ " to " ^ target ^ "\n")
        val () = hanoi (n-1) middle target source 
    in
        ()
    end