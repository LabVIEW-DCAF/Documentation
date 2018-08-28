# Hands-On 1: Creating a DCAF Application

This hands-on covers the basics of implementing an application in the Distributed Control and Automation Framework, including using an existing module and developing a new control module. It doesn’t cover development of a new generic I/O or processing module. For this hands on, the framework downloads, and additional documentation, visit ni.com/dcaf

#### Setup

## Introduction


## Exercise 1:
This exercise demonstrates the implementation of a simple temperature chamber controller application. It makes use of a model of the chamber to simulate its I/O and allows users to define the setpoint and PID gains of the control algorithm through a simple user interface.

During the exercise you will learn to identify how inputs and outputs from different modules are mapped within DCAF to provide communication between modules.  You will also learn how to create a UI and map it to data within the framework.

Our **Simulated Temperature Controller** will consist of 2 **DCAF Engines**: the UI and the Temperature Controller Simulation.
<p align="center">
![Figure 1.1 System Configuration](Pictures\fig1_1_modules_configuration.jpg)
</p>
<p align="center">
*Figure 1.1*
</p>
<p align="left">
In the hierarchy shown above you can find some of the components defined in the previous section. In each of these Engines you will find Modules. Some of these **Modules** are standard and some of them were created specifically for this Hands On.
</p>


##### Standard Modules

UDP: This module exists in both components. It is designed to share tags between Engines by mapping each tag as an Engine Input or Output. All tags that are intended to be shared between engines need to be defined in the Tags Pane of each engine with the same names.

UI Reference: This module takes a pre-existing front panel and maps its controls and indicators to DCAF tags to permit direct user interaction with the framework.

 
##### Custom Modules

Temperature Controller Logic: This is a custom DCAF Module designed to provide the control logic for the temperature chamber. If the Simulation Engine is moved to a cRIO Target and the Temperature Chamber Model is replaced with real IO, this module could remain the same.

Temperature Chamber Model: This module provides a simulated model of a Temperature Chamber. This module could be replaced or overwritten to eventually provide IO from a real Temperature Chamber.

### Part 1: Project Creation and UI
During this first part of the exercise you will be create a DCAF project from scratch using a template and learn how to add a User Interface to your DCAF project.


1.	In LabVIEW go to File >> Create Project.. and select DCAF. From the displayed list select Basic Execution Template and press the Next button.
2.	Name the project Temperature Controller and select \\Desktop\DCAF Hands On\Exercises\Temperature Controller\Runtime\Temperature Controller as the Project Root. Type TCRL as the File Name Prefix.
3.	Verify your project window matches Figure 1.2.

<p align="center">
![Figure 1.2 Project Configuration](Pictures\fig1_2_project_configuration.jpg)
</p>
<p align="center">

*Figure 1.2*
</p>

4.	Add to the project a Configuration File with the Engines for the Temperature Controller partially configured and mapped (in future exercises you will make a Configuration File). Under My Computer add SimulatedSystem.pcfg located at \\Desktop\DCAF Hands On\Exercises\ Temperature Controller.
5.	To speed up the exercise, a UI has already been created. Under My Computer, add TCRL User Interface.vi to the project located at \\Temperature Controller\Runtime.
6.	Look at the names of the Labels in the Block Diagram. This is important to correctly map the tags to the UI. Controls and Indicators will be directly updated through the DCAF UI Engine, so there is no need to add more code in this VI.
<p align="center">
![Figure 1.3 Project Configuration](Pictures\fig1_3_UI_block_diagram.jpg)
</p>
<p align="center">
*Figure 1.3*
</p>

7.	Open TCRL Host Main.vi Block Diagram. Delete the bottom While Loop, as we won’t need it for this exercise. Drag and Drop TCRL User Interface.vi into the Block Diagram from the Project Window. Force TCRL User Interface.vi to execute in parallel to the DCAF engine connecting as shown in Figure 1.4.

<p align="center">
![Figure 1.4 Host Main Block Diagram](Pictures\fig_1_4_Host_Main_block_diagram.jpg)
</p>
<p align="center">
*Figure 1.4*
</p>

8.	Open TCRL Host Main.vi Front Panel. In the configuration file path control browse for SymulatedSystem.pcfg located at \\Temperature Controller.  Select this as default value for this control. Save and Close this VI.
 
### Part 2: Adding Required Classes

DCAF has been developed using LabVIEW Object Oriented Programming. Therefore, the code will only run if the classes used within a specific configuration are added to the project. DCAF provides a simple script that will help you with this every time you add or remove modules to a target in the Configuration Editor. This is not automatic, so you have to remember to run this scripting tool when you make these kinds of changes in the configuration.

1.	Open the Standard Configuration Editor by navigating in LabVIEW to Tools>>DCAF>>Launch Standard Configuration Editor…
2.	Navigate within the editor to Tools>>Edit Plugin Search Paths.
3.	Add a search path to the plugins for this example located at \\Temperature Controller if it’s not already there.
4.	In the DCAF Configuration Editor go to File>>Open and search for the SimulatedSystem.pcfg Configuration File located at \\Temperature Controller.
5.	Take a couple of minutes to go through each component in the Simulation and UI Engines.
6.	Open the Temperature Controller project located at \\Temperature Controller\Runtime if not already opened.
7.	Open TCRL Host Module Includes.vi and verify the Block Diagram is empty. This VI will load the required classes when TCRL Host Main.vi executes. A scripting tool will add the corresponding classes to TCRL Host Module Includes.vi. In the System Configuration hierarchy in the DCAF Configuration Editor select PC. In the Includes file path box browse for  TCRL Host Module Includes.vi located at \\Temperature Controller\Runtime. Press the Generate button. Repeat this step each time you add or remove any Module from the Hierarchy Tree.

<p align="center">
![Figure 1.5 Script Includes Dialog](Pictures\fig_1_5_script_includes_dialog.jpg)
</p>
<p align="center">
*Figure 1.5*
</p>

8.	Verify that the corresponding classes have been added to TCRL Host Module Includes.vi and compare them to Figure 1.6:

<p align="center">
![Figure 1.6 Host Includes Block Diagram](Pictures\fig_1_6_host_includes_block_diagram.jpg )
</p>
<p align="center">
*Figure 1.6*
</p>

9.	Save and close TCRL Host Module Includes.vi.

### Part 3: Mapping Tags in the Configuration Editor


This DCAF project has 2 engines: The Simulation Engine and the UI Engine. Both engines have listed Tags, Mappings, and UDP items. The rest are specific modules for each engine.
-	The Tags item refers to the list of tags in the Tag Bus for each engine.
-	The Mappings item allows to configure and visualize the connections between each Module parameter (Input/Output) and the Tag Bus.  
-	The UDP item publishes tags that can be shared with another engine that might be in the same target or in a different one.
During this last part of the exercise you will learn how to map Tags between Modules through the Tag Bus in each Engine and share Tags between Engines through UDP.

Before we start the implementation, take a look to the following diagram to understand how data flows through Modules and Engines of our Simulated Temperature Controller.

<p align="center">
![Figure 1.7 Mapping Guide](Pictures\fig_1_7_mapping_guide.jpg)
</p>
<p align="center">
*Figure 1.7*
</p>
1.	Open the Standard Configuration Editor by navigating in LabVIEW to Tools>>DCAF>>Launch Standard Configuration Editor…
2.	We will first map our UI to the UI Engine Tags. Beneath the UI Standard Engine select UI Reference. Notice the table in the Static Configuration tab is empty. Press the Browse button next to the UI to Load textbox. Browse for TCRL User Interface.vi located at \\Temperature Controller\Runtime.
3.	Press the Configure from UI button. When the pop up asking to Automatically map tags to channels appears select Yes. Verify your mappings comparing them with Figure 1.8.
<p align="center">
![Figure 1.8 UI Module Configuration](Pictures\fig_1_8_ui_module_configuration.jpg )
</p>
<p align="center">
*Figure 1.8*
</p>

4.	Save the changes in the Configuration Editor.
5.	Open and run TCRL Host Main.vi. Try changing the Setpoint and the other controls. Do you see any change in the temperature value displayed in the Graph?
<p align="center">
![Figure 1.9 UI Front Panel](Pictures\fig_1_9_ui_front_panel.jpg)
</p>
<p align="center">
*Figure 1.9*
</p>
You shouldn’t see any change in the signal since we only connected the tags in the UI Engine. There are still some tags in the Simulation Engine that we need to map so we can see the PID standard behavior.

6.	Stop the TCRL Host Main.vi and return to the Configuration Editor. We will review the connections in each component on both engines to understand the tag dataflow and connect the tags that are missing to make it run.

7.	We will start with the Simulation Engine. First select the Tags node and take a look at the tags.
fig_1_10_tags_configuration.jpg

<p align="center">
![Figure 1.10 Tags Configuration](Pictures\fig_1_10_tags_configuration.jpg)
</p>
<p align="center">
*Figure 1.10*
</p>

8.	These tags are used for connections in the rest of Simulation Engine modules: Temperature Controller Logic, Temperature Chamber Model and UDP. Notice all of them are Doubles except for Fan on?.

9.	Go to Mappings under the Simulation Standard Engine and select the Manual Mapping tab. This section will allow you to have a better look of the tag flow in this application. In the left pane you will see all the channels that haven’t been mapped. Just look, don’t make changes.

<p align="center">
![Figure 1.11 Mappings Configuration](Pictures\fig_1_11_mappings.jpg)
</p>
<p align="center">
*Figure 1.11*
</p>

10.	Go to the Temperature Controller Logic Module. Notice there are two variables that don’t appear in the Tag list: output range high and output range low. These are internal variables with constant values defined statically. The rest should be mapped to a tag.

11.	The last 3 channels should be connected to a tag (Fan on?, fan, and lamp). To connect a channel to a tag, take the cursor to the corresponding cell in the Mapped to System Tag column, left click, and select the corresponding tag from the Available Tags list.
<p align="center">
![Figure 1.12 Mapping Configuration Dialog](Pictures\fig_1_11_mapping_configuration_dialog.jpg)
</p>
<p align="center">
*Figure 1.12*
</p>

12.	Verify your table looks like the following image:

<p align="center">
![Figure 1.13 Mapping Configuration Dialog](Pictures\fig_1_13_mapping_configuration_dialog.jpg)
</p>
<p align="center">
*Figure 1.13*
</p>

13.	Before going to the next module notice the Direction column. Processing parameters are module inputs while processing results are module outputs. Some of the processing parameters in this module come from the UI Engine and others come from the Temperature Controller Logic Module. The two processing results in this module will go through the Tag Bus as inputs in the Temperature Chamber Model module.

14.	Go to the Temperature Chamber Model module. Notice all the channels are disconnected from any tag. The only disconnected channel should be Ambient Temperature. Create the following connections. Fan PWM and Lamp PWM channels are processing parameters in this module that should come from the Temperature Controller Logic Module. Thermocouple Reading is a processing result that should be used as the feedback signal in the Temperature Controller Logic Module and will also be sent to the UI Engine to be displayed in the graph. Following the same instructions as in step 11, map Fan PWM, Lamp PWM, and Thermocouple Reading channels to Fan, Lamp, and Thermocouple tags. Verify your table looks like the following image:

<p align="center">
![Figure 1.14 Temperature Model Configuration](Pictures\fig_1_14_temperature_model_configuration_dialog.jpg)
</p>
<p align="center">
*Figure 1.14*
</p>

15.	Go to the UDP Module in the Simulation Engine. Go to the Channel Mapping Tab. Notice the tags in the From External Engine (Inputs) and To External Engine (Outputs) boxes. Notice the Fan tag is still as an Available Tag. There is no need to move it since it is not needed in the UI Engine, it is only used internally in the Simulation Engine.

<p align="center">
![Figure 1.14 Temperature Model Configuration](Pictures\fig_1_14_temperature_model_configuration_dialog.jpg)
</p>
<p align="center">
*Figure 1.14*
</p>
