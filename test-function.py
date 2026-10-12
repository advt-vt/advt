#PLANNING
# Rayyan -set up MAVSDK 
# Fleur - quickly setup headless gazebo to make this work
# goal: set up the fuondation & create a function

from mavsdk import System

drone = System() # creates a drone object to be the entry point for other MAVSDK functions in the script

await drone.connect()

await drone.action.arm()
await drone.action.takeoff()
