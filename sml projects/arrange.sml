datatype tree = Empty | Node of int * tree * tree

fun toTree [] = Empty
  | toTree (h :: t) = 
    let
      val (left, rest) = buildLeftSubtree t
      val (right, remaining) = buildRightSubtree rest
    in
      Node (h, left, right)
    end

and buildLeftSubtree [] = (Empty, [])
  | buildLeftSubtree (0 :: t) = (Empty, t)
  | buildLeftSubtree (h :: t) = 
    let
      val (left, remaining) = buildLeftSubtree t
      val (right, rest) = buildRightSubtree remaining
    in
      (Node (h, left, right), rest)
    end

and buildRightSubtree [] = (Empty, [])
  | buildRightSubtree (0 :: t) = (Empty, t)
  | buildRightSubtree (h :: t) = 
    let
      val (left, remaining) = buildLeftSubtree t
      val (right, rest) = buildRightSubtree remaining
    in
      (Node (h, left, right), rest)
    end

fun  swap Empty = Empty
  |  swap (Node (data, left, right)) = Node (data, right, left)

fun arrange' Empty = []
  | arrange' (Node (0, _, _)) = []
  | arrange' (Node (data, left, right)) =
    let
      val v1 = arrange' left
      val v2 = arrange' right
      fun concat ([], lst) = lst
        | concat (h :: t, lst) = h :: concat (t, lst)

    in
      if v1 <> [] andalso v2 <> [] andalso hd v2 < hd v1 then
        let
          val swapped = swap (Node (data, left, right))
        in
          concat (v2,(data :: v1))
        end
      else if v1 = [] andalso v2 <> [] andalso hd v2 < data then
        let
          val swapped = swap (Node (data, left, right))
        in
          concat (v2,(data :: v1))
        end
      else if v2 = [] andalso v1 <> [] andalso hd v1 > data then
        let
          val swapped = swap (Node (data, left, right))
        in
          concat (v2,(data :: v1))
        end
      else
        concat (v1,(data :: v2))
    end

fun parse filename =
    let
        fun readInt input = Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
        val file = TextIO.openIn filename
        val n = readInt file
        val _ = TextIO.inputLine file

        fun readIntsFromString str =
            let
        fun parseString [] = []
          | parseString (h :: t) =
            (case Int.fromString h of
                 SOME i => i :: parseString t
               | NONE => parseString t)
            in
        parseString (String.tokens Char.isSpace str)
            end

        fun readLineInts () =
            case TextIO.inputLine file of
                 NONE => []  
              | SOME line => readIntsFromString line

        val integers = readLineInts ()
        val tree = toTree integers
    in
        TextIO.closeIn file;
        arrange' tree
    end

fun arrange filename =
    let
        val result = parse filename
        fun output [] = ()
          | output (h :: t) = (
                print (Int.toString h ^ " ");
                output t
            )
        val _ = output result
    in
      if CommandLine.arguments() <> [] then arrange (hd (CommandLine.arguments()))
      else ()
    end
