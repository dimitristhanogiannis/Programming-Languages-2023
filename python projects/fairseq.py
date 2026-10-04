import sys

def fairseq(N, S):
    maximum = 1000000000
    minimum = maximum
    total_sum = sum(S)

    for i in range(N):
        sum_in = 0
        for j in range(i, N):
            sum_in += S[j]
            sum_out = total_sum - sum_in
            if abs(sum_in - sum_out) < minimum:
                minimum = abs(sum_in - sum_out)
    return minimum

def main():
    if len(sys.argv) != 2:
        print("Usage: python script.py input_file")
        return

    with open(sys.argv[1], 'r') as file:
        N = int(file.readline())
        seq = list(map(int, file.readline().split()))

    result = fairseq(N, seq)
    print(result)

if __name__ == "__main__":
    main()
