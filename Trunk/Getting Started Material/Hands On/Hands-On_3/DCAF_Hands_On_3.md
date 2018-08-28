# Hands-On 3: Dynamic Module
This hands-on covers the creating of a DCAF Dynamic module, this modules are advance modules that provide additional flexibility as the number of channels of the module are configured by the final user.
It is recommended that the Hands-On 1 and 2 are completed before doing this one Hands On.


## Exercise 1 Multiplexer Module:

#### Concepts Covered:
- Dynamic Module Creation
- Dynamic Module Configuration Class overrides
- Dynamic Module Runtime Class overrides
- Dynamic Module Editor Node Class overrides
- Dynamic Module Unit Testing


### Part A: Dynamic Module Creation and Configuration
1. Create the multiplexer module:
2. Allow multiple instances
3. Can run on any target
4. Supports only doubles and Booleans
5. Override Get Line Name
6. Update Get channels from line
7. Implement to String and from String
8. Update the Create test configuration VI
9. Update the to string and from String Unit test
10. Implement the From String Array to String Array
11. Update the to String and from String Unit test


### Part B: Dynamic Module Runtime
1. Initialize the runtime class with the scaling value
2. Write the runtime to multiplex channels
3. Unit test the runtime.


### Part C: Dynamic Module Editor Node
1. Define Columns
2. Callbacks
3. To Table
4. Line Configuration Dialog.

### Part D:  Create a a DCAF Application that runs the Static Module
Create a new project with the Basic Execution Template
2. Configure the UI
3. Create a DCAF configuration that maps the state machine to the UI using the UI modules
4. Run the application and test.
