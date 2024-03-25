import cointoss

def main():
    cointoss.message()
    
    num_heads = 15
    num_tosses = cointoss.cointoss(num_heads)
    print(f"It took {num_tosses} tosses to get {num_heads} heads in a row.")


if __name__ == "__main__":
    main()