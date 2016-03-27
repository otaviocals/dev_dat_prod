### Database Explorer Manual
#### Writen by Otavio Cals

This application loads either a .csv database or one of the example databases (iris and mtcars) and creates an x-y diagram.
The user can then plot any two columns of the loaded database and add jitter and smooth geoms.

Source code is available on my [GitHub](https://github.com/otaviocals/dev_dat_prod).


Inputs:
* Sample Size: You can adjust the sample size with the slider bar panel from 1 to the maximum size of the data.      
* x and y axes: You can choose the different variables of the data.     
* Color: You can color encode the points according to a variable do the dataset.      
* Jitter: Checkbox for the jitter geom.    
* Smooth: Checkbox to add a smoothed conditional mean geom.      
* Facet Row: The faced to partition data and show graphs in rows.     
* Facet Column: The faced to partition data and show graphs in columns.      

Code description:
* The ggplot2 functions are used to display reactive parts of the output graph:
* aes_string(x=input$x, y=input$y) is used to set x and y axis.
* aes_string(color=input$color) the color is set if required.
* geom_smooth added if required.
* geom_jitter added if required.

### How to run
* Create an app directory in the current working directory.
* Copy server.R, ui.R and include.md into the app directory. Those files can be found at the Github link.
* If Shiny isn't installed, install it running "install.packages("shiny")".
* Load the Shiny library with "library(shiny)".
* Launch the app by running "runApp()".


   






