# Hands-On 2: Static Modules
This hands-on covers the creating of a DCAF Static module, this modules are easier to create and the recommended option if the module developer knows the number of channels that the module will require.
It is recommended that the Hands-On 1 is completed before doing this one.

<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Hands-On 2: Static Modules](#hands-on-2-static-modules)
	- [Introduction:](#introduction)
	- [Exercise 1:](#exercise-1)
		- [Part A: Create a Static PID Module](#part-a-create-a-static-pid-module)
		- [Part B: Modify the Initialization and Implement the User Process](#part-b-modify-the-initialization-and-implement-the-user-process)
		- [Part C: Update the Static PID Module with Scripting](#part-c-update-the-static-pid-module-with-scripting)
		- [Part D: Running and Configuring the Module](#part-d-running-and-configuring-the-module)
	- [Exercise 2:](#exercise-2)
		- [Part A: Create the state machine module](#part-a-create-the-state-machine-module)
		- [Part B: Create a DCAF Application that runs the Static Module](#part-b-create-a-dcaf-application-that-runs-the-static-module)

<!-- /TOC -->

## Introduction:

DCAF Static modules are simple custom modules that are easy to create with the restriction that the module developer needs to know the number of channels that the module will have. By having the known number of channels, DCAF contain useful scripting tools that simplifies the module development.

Before creating a DCAF Static module there is an important checklist to cover:

- Is there a module that already covers this functionality?
- Is this a static or a dynamic module?
- What inputs or outputs my module needs?

In each exercise will go through this checklist during the module definition, and a more on how to define DCAF modules can be found in the DCAF developer guide in section 4.


## Exercise 1:
In this exercise we will create a DCAF Static module that contains a custom PID control for our application.

#### Concepts Covered:
- Static Module Creation
- Basic Static Module overrides
- Static channel Configuration
- Working with the User Process VI
- Static Module Scripting


#### Module Definition:
This is processing module that will contain a single PID. Initially it will have some values hardcoded and will be updated to change so they can be updated by the engine.
- Is there a module that already covers this functionality?
In this case yes there is a PID module for DCAF that could be used, but as we want to go with the exercise we are going to ignore it.
-Is this a static or dynamic modules?
The module only needs 1 pid, and we know the inputs required for the PID so it is a static module.
-What inputs or outputs my module needs?
This is a processing module all its inputs come from the Tag Bus and all the outputs go into the Tag Bus. The initial channel list is the following one:

Name               | 	Type   |  Direction
--                 |  ---    |--
Temperature        | Double  |  Processing Parameter
Setpoint           | Double  |  Processing Parameter
Output Range High  | Double  |  Processing Parameter
Output Range Low   | Double  |  Processing Parameter
Output             | Double  |  Processing Result

This channel list will change during the exercise.



### Part A: Create a Static PID Module
##### Create module from template
1. Navigate to **Project >> Create Project…**
2. In the tree on the left, select **DCAF >> Modules** and select **DCAF Static Channel Module**.
3. Type **Custom Temperature Controller** as the **Module Name**.
4. Look for the Project Root **\\Desktop\Hands On\Hands-On_2\Exercises\Temperature Controller\Modules** and create a folder called **Custom Temperature Controller**. Get into that folder and press **Current Folder**.
6. Add the following parameters to your new module as **Channels** in the **Channel Specifications** tab. Channels represent data passed to or from your module during different execution stages, and channel names are case sensitive. The direction specifies whether the data is to the module or from the module, and is divided into inputs (data provided by input.vi), outputs (data provided to output.vi), and processing parameters and results (data passed to and from process.vi). For this hands on we will implement a processing step.

Name               | 	Type   |  Direction
--                 |  ---    |--
Temperature        | Double  |  Processing Parameter
Setpoint           | Double  |  Processing Parameter
Output             | Double  |  Processing Result


Your configuration should look like the one shown in Figure 1.1.


|![Custom Temperature Controller Creation](Pictures/custom_temperature_controller_creation.jpg)
|:--:|
|*Figure 1.1*

7.	Press Finish.


|![Custom Temperature Controller Project.jpg](Pictures/custom_temperature_controller_project.jpg)|
|:--:|
|*Figure 1.2*|


8. Your new project will appear. We will now explore how this new module loads from the editor. Open the DCAF editor by going to **Tools >> DCAF >> Launch Standard Configuration Editor**. 

9. We want to configure the editor to search for modules in the path where our PID module was saved. From the DCAF Editor, navigate to **Tools >> Edit Plugin Search Paths...**. Add the next path as a search path: **\\Temperature Controller\Modules**.
**Note**: Add the whole modules directory as the simulation module is in that folder.

10. Add a PC target and a standard engine under the system to finally add your Custom Temperature Controller Module under the engine.It should look as in the image below. As you can see, the channels of our module are ready to be connected to tags in the engine.

|![Module in Editor 1.jpg](Pictures/module_editor1.jpg)|
|:--:|
|*Figure 1.3*|

11. Close the DCAF Editor and for now don't save any changes.

12. We will now modify our module to contain parameters: Output Range High and Output Range Low. Find and open the **get desired keys.vi** in the configuration class. This should be located in the Customize folder.

13. Modify this VI to return the name of the parameters Output Range High and Output Range Low in the desired keys output. Close and save this VI.

|![Get Desired Keys.jpg](Pictures/get_desired_keys.jpg)|
|:--:|
|*Figure 1.4*|

14. Find and open the **validate key value pair.vi** in the configuration class. This should be located in the Customize folder as well. This VI runs each time the user changes the value of our parameters. In this case we will just add cases to handle the keys Output Range High and Output Range Low without checking anything in particular about the value. Check the image below to see the expected outcome for this VI. Save it and close it when done.

|![validate key value pair.jpg](Pictures/validate_key_value_pair.jpg)|
|:--:|
|*Figure 1.5*|

15. Open the DCAF Editor and add our module again. After our recent changes, a new tab called Parameters shows up where the user can configure the value for Output Range High and Output Range Low. Show the DCAD editor and don't save any changes for now. 

|![Module Editor Parameters.jpg](Pictures/module_editorParameters.jpg)|
|:--:|
|*Figure 1.6*|

We are done with building the configuration for our static module. In the next section of this exercise we will mainly work on the runtime class of the module.

### Part B: Modify the Initialization and Implement the User Process

We are now ready to perform the necessary implementations in the runtime side of our module. We will start by modifying the initialization to be able to load the parameters that will be used by our process. Once this is done, we will modify the user process to contain a PID. 

1. We will start by modifying our runtime class private data to contain the parameters we want to save. Open the **Custom Temperature Controller runtime.ctl** to contain a cluster with the Output Range High and Output Range Low. Make sure you keep the rest of this private data unmodified.

|![Runtime Private Data.jpg](Pictures/runtime_private_data.jpg)|
|:--:|
|*Figure 1.7*|


2. Next, create an override for the **apply key value pairs.vi** to store the parameters that were saved as keys into the **Custom Temperature Controller runtime.ctl**. To create the override VI, right-click on the runtime class and select **New >> VI for Override** and select the **apply key value pairs.vi** in the *New Override* window.

3. Modify the **apply key value pairs.vi** to look like the one in the image below. When the Output Range High or Output Range Low key is detected we store its value in the corresponding element in our private data.

|![apply key value pairs.jpg](Pictures/apply_key_value_pairs.jpg)|
|:--:|
|*Figure 1.8*|

4. Navigate to **Custom Controller Module runtime.lvclass** and open **process.vi** in the overrides folder. On either side, Scripted Accessors convert tag bus data into your user-defined cluster. These methods are not automatically generated and must be generated when the project is first scripted or after any change to the interface. We will cover how to make changes to this VIs in Part C of this exercise. Feel free to explore with more detail the code inside these accessors.

|![Custom Temperature Controller Process.jpg](Pictures/ctc_process.jpg)
|:--:|
|*Figure 1.9*

5.  Navigate to **Custom Controller Module runtime.lvclass** and open **user process.vi**. This method should have two clusters, one input and one output, which match the list of channels we configured for our module. Implement the same PID control as shown in the Figure 1.10.

|![Figure 1.10 Custom Temperature Controller Initial User Process](Pictures/ctc_user_process_initial.jpg)
|:--:|
|*Figure 1.10*


  1. Drop down an instance of **PID.vi** from **Control and Simulation >> PID >> PID.vi.**
  2. Drop down the Unbundle by Name function.
  3. Wire the Unbundle by Name function to the *Custom Temperature Controller runtime in* object. Access with this function the output range cluster with the high and low limits for the PID.
  4. Wire **output range** to **PID.vi output range input**.
  5. Wire **Parameters to process.Temperature** to **PID.vi process variable input**.
  6. Wire **Parameters to process.setpoint** to **PID.vi setpoint input**.
  7. Create a constant from **PID.vi PID gains input**.
  8. Wire PID.vi output to **Output** from **processing.Output**.
  9. The result should look something like Figure 1.10.

Our Custom Temperature Controller Static Module is now ready to run. However, we will study the steps to update our module with new processing parameters in the part C.

### Part C: Update the Static PID Module with Scripting
As with any project requirment changed and we need to add channels for the  P,I,D values. In this section we are going to update our module channel list matches this table:

Name               | 	Type   |  Direction
--                 |  ---    |--
Temperature        | Double  |  Processing Parameter
Setpoint           | Double  |  Processing Parameter
P                  | Double  |  Processing Parameter
I                  | Double  |  Processing Parameter
D                  | Double  |  Processing Parameter
Output             | Double  |  Processing Result



##### Update the clusters
1. Open the **parameter user data.ctl**

|![Custom Temperature Controller Parameter Project .jpg](Pictures/ctc_parameter_project.jpg)
|:--:|
|*Figure 1.11*

2. Add the new channels for the cluster to look like in figure 1.12

|![Custom Temperature Controller Parameter Project .jpg](Pictures/ctc_parameter_cluster.jpg)
|:--:|
|*Figure 1.12*

3. Save the control and apply changes **File>>Apply Changes**


**Note**: If you are adding channels of a different type that the module previously didn't have like a input channel in this case. It is necessary to modify  **get data definition.vi** in the runtime class. The “valid?” Boolean for each case of the case structure indicates whether or not the data interface is valid and if that method should be run. Setting a given Boolean to true tells the framework that you’d like to configure and run that method. If you followed the steps above, the Boolean should be true for processing parameters and processing results. The script will use these Booleans to determine if a given cluster is valid (the “placeholder” fields are just there to ensure the clusters are not broken).


##### Run the scripting
**Note**: During this process, the lvclass files are modified and so LabVIEW requires that your classes are not loaded in multiple contexts. That is, you must close any other projects which currently have the class loaded. If you see a “lock” icon over the class, the script will not work.

4.	Open **Tools >> DCAF >> Launch Control Module Scripting Utility…**

5.	Drag the runtime class from the project over the runtime class path control or browse for it manually, then repeat for the configuration class (YourModuleName Configuration.lvclass).
Because you used the script, you can leave most options as the default. Once the script finishes executing, the **Custom Temperature Controller runtime.lvclass:tag bus to parameters.vi** should look similar to the one in the figure 1.13 below.

|![Custom Temperature Controller Accessors Scripted .jpg](Pictures/ctc_accessors_scripted.jpg)
|:--:|
|*Figure 1.13*

6. Navigate again to **Custom Controller Module runtime.lvclass**, open **user process.vi** and modify it to take the P,I and D gains from the parameters to process cluster. Your final VI should look similar to the one in figure 1.14.


|![Custom Temperature Controller Complete User Process](Pictures/ctc_user_process_complete.jpg)
|:--:|
|*Figure 1.14*

7.	Save the module project and close it.

### Part D: Running and Configuring the Module

##### Configuration Editor
1. Open Standard Configuration Editor (**Open Tools >> DCAF >> Launch Standard Configuration Editor…**).

2. Open **Static Temperature Chamber.pfcg** in the **\\Desktop\Hands On\Hands-On_2\Exercises\Temperature Controller** folder.

3. Right click on Standard Engine and select **Add >> Other>>Custom Controller Module**. Then, select this new module from the tree.

4. For each processing parameter tag, click on the column Mapped to System Tag and configure the channel to be mapped to the appropriate system tag. You can look at “Temperature Controller Logic” to identify the correct mapping, which looks like Figure 1.15:

|![Custom Temperature Controller channel configuration](Pictures/ctc_channel_configuration.jpg)
|:--:|
|*Figure 1.15*


5.	Now, navigate to the Parameters tab and configure the value for the range limits. Set output range high to 100 and output range low to 0. These are  not channels, meaning they can be modified in the editor but they are constants at runtime – output range high will always be 100.


|![Custom Temperature Controller channel configuration](Pictures/ctc_range_configuration.jpg)
|:--:|
|*Figure 1.16*

6.	Select to File >> Save.

7. Open the **Temperature Chamber.lvproj** in **\\Desktop\Hands On\Hands-On_2\Exercises\Temperature Controller**.

8. From the Project Window, open **Temperature Chamber Includes.vi**.  This function ensures that all appropriate modules are loaded into memory. You can also load precompiled modules (llb or lvlibp files) from disk, but for our purposes we will simply hardcode the appropriate modules.

|![Figure 1.13 Custom Temperature Controller Includes Block Diagram](Pictures/ctc_includes_bd.jpg)
|:--:|
|*Figure 1.17*


##### Running the Code

9. Open the **Temperature Chamber Main.vi**.
10. Set the Configuration File Path to the path of the *Static Temperature Chamber.pcfg*.

**Note:** If the configuration file name is not valid you will receive error 538500

11. Run the VI and use the UI to verify the PID behaves as expected.


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

|![Custom Temperature Controller Includes Block Diagram](Pictures/state_machine_state_diagram.jpg)|
|:--:|
| *Figure 2.1*  |


The inputs and outputs list for this modules are:


Name               | 	Type   |  Direction
--                 |  ---    |--
A                  | Double  |  Processing Parameter
B                  | Double  |  Processing Parameter
C                  | Double  |  Processing Parameter
State 1            | Double  |  Processing Result
State 2            | Double  |  Processing Result
State 3            | Double  |  Processing Result



In addition to this the module will have a parameter that defines the initial state:
-initial_state: I32


### Part A: Create the state machine module
1. Create module from template
2. Add the state to the runtime
3. Initialize the state
4. Implement the user process
5. Test the user process stand alone



### Part B: Create a DCAF Application that runs the Static Module
1. Create a new project with the Basic Execution Template
2. Create a new vi for the UI that looks like figure 2.2
3. Create a DCAF configuration that maps the state machine to the UI using the UI modules
4. Run the application and test.

|![State Machine UI.](Pictures/state_machine_ui.jpg)|
|:--:|
| *Figure 2.2*  |
