```{r}
summary(cars)
```

```{r, echo=FALSE}
summary(cars)
```

```{r, eval=FALSE}
summary(cars)
```

```{r, results='asis'}
knitr::kable(mtcars)
```

```{r setup, include=FALSE}
knitr::opts_chunk$set(cache=TRUE)
```

```{r engine='Rcpp'}
#include <Rcpp.h>

// [[Rcpp::export]]
int fibonacci(const int x) {
    if (x == 0 || x == 1) return(x);
    return (fibonacci(x - 1)) + fibonacci(x - 2);
}
```

```{r}
fibonacci(10L)
fibonacci(20L)
```
