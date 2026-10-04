import java.io.*;
import java.util.*;

public class Moves {
    static class Cell {
        int x, y;
        String path;

        Cell(int x, int y, String path) {
            this.x = x;
            this.y = y;
            this.path = path;
        }
    }

    private static final int[] dx = {-1, 1, 0, 0, -1, -1, 1, 1};
    private static final int[] dy = {0, 0, -1, 1, -1, 1, -1, 1};
    private static final String[] directions = {"N", "S", "W", "E", "NW", "NE", "SW", "SE"};

    public static String findShortestPath(int[][] grid) {
        int N = grid.length;
        boolean[][] visited = new boolean[N][N];
        Queue<Cell> queue = new LinkedList<>();
        queue.add(new Cell(0, 0, ""));
        visited[0][0] = true;

        while (!queue.isEmpty()) {
            Cell cell = queue.poll();

            if (cell.x == N - 1 && cell.y == N - 1) {
                return "[" + cell.path.trim().replace(" ", ",") + "]";
            }

            for (int i = 0; i < 8; i++) {
                int newX = cell.x + dx[i];
                int newY = cell.y + dy[i];

                if (newX >= 0 && newX < N && newY >= 0 && newY < N && !visited[newX][newY] && grid[newX][newY] < grid[cell.x][cell.y]) {
                    visited[newX][newY] = true;
                    queue.add(new Cell(newX, newY, cell.path + " " + directions[i]));
                }
            }
        }

        return "IMPOSSIBLE";
    }

    public static void main(String[] args) {
        if (args.length != 1) {
            System.out.println("Usage: java Moves <inputfile>");
            return;
        }

        String filename = args[0];
        try (BufferedReader br = new BufferedReader(new FileReader(filename))) {
            int N = Integer.parseInt(br.readLine().trim());
            int[][] grid = new int[N][N];

            for (int i = 0; i < N; i++) {
                String[] tokens = br.readLine().trim().split("\\s+");
                for (int j = 0; j < N; j++) {
                    grid[i][j] = Integer.parseInt(tokens[j]);
                }
            }

            System.out.println(findShortestPath(grid));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}