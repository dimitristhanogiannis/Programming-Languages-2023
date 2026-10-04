fun fairseq' [] = 0  
  | fairseq' [a] = a
  | fairseq' sequence =
    let
        val n = length sequence
        val total_sum = foldl op+ 0 sequence
        fun min (x, y) = if x < y then x else y
        
        fun find_min_diff [] _ _ min_diff = min_diff  
          | find_min_diff _ [] _ min_diff = min_diff  
          | find_min_diff left right current_sum min_diff =
            let
                val diff = abs(total_sum - 2 * current_sum)
                val min_diff' = min(min_diff, diff)
            in
                if current_sum < total_sum div 2 andalso not (null right) then
                    find_min_diff left (tl right) (current_sum + hd right) min_diff'
                else if not (null left) then
                    find_min_diff (tl left) right (current_sum - hd left) min_diff'
                else
                    min_diff'
            end
        val initial_diff = abs(total_sum - 2 * hd sequence)
    in
        find_min_diff sequence (tl sequence) (hd sequence) initial_diff
    end


fun parse filename =
    let
        fun readInt input = Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
        val file = TextIO.openIn filename
        val n = readInt file
        val _ = TextIO.inputLine file
        fun readInts 0 acc = acc
          | readInts i acc = readInts (i-1) (readInt file :: acc)
        val sequence = readInts n []
    in
        fairseq' sequence
    end

fun fairseq filename =
    let
        val result = parse filename
        val stringResult = Int.toString result
    in
        print (stringResult ^ "\n")
    end

val _ =
    if CommandLine.arguments() <> [] then fairseq (hd (CommandLine.arguments()))
    else ()
