##__ Original : Norm Matloff's  "Art of R ..."  Code/Ch7/envexample1.R

###--- Lexical Scoping ("Syntactic": *where* is the function defined) -----------------------
##
## h() finds 'd' inside f()  and finds 'w'   in  globalenv()
f <- function(y, try.rm=FALSE) {
    h <- function() {
        print(ls(environment()))
        if(try.rm) ## gives warning:
            rm(w)
        return(d*(w+y))
    }
    print(ls(environment(h)))
    d <- 8
    ## h's environment is the local environment() of f(); ==> also contains 'd'

    print(environment(h))
    cat("environment(h):              "); print(ls(environment(h)))
    cat("inside f - the same as '(h)':"); print(ls(environment()))
    cat("environment(f) [=globalenv]: "); print(ls(environment(f))) # = Globalenv

    ## return
    h()
}

w <- 10
f(3)
## can we remove 'w' -- no -- hopefully not!
f(4, try.rm = TRUE)
w # still here (of course!)

rm(w)
## Sometimes we think we rather "want"  **dynamic scoping**
## but R uses  "only" "syntactic" aka lexical scoping :
g <- function(a) {
     ## This changes everything
     ##environment(f) <- environment()
        w <- 10
        f(a)
}

g(3) ## --> error:

## w is *not* found:  it is in caller (function)
## but neither in h or f  nor in globalenv
w <- 5
g(3) # works

##------------------ Functions returning Functions ----------------
## --> the result functions are **closures**  (in a stricter sense),
## namely functions with non-trivial environment, or
##
##  Closure :=   function + data  , i.e.
##           =   function + non-trivial environment

## Useful practical example:
?splinefun
?approxfun
?ecdf

example(splinefun) ## runs all code from the *help* page  'Examples' section

s0 ## prints .... last line:
## <environment: ......>   i.e., *not* the globalenv
## Looking at the function body:  where's the funny  'z'  from ??

ls( environment(s0) ) # aha, from the environment
ls.str( environment(s0) )
spl
