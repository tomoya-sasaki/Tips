# lme4

## Examples with multi-level model
* Reference [here](https://stats.stackexchange.com/questions/395801/multilevel-model-with-4-levels)
* Four level model where student is nested in course, course is nested in faculty, and faculty is nested in school

```
set.seed(15)
library(lme4)
dt1 <- data.frame(expand.grid(SchoolID = LETTERS[1:6], FacultyID = LETTERS[1:6], CourseID = LETTERS[1:10], StudentID = 1:100, Score = c(NA, NA, NA)))
dt1$Score <- as.numeric(dt1$SchoolID) + as.numeric(dt1$FacultyID) + as.numeric(dt1$CourseID) + as.numeric(dt1$StudentID) + rnorm(nrow(dt1), 0,5)
lmm1 <- lmer(Score ~ 1 + (1 | SchoolID/FacultyID/CourseID/StudentID), data = dt1)
summary(lmm1)  

# the same as above
dt1.1 <- dt1
dt1.1$FacultyID <- paste(dt1$SchoolID, dt1$FacultyID, sep = ".")
dt1.1$CourseID <- paste(dt1.1$FacultyID, dt1$CourseID, sep = ".")
dt1.1$StudentID <- paste(dt1.1$CourseID, dt1$StudentID, sep = ".")
lmm1.1 <- lmer(Score ~ 1 + (1 | SchoolID) + (1 | FacultyID) + (1 | CourseID) + (1 | StudentID), data = dt1.1)
```