# realtimeCSM

This project is a simple demo of real-time correlative scan matching writing in Matlab. I use Branch and Bound method to help search the optimal solution.

## Main Function Description

1. `Demo.m` ---- The main function.

2. `BruteMatch.m` ----  Brute Force scan matching. 

   Register current scan to the Map. Map is generalized by a fine resolution with a grid of 0.03 m. Likelihood is also saved in the grid map (approximately use Euclidean distance). 

   3D (theta, x, y) pose voxel is traversed with a resolution of [0.01; 0.01; deg2rad(0.2)];

3. `Matching.m` ---- 2-level scan matching.

   Register current scan to the Map. Two maps under different resolutions are generalized (0.3 m and 0.03 m). Likelihood is also saved in the grid map (approximately use Euclidean distance). 

   Map in low resolution is updated by corresponding maximum likelihood in the high resolution map, see `keepHighLikelihood.m`

   3D (theta, x, y) pose voxel is firstly traversed with a coarse resolution of [0.3; 0.3; deg2rad(3)], which is the same as the map resolution. Then a fine traversing is adapted. The resolution is divided by **Ratio = low resol / high resol**.

4. `multiMatching.m` ---- Multi-level scan matching.

   The level of map resolution is adjustable. Currently, the descend scale of each level is intuitively set to 2.

   The pose is optimized by finding the maximum likelihood as the level increases.

5. `nTo1Matching.m` ---- Many-to-one scan matching. <span style="color:red">Not finished yet</span>`

   The result of this function is not correct.

## How to run

In the main function, run `Demo`.

Tuning *method = n* to compare different methods, where:

​	n = 1 ---- Brute force

​    n = 2 ---- 2-level

​    n = 3 ---- Multi-level	* tuning *nLevel=m* to change the the resolution layers.

(   n = 4 ---- Many-to-one   )

## 



### Reference

[1] E. B. Olson, “Real-time correlative scan matching,” in *2009 IEEE International Conference on Robotics and Automation*, May 2009, pp. 4387–4393, doi: [10.1109/ROBOT.2009.5152375](https://doi.org/10.1109/ROBOT.2009.5152375).

[2] E. Olson, “M3RSM: Many-to-many multi-resolution scan matching,” in *2015 IEEE International Conference on Robotics and Automation (ICRA)*, May 2015, pp. 5815–5821, doi: [10.1109/ICRA.2015.7140013](https://doi.org/10.1109/ICRA.2015.7140013).

[3] S. Thrun, W. Burgard, and D. Fox, “A real-time algorithm for mobile robot mapping with applications to multi-robot and 3D mapping,” in *Proceedings 2000 ICRA. Millennium Conference. IEEE International Conference on Robotics and Automation. Symposia Proceedings (Cat. No.00CH37065)*, San Francisco, CA, USA, 2000, vol. 1, pp. 321–328, doi: [10.1109/ROBOT.2000.844077](https://doi.org/10.1109/ROBOT.2000.844077).

[4] W. Hess, D. Kohler, H. Rapp, and D. Andor, “Real-time loop closure in 2D LIDAR SLAM,” in *2016 IEEE International Conference on Robotics and Automation (ICRA)*, Stockholm, Sweden, May 2016, pp. 1271–1278, doi: [10.1109/ICRA.2016.7487258](https://doi.org/10.1109/ICRA.2016.7487258).