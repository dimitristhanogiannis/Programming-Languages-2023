fun minbases' nums =
    let
        fun toBase(n, base) =
            let
                fun toBaseHelper(n, base, acc) =
                    if n < base then
                        n :: acc
                    else
                        toBaseHelper(n div base, base, n mod base :: acc)
            in
                List.rev (toBaseHelper(n, base, []))
            end
        
        fun checkBase(num, base) =
            let
                val digits = toBase(num, base)
            in
                if List.all (fn x => x = hd digits) (tl digits) then
                    base
                else
                    checkBase(num, base + 1)
            end
        
    in
        List.map (fn x => checkBase(x, 2)) nums
    end

fun parse filename =
    let
        fun readInt input = Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
        val file = TextIO.openIn filename
        val n = readInt file
        val _ = TextIO.inputLine file
        fun readInts 0 acc _ = acc
          | readInts i acc insertion =
            let
                val line = TextIO.inputLine insertion
                val num = case line of
                    SOME str => Option.valOf (Int.fromString str)
                  | NONE => raise Fail "Error reading integer from file"
            in
                readInts (i-1) (num :: acc) insertion
            end
        val sequence = readInts n [] file
    in
        minbases' sequence
    end

fun minbases filename =
    let
        val result = parse filename
        val reversedResult = List.rev result
        val stringResult = String.concatWith "\n" (List.map Int.toString reversedResult)
    in
        print (stringResult ^ "\n")
    end

val _ =
    if CommandLine.arguments() <> [] then minbases (hd (CommandLine.arguments()))
    else ()


(*fun minbases nums =
    let
        fun toBase(n, base) =
            if n < base then
                [n]
            else
                (toBase(n div base, base)) @ [n mod base]
        
        fun checkBase(num, base) =
            let
                val digits = toBase(num, base)
            in
                if List.all (fn x => x = hd digits) (tl digits) then
                    base
                else
                    checkBase(num, base + 1)
            end
        
    in
        List.map (fn x => checkBase(x, 2)) nums
    end
*)
(*
fun minbases nums =
    let
        fun toBase(n, base) =
            let
                fun toBaseHelper(n, base, acc) =
                    if n < base then
                        n :: acc
                    else
                        toBaseHelper(n div base, base, n mod base :: acc)
            in
                List.rev (toBaseHelper(n, base, []))
            end
        
        fun checkBase(num, base) =
            let
                val digits = toBase(num, base)
            in
                if List.all (fn x => x = hd digits) (tl digits) then
                    base
                else
                    checkBase(num, base + 1)
            end
        
    in
        List.map (fn x => checkBase(x, 2)) nums
    end
*)
