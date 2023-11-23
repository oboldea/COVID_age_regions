# COVID_age_regions

This is the main code for the paper

Age-specific transmission dynamics of SARS-CoV-2 during the first two years of the pandemic
by Otilia Boldea, Amir Alipoor, Sen Pei, Jeffrey Shaman, and Ganna Rozhnova

and its Supplement.


For questions related to the code, please email o.boldea@tilburgunivesity.edu

The code is organized as follows:

****************************************************
Main Code/ Code with synthetic train data 
**************************************************** 

- synthetic_mobility.m is the code to generate the synthetic mobility Msynth.mat; the true data, used to generate the results in the paper (output.m) 
  is property of the national railway company National Spoorwegen, and is confidential
- all the other data is publicly available or posted by us with permission from RIVM (Royal Institute for Public Health and Environment). 
  The folder Data contains all this data. The code for construction of the data along with plots and Tables can be found in 
  Supplementary Materials Code/Code for S figures and Tables. The description of how this data is constructed in available in the 
  Supplementary Materials of the above paper

To run the code with synthetic mobility data: 

- run inference.m, which uses the following functions:

- SEIRHS.m - runs the stochastic version of the epidemiology model and an RK4 integration
- transf.m - calculates the time-varying transition function of contacts multiplied by the susceptibility parameter
- waning - calculates the waning of protection parameters in the second compartment set
- initialize - initializes the parameters and the unobserved states
- checkbound_ini - checks initial bounds on unosberved states (for example, S cannot be negative or larger than population)
- checkbound     - checks bounds on unobserved states - after updating (for example, S cannot be negative or larger than population)
- Inflation.m    - performs variance inflation of posterior updates to prevent the filter from collapsing due to lack of variance 
- liki.m         - calculates the marginal posterior (quasi-)likelihood of the model based on the ensemble adjustment Kalman filter

- the dataset movNSperc.mat (generated for Figures S11 and S19) contains percentage change in National train mobility compared to pre-pandemic levels 
  and is used by the function synthetic_mobility.m (note that instead, Google mobility data could be used, but priors on parameters theta would likely need
  adjustment)
- the dataset CBSprov.mat contains in cloumn 4 the number of people living in province i and working in j, and is downloaded from CBS (Central Bureau of Statistics)
  https://www.cbs.nl/nl-nl/cijfers/detail/83628NED#shortTableDescription   - use year 2018, first published in 2020. 

****************************************************
Main Code/ Output files 
**************************************************** 

- contains output.m, main output in the paper
- output_synth.m, output with synthetic train mobility data

****************************************************
Main Code/ Code for Main Text Figures 
**************************************************** 

- contains code for reproducing Figures in the main text

****************************************************
Supplementary Materials Code
**************************************************** 
- contains two folders. 
- The folder "Code for S Figures and Tables" contains code for constructing all the data used in the main code, as well as code for reproducing
  the Tables and Figures in the Supplementary Materials of the paper, labeled "S"
- The folder "Code for A Figures and Tables" contains code for repoducing the figures and tables in the Supplementary Materials labeled "A"

****************************************************
Main Text Figures
**************************************************** 
- contains all the figures in the main text of the paper

****************************************************
Supplementary Figures
**************************************************** 
- contains all the figures in the Supplement



