## OpsWorks Visualization App

Angular web app displaying all Babbel current OpsWorks stacks and corresponding information including each stacks ELBs, Layers, and the associated instances.

For each instance, there is optional information which can be displayed in the visualization, including the instance's status, it's size, and it's public IP address.

The visualizer has a sidebar which permits layers, ELBs, and instances to be toggled on and off in the display. The optional instance information mentioned above can also be toggled on and off in this sidebar.

For this app, an API wrapper was designed to pull information from the Amazon OpsWorks API and package it as a list of stacks, with associated instances, layers, and ELBs. This makes the information more easily digestable and causes clients of the API to only need to make one call to the API wrapper (as opposed to several calls to the OpsWorks API, with repackaging on the client side).

