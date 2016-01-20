```{r}
summary(cars)
fibonacci(10L)
```

```{r, echo=FALSE}
summary(cars)
```

<!-- TODO needs commas as separators -->
```{r echo=FALSE eval=FALSE}
summary(cars)
```

```{r just_a_label}
summary(cars)
```

```{r, results='asis', invalid='123', child=NULL, eval=FALS}
knitr::kable(mtcars)
```

```{r label, include=FALSE, invalid='abc'}
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
