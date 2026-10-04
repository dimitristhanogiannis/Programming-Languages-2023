structure Queue = struct
    type 'a queue = 'a list * 'a list
    
    val emptyQueue : 'a queue = ([], [])
    
    fun isEmpty (([], []): 'a queue) = true
      | isEmpty _ = false
    
    fun enqueue (x, (front, rear): 'a queue) = (front, x :: rear)
    
    fun dequeue (([], []): 'a queue) = raise Empty
      | dequeue ((x::xs, rear): 'a queue) = (x, (xs, rear))
      | dequeue (([], rear): 'a queue) = dequeue (rev rear, [])
    
    fun peek (([], []): 'a queue) = raise Empty
      | peek ((x::_, _): 'a queue) = x
      | peek (([], rear): 'a queue) = peek (rev rear, [])
end

fun readGrid filename =
    let
        val ins = TextIO.openIn filename
        val N = valOf (Int.fromString (valOf (TextIO.inputLine ins)))
        fun readLines 0 = []
          | readLines n = (map (fn x => valOf (Int.fromString x))
                              (String.tokens Char.isSpace (valOf (TextIO.inputLine ins))))
                            :: readLines (n - 1)
        val grid = readLines N
        val _ = TextIO.closeIn ins
    in
        (N, grid)
    end

fun inBounds (N, (x, y)) = x >= 0 andalso x < N andalso y >= 0 andalso y < N

fun carsAt grid (x, y) = List.nth (List.nth (grid, x), y)

fun bfs (N, grid) =
    let
        val directions = [(1, 0, "S"), (0, 1, "E"), (1, 1, "SE"), (~1, 0, "N"), (0, ~1, "W"),
                          (~1, ~1, "NW"), (1, ~1, "SW"), (~1, 1, "NE")]
        
        fun explore (queue, visited) =
            if Queue.isEmpty queue then
                "IMPOSSIBLE"
            else
                let
                    val ((x, y, moves), queue') = Queue.dequeue queue
                in
                    if (x, y) = (N-1, N-1) then
                        "[" ^ String.concatWith "," (List.rev moves) ^ "]"
                    else
                        let
                            val nextSteps = List.filter (fn (dx, dy, _) =>
                                                          inBounds (N, (x + dx, y + dy)) andalso
                                                          carsAt grid (x + dx, y + dy) < carsAt grid (x, y) andalso
                                                          not (List.exists (fn (a, b, _) => (a, b) = (x + dx, y + dy)) visited))
                                                    directions
                            val newVisited = List.foldl (fn ((dx, dy, dir), acc) =>
                                                           (x + dx, y + dy, dir) :: acc)
                                                         visited
                                                         nextSteps
                            val newQueue = List.foldl (fn (step, q) =>
                                                          Queue.enqueue ((x + #1 step, y + #2 step, #3 step :: moves), q))
                                                        queue'
                                                        nextSteps
                        in
                            explore (newQueue, newVisited)
                        end
                end
    in
        explore (Queue.enqueue ((0, 0, []), Queue.emptyQueue), [])
    end

fun moves filename =
    let
        val (N, grid) = readGrid filename
        val result = bfs (N, grid)
    in
        print (result ^ "\n")
    end