#!/bin/bash

# Define 
INT_MIN=-2147483648
INT_MAX=2147483647

# Amount of numbers to be generated
n=500

# Random number generator
if (( RANDOM % 2 )); then
    RANGE=$((INT_MAX - INT_MIN + 1))
    NUMBERS=$(shuf -i 0-$((RANGE-1)) -n $n | awk -v min="$INT_MIN" '{print min + $1}' | tr '\n' ' ')
else
    NUMBERS=$(seq 1 $n | sort -R | tr '\n' ' ')
fi

# Stores output from the program
OUTPUT=$(./push_swap $NUMBERS)


####################################################################################################################################################
# LINE TEST
####################################################################################################################################################
# Stores and prints number of movements (number of lines)
LINE_COUNT=$(echo "$OUTPUT" | wc -l)
# Counts amount of parameters given to the program
COUNT=$(echo "$NUMBERS" | wc -w)

if [ "$COUNT" -eq 500 ]; then
    if [ "$LINE_COUNT" -lt 5500 ]; then
        LINE_TEST="✅"
    else
        LINE_TEST="Nope! ❌"
    fi
elif [ "$COUNT" -eq 100 ]; then
    if [ "$LINE_COUNT" -lt 700 ]; then
        LINE_TEST="✅"
    else
        LINE_TEST="Nope! ❌"
    fi
elif [ "$COUNT" -eq 5 ]; then
    if [ "$LINE_COUNT" -lt 12 ]; then
        LINE_TEST="✅"
    else
        LINE_TEST="Nope! ❌"
    fi
fi

####################################################################################################################################################
# CHECKER TEST
####################################################################################################################################################
CHECKER_OUTCOME=$(echo "$OUTPUT" | ./checker_linux $NUMBERS)

if echo "$CHECKER_OUTCOME" | grep -q "OK"; then
	CHECK_ICN="✅"
	elif echo "$CHECKER_OUTCOME" | grep -q "KO"; then
		CHECK_ICN="❌";
fi

####################################################################################################################################################
# VALGRIND TEST
####################################################################################################################################################
VALGRIND_LOG=$(mktemp)
ARGS=$(echo "$NUMBERS")
valgrind -s --leak-check=full ./push_swap $ARGS > /dev/null 2> "$VALGRIND_LOG"

# Check Valgrind output
if grep -q "ERROR SUMMARY: 0 errors" "$VALGRIND_LOG" && grep -q "All heap blocks were freed -- no leaks are possible" "$VALGRIND_LOG"; then
    VALGRIND_OUT="OK ✅"
else
    VALGRIND_OUT="❌ Issues found! | $(cat "$VALGRIND_LOG")"
fi

####################################################################################################################################################
# SUMMARY
####################################################################################################################################################
# Prints output
echo "$OUTPUT"

# Prints Line Test
echo "For $COUNT numbers, number of lines: $LINE_COUNT $LINE_TEST"

# Prints Checker Test
echo "Checker outcome: $CHECKER_OUTCOME $CHECK_ICN"

# Prints Valgrind Test
echo "Valgrind: $VALGRIND_OUT"

if [ "$COUNT" -eq 500 ]; then
    if [ "$LINE_COUNT" -lt 5500 ]; then
        echo "✅ $NUMBERS" >> numbers_used.txt
    else
        echo "❌ $NUMBERS" >> numbers_used.txt
    fi
elif [ "$COUNT" -eq 100 ]; then
    if [ "$LINE_COUNT" -lt 700 ]; then
        echo "✅ $NUMBERS" >> numbers_used.txt
    else
        echo "❌ $NUMBERS" >> numbers_used.txt
    fi
elif [ "$COUNT" -eq 5 ]; then
    if [ "$LINE_COUNT" -lt 12 ]; then
        echo "✅ $NUMBERS" >> numbers_used.txt
    else
        echo "❌ $NUMBERS" >> numbers_used.txt
    fi
else 
    echo "✅ $NUMBERS" >> numbers_used.txt
fi

cat "$VALGRIND_LOG" > valgrind_log.txt

echo "$OUTPUT" > moves.txt

# Clean up
rm "$VALGRIND_LOG"
#Infinite loop 3 6 1 2
