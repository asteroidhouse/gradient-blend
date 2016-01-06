# Gradientblend

This is a fairly fast Matlab implementation of gradient-domain blending (aka Poisson blending).
For details about the approach, see [the original paper](https://www.cs.jhu.edu/~misha/Fall07/Papers/Perez03.pdf).

# Examples

Source | Mask | Target | Result
------ | ---- | ------ | ------
![Ice Cream](examples/SadCat_IceCream/input_spilled_cone.jpg) | ![Ice Cream Mask](examples/SadCat_IceCream/sad_cat_cone_mask.png) | ![Sad Cat](examples/SadCat_IceCream/input_sad_cat.jpg) | ![Sad Cat Cone Result](examples/SadCat_IceCream/sad_cat_cone_result.png)
![Phelps](examples/PhelpsPool/input_phelps1.jpg) | ![Phelps Mask](examples/PhelpsPool/phelps_pool_mask.png) | ![Pool](examples/PhelpsPool/input_pool1.jpg) | ![Phelps Pool Result](examples/PhelpsPool/phelps_pool_result.png)
![Bentley](examples/CarOnMoon/input_car.jpg) | ![Bentley Mask](examples/CarOnMoon/car_moon_mask.png) | ![Moon](examples/CarOnMoon/input_moon.jpg) | ![Bentley on the Moon](examples/CarOnMoon/car_moon_result.png)
![Lady](examples/LadyInAntarctica/input_dress.jpg) | ![Lady Mask](examples/LadyInAntarctica/dress_antarctica2_mask.png) | ![Antarctica](examples/LadyInAntarctica/input_antarctica2.jpg) | ![Lady in Antarctica](examples/LadyInAntarctica/dress_antarctica2_result.png)
