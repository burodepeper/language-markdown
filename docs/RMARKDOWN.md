```{r}
summary(cars)
fibonacci(10L)
```

```{r, echo=FALSE}
summary(cars)
```

```{r echo=FALSE eval=FALSE}
```

```{r echo=FALSE, eval=FALSE}
```

```{r just_a_label}
summary(cars)
```

```{r, results='asis', results='duh', invalid='123', child=NULL, eval=FALS}
knitr::kable(mtcars)
```

```{r label results='asis', include=FALSE}
```

```{r label, include=FALSE, invalid='abc' results='asis'}
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

```{r engine='foobar'}
```

```{r comment='# '}
```

```{r dev.args=list(bg='yellow', pointsize=10)}
```

<!-- Invalid because multiple spaces -->
```{r,  echo=FALSE}
```

```{r, echo=FALSE   }
```

```{r,echo=FALSE,include=TRUE}
```

```{r, echo=2:3:-4, dpi=100}
```

```{r eval=-(4:5)}
```

```{r tidy.opts=list(blank=FALSE, width.cutoff=60)}
```

```{r eval=c(1, 3, 4)}
```

```{r dependson=c(-1, -2)}
```

```{r foo, dev=c('pdf', 'png')}
```

```{r out.width=3in, out.height='8cm', out.extra='style="display:block;"'}
```

```{r ffmpeg.bitrate=1M, ffmpeg.format='webm'}
```

<!--
TODO
The examples below are rather specific specimens taken from: http://yihui.name/knitr/options/
They have not been implemented yet
-->


```{r cache.rebuild=!file.exists("path/to/file.ext")}
```

```{r dev=c('pdf', 'tiff'), dev.args=list(pdf = list(colormodel = 'cmyk', useDingats = TRUE), tiff = list(compression = 'lzw'))}
```

```{r code=capture.output(dump('fivenum', ''))}
```

```{r fig.cap=paste('p-value is', t.test(x)$p.value)}
```
