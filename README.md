# Back to first principles: Scientific Computing

In my first years of working as a **data scientist**, it has been a joy solving problems with high-level packages in R and Python, such as `data.table`, the `tidyverse`, `numpy`, `pandas`, and distributed technologies such as `Apache Beam`, `BigQuery`.

However, I've encountered a lot of **non-standard**, **nonembarassingly parallel/vectorizable** problems and **nested data**, feeling like trying to fit tools for the problems they weren't designed to solve. Moreover, the models appropriate for the challenges, more often than not, weren't easily translatable into a machine learning formulation.

Going contrary to the industry trends, I believe that a data scientist should have a wider set of tools *(outside the conventional ones)*, including, but not limited to:

* Bayesian Statistics and stochastic models
* Optimization and Operations Research
* Time Series and sinal processing
* Scientific computing, building custom models and algorithms
* Being able to deploy a full-stack application for decision-support, which has some element of applied mathematics.


> Therefore, **scientific computing** is the backbone of enabling a proefficient data scientist to solve problems which were "untouchable" before, either because of production and scale challenges or the (time)  investment of developing new, innovative solutions from scratch


## It's not your parents' FORTAN

I've always been deeply uncomfortable with low-level languages, and (still) belive the only way a generalist can get away with being a jack of all trades, is to be a productive problem-solver and bring value/insight, then asking specialists for help when stuck or needing their expertise.

So, to get over the prejudices and fears, I wanted to go back to the first principles, and delightfully discovered that `modern fortran` is an elegant, specialized language, which fits my way of thinking and problems I'm interested in better than C/C++. Fortran gets a bad rap in CS departments and among programmers, but in my context, most of those criticisms do not hold, especially for `f08` and `f18`.