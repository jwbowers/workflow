##a fork from http://artsci.wustl.edu/~jgill/Models/graph.summary.R


graph.summary <- function (in.object, alpha = 0.05, digits=3) # DESIGNED BY NEAL, CODED BY JEFF, FORKED BY JAKE
{
    lo <- in.object$coefficient - qnorm(1-alpha/2) * summary(in.object)$coef[,2]
    hi <- in.object$coefficient + qnorm(1-alpha/2) * summary(in.object)$coef[,2]
    out.mat <- round(cbind(in.object$coefficient, summary(in.object)$coef[,2], lo, hi),digits)
    blanks <- "                                                                          "
    dashes <- "--------------------------------------------------------------------------"
    bar.plot <- NULL
    scale.min <- floor(min(out.mat[,3])); scale.max <- ceiling(max(out.mat[,4]))
    for (i in 1:nrow(out.mat))  {
        ci.half.length <- abs(out.mat[i,1]-out.mat[i,3])
        ci.start <- out.mat[i,1] - ci.half.length
        ci.stop <- out.mat[i,1] + ci.half.length
        bar <- paste("|",substr(dashes,1,ci.half.length), "o", substr(dashes,1,ci.half.length), "|", sep="", collapse="")
        start.buf <- substr(blanks,1,round(abs(scale.min - ci.start)))
        stop.buf <- substr(blanks,1,round(abs(scale.max - ci.stop)))
        bar.plot <- rbind( bar.plot, paste(start.buf,bar, stop.buf, sep="", collapse="") )
    }
    out.df <- data.frame( matrix(NA,nrow=nrow(out.mat),ncol=ncol(out.mat)), bar.plot[1:length(bar.plot)] )
    out.df[1:nrow(out.mat),1:ncol(out.mat)] <- out.mat
    CI.label <- paste( "CIs:", substr(blanks,1,abs(scale.min)-2-4),"ZE+RO",
        substr(blanks,1,abs(scale.max)-2), sep="", collapse="" )
    dimnames(out.df)[[1]] <- dimnames(summary(in.object)$coef)[[1]]
    dimnames(out.df)[[2]] <- c("Coef","Std.Err.", paste(1-alpha,"Lower"),paste(1-alpha,"Upper"),CI.label)
    if (substr(in.object$call[1],1,2) == "gl")  print(in.object$family)
    if (substr(in.object$call[1],1,2) == "lm")  cat("\nFamily: gaussian\nLink function: identity\n\n")
    print(out.df)
    cat("\n")
    if (substr(in.object$call[1],1,2) == "gl")  {
         cat( paste("N:", length(in.object$y),"   log-likelihood:",round(ncol(out.mat)-in.object$aic/2,digits),
                    "   AIC:",round(in.object$aic,digits),
                    "   Dispersion Parameter:",summary(in.object)$dispersion,"\n") )
         cat( paste("    Null deviance:",round(in.object$null.deviance,digits),"on",in.object$df.null,"degrees of freedom\n") )
         cat( paste("Residual deviance: ",round(in.object$deviance,digits),"on",in.object$df.residual,"degrees of freedom\n") )
    }
    if (substr(in.object$call[1],1,2) == "lm")  {
	 cat( paste("N:",length(in.object$fitted.values),"   Estimate of Sigma:",round(summary(in.object)$sigma,digits),"\n"))

    }
}

##
##dp.97 <- read.table("http://jgill.wustl.edu/data/dp.data",header=TRUE)
##dp.out <- glm(EXECUTIONS ~ INCOME + PERPOVERTY + PERBLACK + log(VC100k96) + SOUTH
##                                  + PROPDEGREE, family=poisson,data=dp.97)
##graph.summary(dp.out)
##
##norr.df <- read.table("http://jgill.wustl.edu/data/norr.dat",header=TRUE)
##norr.out <- lm(d8892r2 ~ catholic+black90+urban90+law3689+ep4089n,data=norr.df)
##graph.summary(norr.out)
