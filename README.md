# Implementation of Modified Booth Multiplier using Pipeline Technique on FPGA

In this repo you can see implementation of two Booth Multiplier and Modified Booth Multiplier.


# DIFERENT TYPES OF MULTIPLIERS

- Array Multipliers
- Braun Multipliers
- Wallace Tree Multipliers
- Dadda Multipliers
- Baugh-Wooley Multiplier
- Booth Multiplier
- Modified Booth Multiplier

For more details on these multipliers and to compare them, read the "COMPARISON OF DIFFERENT TYPES OF MULTIPLIERS WITH RESPECT TO SPEED, AREA AND POWER" in the [papers directory](./papers).


# Booth Multiplier and Modified Booth Multiplier

The Modified Booth Multiplier using Pipeline has more hardware complexity than the Basic Booth Multiplier, despite being optimized to reduce the number of partial multiplications. Basic Booth Multiplie is implemented by only one module, while to implement Modified Booth Multiplier we need five modules. You can find implementations of this two algorithms in [Booth directory](./Booth). and [ModifiedBooth directory](./ModifiedBooth). For more details on Modified Booth Multiplier, read the "Implementation of Modified Booth Multiplier using Pipeline Technique on FPGA" in the [papers directory](./papers).

# Steps of the proposed method to accelerate the Booth multiplication algorithm

- PARTIAL PRODUCT GENERATION
- WALLACE TREE STRUCTURE
- CARRY LOOKAHEAD ADDER