OPTIONS(1):print result (1=yes,0=no)  
OPTIONS(2): stopping criterion,using difference between x_k+1 and x_k  (10^-4)  
OPTIONS(3): stopping criterion,using difference between g_k+1 and g_k [g_k means gradient in iteration k] (10^-6)  
OPTIONS(5): different choice of beta_k (0,1,2,3)  
  0: Powell  
  1: Fletcher-Reeves  
  2: Polak Ribiere  
  3: Hestenes-Stiefel                
OPTIONS(7):whether using secant method to find the best step size (1=no,0=yes)  
OPTIONS(14): max iteration (1000)  
OPTIONS(18): fixed step size (1)  
LM_newton_method(x_0,OPTIONS):  
  x_0 means initial point to start optimization  
  OPTIONS use to pass some parameter as OPTIONS use to pass some parameter as described above.  
***
Please implement following two lines:
``` Matlab
OPTIONS=zeros(18,1); OPTIONS(1)= 1 ; OPTIONS(2)= 10^-4; OPTIONS(3)= 10^-6;OPTIONS(7)= 1; OPTIONS(14)= 1000; OPTIONS(18)= 1; 
OPTIONS(5) = 1; x = LM_newton_method([-3 3]',OPTIONS)
```
