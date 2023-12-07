# Reproducible research: version control and R

**Questions 1, 2 and 3 link:**

**Question 4**

*A script for simulating a random_walk is provided in the question-4-code folder of this repo. Execute the code to produce the paths of two random walks. What do you observe? (10 points)*    
The code creates two 2D random walk plots with 500 steps each, comparing them side by side. Each plot is independent of each other and a change in one plot does not affect the other. In both plots, the starting point of the walk is centred at the origin. Moreover, each step in a walk is represented by a line segment whereby the colour (from light blue to dark blue) of the line segment correlates to the time step (from 0 to 500 steps).  
However, both walks do not follow the same paths as the walks reach 500 steps as random angles are created at each step. 

*Investigate the term random seeds. What is a random seed and how does it work? (5 points)*  
A random seed is a base value (or vector) used by a pseudorandom generator to initiate a random number generator. In R a random seed  with a specified seed value is set with *set.seed()* function. It ensures the reproducibility of the sequence of random numbers as it guarantees that the sequence of random numbers is constant across different runs of the code. An example of how this works  can be seen in the code below:  

*set.seed(123)  
rnorm(5) #0.1  0.2  0.3  0.4  0.5*  

*set.seed(123)  
rnorm(5) #0.1  0.2  0.3  0.4  0.5*  

As the same seed is set twice, the same 5 random numbers are generated each time the code is run.    

*Edit the script to make a reproducible simulation of Brownian motion. Commit the file and push it to your forked reproducible-research_homework repo. (10 points)*   
Find it in the question-4-code folder in reproducible-research_homework repo.  

*Go to your commit history and click on the latest commit. Show the edit you made to the code in the comparison view (add this image to the README.md of the fork). (5 points)*  
![CAPTION](https://github.com/aminahmemon/reproducible-research_homework/blob/7290d741eced0b17ac5bdc2b5f41513445841257/Commit_history_comparison.png)

**Question 5**  
I have also uploaded a file called 'Q5.Rmd' into the repo containing all the code to answer the following questions, as well as including the code below.  

*How many rows and columns does the table have? (3 points)*  
There are 34 rows and 13 columns in the table.  

*What transformation can you use to fit a linear model to the data? Apply the transformation (3 points)*   
You can log transform the data by applying the natural logarithm to the data. The code can be seen below:   

#Applying the log transformation:  
columns_to_log <- c("Virion volume (nm×nm×nm)", "Genome length (kb)") #We only want to transform Virion volume and Genome length, so we remove the other columns  
transformation <- log(Cui_etal2014[, columns_to_log])

*Find the exponent (α) and scaling factor (β) of the allometric law for dsDNA viruses and write the p-values from the model you obtained, are they statistically significant? Compare the values you found to those shown in Table 2 of the paper, did you find the same values? (10 points)*  
When rounded up, the exponent (α) and scaling factor (β) of the allometric law for dsDNA viruses I found are the same as those in Table 2 of the paper. The code to find this is below:  

linear_model <- lm(transformation) #Fitting linear model to data  
exponent <- coef(linear_model)[2]  
scaling_factor <- exp(coef(linear_model)[1])  

cat("Exponent (alpha):", exponent, "\n")  
cat("Scaling Factor (beta):", scaling_factor, "\n")  

The p-values obtained are as follows:   
- Intercept p-value = 2.28 x 10<sup>-10</sup>  
- Slope for genome length p-value = 6.44 x 10<sup>-10</sup>  

They are statistically significant as they are both smaller than 0.005.   

*Write the code to reproduce the figure shown below. (10 points)*  
ggplot(linear_model, aes(x = `Virion volume (nm×nm×nm)`, y = `Genome length (kb)`)) +  
  geom_point() +  
  geom_smooth(method = "lm", se = TRUE, fill = "grey58", colour = "royalblue2", linewidth = 0.7) + #adding a blue linear regression line and a grey 95% cl  
  labs(x = "log [Genome length (kb)]", y = "log [Virion volume nm3)]") +  
  theme_minimal() +  
  theme(axis.title = element_text(face = "bold")) + #adding bold font to axis titles  
  theme(panel.border = element_rect(colour = "grey42", fill = NA, size = 0.5))    

*What is the estimated volume of a 300 kb dsDNA virus? (4 points)*  
15.71717nm<sup>3</nm>  

The code can be found below:  

log300 <- log(300) #finding log of 300 to align with the log transformed model  
log300  
estimate_volume <- (1.5152*log300) + (7.0748) #using equation of a straight line (y = mx+c) to solve for estimated volume where m = 1.5152 (slope estimate), x = log300 (genome length) and c = 7.0748 (intercept estimate)  

**Bonus (10 points) Explain the difference between reproducibility and replicability in scientific research. How can git and GitHub be used to enhance the reproducibility and replicability of your work? what limitations do they have?**  
Reproducibility is when the authors provide all the necessary data and code to run the scientific analysis again, re-creating the results. However, replicability is a study that arrives at the same scientific findings as another study, collecting new data (potentially with different methods) and completing analyses.  

Both Git and GitHub can increase the reproducibility and replicability of work.  Git offers version control. It is a powerful way to track and compare versions over time, ensuring you can always go back to previous versions. This makes it easier for you to identify when the changes occurred and what they were. Both facilitate collaboration whereby multiple people can work asynchronously and merge their contributions at any time.  
Furthermore, Git and GitHub allow for openly sharing work which promotes open science. It makes research more reproducible, transparent, reusable, collaborative, accountable and accessible to others. Scientists can more easily increase the discoverability and visibility of one's work, allowing access to new data and software resources. This also allows others to scrutinise and build upon your findings to increase replicability.  

There are limitations too. Regarding open science, some scientists may not want to share their work openly because of intellectual property concerns. Some Git limitations include that it may not be able to handle large binary files efficiently which can slow cloning and pushing operations down. GitHub also has size limitations. Moreover, it is costly and its free accounts limit the number of private repositories. It is also dependent on an internet connection to carry out pushing, pulling and cloning repositories which can be challenging when the internet is unavailable. 

## Instructions

The homework for this Computer skills practical is divided into 5 questions for a total of 100 points (plus an optional bonus question worth 10 extra points). First, fork this repo and make sure your fork is made **Public** for marking. Answers should be added to the # INSERT ANSWERS HERE # section above in the **README.md** file of your forked repository.

Questions 1, 2 and 3 should be answered in the **README.md** file of the `logistic_growth` repo that you forked during the practical. To answer those questions here, simply include a link to your logistic_growth repo.

**Submission**: Please submit a single **PDF** file with your candidate number (and no other identifying information), and a link to your fork of the `reproducible-research_homework` repo with the completed answers. All answers should be on the `main` branch.

## Assignment questions 

1) (**10 points**) Annotate the **README.md** file in your `logistic_growth` repo with more detailed information about the analysis. Add a section on the results and include the estimates for $N_0$, $r$ and $K$ (mention which *.csv file you used).
   
2) (**10 points**) Use your estimates of $N_0$ and $r$ to calculate the population size at $t$ = 4980 min, assuming that the population grows exponentially. How does it compare to the population size predicted under logistic growth? 

3) (**20 points**) Add an R script to your repository that makes a graph comparing the exponential and logistic growth curves (using the same parameter estimates you found). Upload this graph to your repo and include it in the **README.md** file so it can be viewed in the repo homepage.
   
4) (**30 points**) Sometimes we are interested in modelling a process that involves randomness. A good example is Brownian motion. We will explore how to simulate a random process in a way that it is reproducible:

   - A script for simulating a random_walk is provided in the `question-4-code` folder of this repo. Execute the code to produce the paths of two random walks. What do you observe? (10 points)
   - Investigate the term **random seeds**. What is a random seed and how does it work? (5 points)
   - Edit the script to make a reproducible simulation of Brownian motion. Commit the file and push it to your forked `reproducible-research_homework` repo. (10 points)
   - Go to your commit history and click on the latest commit. Show the edit you made to the code in the comparison view (add this image to the **README.md** of the fork). (5 points)

5) (**30 points**) In 2014, Cui, Schlub and Holmes published an article in the *Journal of Virology* (doi: https://doi.org/10.1128/jvi.00362-14) showing that the size of viral particles, more specifically their volume, could be predicted from their genome size (length). They found that this relationship can be modelled using an allometric equation of the form **$`V = \beta L^{\alpha}`$**, where $`V`$ is the virion volume in nm<sup>3</sup> and $`L`$ is the genome length in nucleotides.

   - Import the data for double-stranded DNA (dsDNA) viruses taken from the Supplementary Materials of the original paper into Posit Cloud (the csv file is in the `question-5-data` folder). How many rows and columns does the table have? (3 points)
   - What transformation can you use to fit a linear model to the data? Apply the transformation. (3 points)
   - Find the exponent ($\alpha$) and scaling factor ($\beta$) of the allometric law for dsDNA viruses and write the p-values from the model you obtained, are they statistically significant? Compare the values you found to those shown in **Table 2** of the paper, did you find the same values? (10 points)
   - Write the code to reproduce the figure shown below. (10 points)

  <p align="center">
     <img src="https://github.com/josegabrielnb/reproducible-research_homework/blob/main/question-5-data/allometric_scaling.png" width="600" height="500">
  </p>

  - What is the estimated volume of a 300 kb dsDNA virus? (4 points)

**Bonus** (**10 points**) Explain the difference between reproducibility and replicability in scientific research. How can git and GitHub be used to enhance the reproducibility and replicability of your work? what limitations do they have? (e.g. check the platform [protocols.io](https://www.protocols.io/)).
