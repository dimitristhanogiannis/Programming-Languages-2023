import java.io.*;
import java.util.*;

class Node {
    int data;
    Node left, right;

    Node(int d, Node l, Node r) {
        data = d;
        left = l;
        right = r;
    }
}

public class Arrange {

    public static Node toTree(List<Integer> a, int N) {
        Stack<Node> s = new Stack<>();
        Node t;
        Node root = new Node(a.get(0), null, null);
        t = root;
        t.right = new Node(0, null, null);
        t.left = new Node(0, null, null);
        s.push(t.right);
        s.push(t.left);
        for (int i = 1; i < N; i++) {
            if (a.get(i) != 0) {
                t = s.pop();
                t.data = a.get(i);
                t.right = new Node(0, null, null);
                t.left = new Node(0, null, null);
                s.push(t.right);
                s.push(t.left);
            } else if (a.get(i) == 0) {
                s.pop();
            }
        }
        return root;
    }

    public static void swap(Node t) {
        Node temp = t.left;
        t.left = t.right;
        t.right = temp;
    }

    public static List<Integer> arrange(Node t) {
        if (t.data == 0) {
            return new ArrayList<>();
        }
        List<Integer> v1 = arrange(t.left);
        List<Integer> v2 = arrange(t.right);

        if (!v1.isEmpty() && !v2.isEmpty()) {
            if (v2.get(0) < v1.get(0)) {
                swap(t);
                v2.add(t.data);
                v2.addAll(v1);
                return v2;
            }
        } else if (!v1.isEmpty() && v2.isEmpty()) {
            if (v1.get(0) > t.data) {
                swap(t);
                v2.add(t.data);
                v2.addAll(v1);
                return v2;
            }
        } else if (!v2.isEmpty() && v1.isEmpty()) {
            if (v2.get(0) < t.data) {
                swap(t);
                v2.add(t.data);
                v2.addAll(v1);
                return v2;
            }
        }

        v1.add(t.data);
        v1.addAll(v2);
        return v1;
    }

    public static void printTree(Node t) {
        if (t == null) return;

        if (t.data != 0) {
            printTree(t.left);
            System.out.print(t.data + " ");
            printTree(t.right);
        }
    }

    public static void main(String[] args) {
        if (args.length < 1) {
            System.err.println("Usage: java Arrange <inputfile>");
            return;
        }

        Node t;
        int N;

        try {
            BufferedReader myfile = new BufferedReader(new FileReader(args[0]));
            String line = myfile.readLine();
            if (line != null && !line.trim().isEmpty()) {
                N = Integer.parseInt(line.trim());
            } else {
                throw new IOException("Invalid input file format.");
            }

            List<Integer> a = new ArrayList<>();
            while ((line = myfile.readLine()) != null) {
                String[] tokens = line.trim().split("\\s+");
                for (String token : tokens) {
                    a.add(Integer.parseInt(token));
                }
            }
            myfile.close();

            if (a.size() < N) {
                throw new IOException("Input data does not match the expected size.");
            }

            t = toTree(a, a.size());
            List<Integer> v = arrange(t);
            for (Integer value : v) {
                System.out.print(value + " ");
            }
            System.out.println();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}