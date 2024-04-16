# A-Path-Planning-Algorithm-for-A-Crop-Monitoring-Fixed-wing-Unmanned-Aerial-System
- This repository contains the code to generate results for our SCIS paper: A Path Planning Algorithm for A Crop Monitoring Fixed-wing Unmanned Aerial System. 

- This is a readme file in how to use the energy-optimal coverage path planner for fixed-wing performing crop monitoring. This MATLAB code generates an energy-optimal flight path to perform crop monitoring while ensuring full coverage. The crop field is assumed to be a convex polygon and the parameters related to the crop field, remote-sensing camera and the fixed-wing aircraft could be input into the parameter list by the user. 

### The procedures in using the codes are as follows:

1. Change the parameters in para_def.m to suit the application. This include the crop field shape, aircraft info, camera properties, etc. The simulation results of the SCIS paper are generated using the default parameters in para.def.m. The default crop field shape is a pentagon as shown in Figure 19. 

2. Run Crop_Monitoring_Project.m. The algorithm would generate the proposed flight path in 2D and 3D plots together with the crop field shape as shown in Figure 19 and 20 in the paper. 

3. To change the crop field shape, change the variable para.shape in para_def.m. Input the coordinates of the vertices of the shape in the format of [x_1 y_1; ...; x_M y_M], where M is the number of vertices. Make sure all other default shapes are commented out. The default shapes provided could be used to generate results from Figures 16-19 in the paper.

4. To verify the constrained minimization of energy using the optimal turning radius and velocity, contour plots could be made using the function ContourPlotting([x1,y1], [x2,y2], para), where [x1,y1] and [x2,y2] are the coordinates of the starting and ending point respectively. Uncomment the Contour Plotting of Energy Consumption section in Crop_Monitoring.m to generate Figures 14 to 15 in the paper. 

5. Obtain information about the flight path in the flight path specification section. This includes plots for V, R and type of each turn, the total energy consumption and distance travelled in the mission and the flying altitude.

6. To verify the kinematic constraints of the aircraft, you could also use the function ClCalculation(V,R,para) and n_calculator(V,R,para) to find out the lift coefficient and load factor during a turn of velocity V and turning radius R.

7. To verify the photo coverage of the flight path, use the Photo Coverage of the Mission section in Crop_monitoring_Project to plot a graph showing the straight flight paths where photos are taken and the area coverage of the photos. 

8. To compare our algorithm with the classic brute force method in solving the travelling salesman problem, run Algorithm_Evaluation.m to obtain Figure 20 and 22 in the paper.
