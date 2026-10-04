from collections import deque

class Cell:
    def __init__(self, x, y, path):
        self.x = x
        self.y = y
        self.path = path

def find_shortest_path(grid):
    N = len(grid)
    visited = [[False] * N for _ in range(N)]
    queue = deque()
    queue.append(Cell(0, 0, ""))
    visited[0][0] = True

    while queue:
        cell = queue.popleft()

        if cell.x == N - 1 and cell.y == N - 1:
            return "[" + cell.path.strip().replace(" ", ",") + "]"

        for i in range(8):
            new_x = cell.x + dx[i]
            new_y = cell.y + dy[i]

            if 0 <= new_x < N and 0 <= new_y < N and not visited[new_x][new_y] and grid[new_x][new_y] < grid[cell.x][cell.y]:
                visited[new_x][new_y] = True
                queue.append(Cell(new_x, new_y, cell.path + " " + directions[i]))

    return "IMPOSSIBLE"

if __name__ == "__main__":
    import sys

    dx = [-1, 1, 0, 0, -1, -1, 1, 1]
    dy = [0, 0, -1, 1, -1, 1, -1, 1]
    directions = ["N", "S", "W", "E", "NW", "NE", "SW", "SE"]

    if len(sys.argv) != 2:
        print("Usage: python script.py <inputfile>")
        sys.exit(1)

    filename = sys.argv[1]
    with open(filename, 'r') as f:
        N = int(f.readline().strip())
        grid = [[int(x) for x in f.readline().strip().split()] for _ in range(N)]

    print(find_shortest_path(grid))
