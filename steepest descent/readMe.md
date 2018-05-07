using gradient descent and scant method.
steepest means that choose the best step size.
***
**OPTIONS(1)**:print result (1=yes,0=no)  
**OPTIONS(2)**: stopping criterion,using difference between x_k+1 and x_k  (10^-4)  
**OPTIONS(3)**: stopping criterion,using difference between g_k+1 and g_k [g_k means gradient in iteration k] (10^-6)  
**OPTIONS(7)**:whether using secant method to find the best step size (1=no,0=yes)  
**OPTIONS(14)**: max iteration (1000)  
**OPTIONS(18)**: fixed step size (1)  
***
**steep_desc('function name1',x_0,OPTIONS)**:  
```
    'function name1': pass a function to a function ('grad' means calculating gradient)    
    x_0: means initial point to start optimization  
    OPTIONS: use to pass some parameter as OPTIONS use to pass some parameter as described above.  
```
***
**Please implement following lines:**
``` Matlab
OPTIONS=zeros(18,1); OPTIONS(1)= 1 ; OPTIONS(2)= 10^-4; OPTIONS(3)= 10^-6;
OPTIONS(7)= 0; OPTIONS(14)= 1000; OPTIONS(18)= 1; 
x = steep_desc('grad',[-2,2]',OPTIONS)
```
```
x = steep_desc('grad',[4,2,-1]',OPTIONS)
```
***
**Result**  
![](https://github.com/Xavier-Pan/Optimization-Theory-and-Application/blob/master/steepest%20descent/%E8%9E%A2%E5%B9%95%E6%88%AA%E5%9C%96%202018-05-07%2011.57.31.png)
