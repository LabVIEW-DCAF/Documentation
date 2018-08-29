# Hands-On 2: Static Modules
This hands-on covers the creating of a DCAF Static module, this modules are easier to create and the recommended option if the module developer knows the number of channels that the module will require.
It is recommended that the Hands-On 1 is completed before doing this one.


## Introduction:

DCAF Static modules are simple custom modules that are easy to create with the restriction that the module developer needs to know the number of channels that the module will have. By having the known number of channels, DCAF contain useful scripting tools that simplifies the module development.

Before creating a DCAF Static module there is an important checklist to cover:

1. Is there a module that already covers this functionality
2. Is this a static or a dynamic module
3. What are the inputs and outputs to my module.

In each exercise will go through this checklist during the module definition, and a more on how to define DCAF modules can be found in the DCAF developer guide in section 4.


## Exercise 1:
In this exercise we will create a DCAF Static module that contains a custom PID control for our application.

#### Concepts Covered:
- Static Module Creation
- Basic Static Module overrides
- Working with the User Process VI
- Static Module Scripting


#### Module Definition:
This is processing module that will contain a single PID. Initially it will have some values hardcoded and will be updated to change so they can be updated by the engine.

### Part A: Create a Static PID Module
1. Create module from template
2. Implement the user process
3. Test the user process stand alone
4. Add module to Configuration
5. Run DCAF application




### Part B: Updating a DCAF Static Module with Scripting
1. Update the clusters
2. Run the scripting
3. Test the user Process


## Exercise 2:
In this exercise we will create a DCAF Static module that contains a state machine. This is a optional and advance exercise so there are no detailed instructions. To create this module you can use exercise 1 as reference and the DCAF developer guide section 4. There is a solution included in the solutions folder.

#### Concepts Covered:
- Use of runtime class private data
- Module initialization
- Static module parameters

#### Module Definition:
The module will be a simple state machine that contains 3 states. This states will transition from one state to the next only if just the correct Boolean is selected.

The state machine will have simple transitions.
- Change from state 1 to state 2 if only A is True
- Change form state 2 to state 3 if only B is True
- Change from state 3 to state 1 if only C is True


<p align="center">
![Figure 2.1 State Machine Diagram](Pictures\state_machine_state_diagram.jpg)
</p>
<p align="center">

The inputs and outputs list for this modules are:

##### Processing Parameters:
- A : Boolean
- B : Boolean
- C : Boolean

##### Processings Results:
- state 1 : Boolean
- state 2 : Boolean
- state 3 : Boolean

In addition to this the module will have a parameter that defines the initial state:
-initial_state: I32


### Part A: Create the state machine module
1. Create module from template
2. Add the state to the runtime
3. Initialize the state
4. Implement the user process
5. Test the user process stand alone



### Part B: Create a a DCAF Application that runs the Static Module
1. Create a new project with the Basic Execution Template
2. Create a new vi for the UI that looks like figure 2.2
3. Create a DCAF configuration that maps the state machine to the UI using the UI modules
4. Run the application and test.
<p align="center">
![Figure 1.2 State Machine UI](Pictures\state_machine_ui.jpg)
</p>
<p align="center">
