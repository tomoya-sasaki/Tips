# Check current directory
```
import os
cwd = os.getcwd()
```

## Obtain environment
Especially important when you use cluster computer and use array task. At least in Adroit (Princeton), this works and it returns the number of arrays you use for the task. It should correspond to the number of array you specify when you submit a job. 
 
```
import os
print(os.getenv('SLURM_ARRAY_TASK_ID'))
```
