qpcrplot = function(x,df,y,z,hk) {
    library(ggplot2)
    dat = read.csv(choose.files(), header = T)
    colnames(dat)[1] = "Well"
    as.factor = dat$Well
    UsedWells = dat[dat$Well %in% df$well,]
    QPCRDATA = replicate(length(df$well),data.frame(well= replicate(x,1),Cycle = factor(1:x),GREEN=(replicate(x,1)),normalised=(replicate(x,1)),gene =(replicate(x,1)), CT=(replicate(x,1))),simplify = FALSE)
    QPCRDATA = setNames(QPCRDATA, df$well)
    well_list = df$well
    gene_list = df$gene
    ct = data.frame(CT=1:length(df$well))
    rownames(ct) = df$well
    ct$gene = df$gene
    ct$sample = factor(df$sample)
    ctlist = list()
    dat2 = dat[(dat$Well %in% well_list),]
    dat2$gene = gene_list
    dat2$sample = factor(rep(df$sample, x))
    dat2$threshold = y
    
    for (i in unique(well_list)) {
      dat2$normalised[dat2$Well == i] = dat2$GREEN[dat2$Well == i] - dat2$GREEN[dat2$Cycle == 1 & dat2$Well ==i ] }
    
     for (t in 1:length(df$well)) {
      QPCRDATA[[t]]$well = replicate(x, well_list[t])
      QPCRDATA[[t]]$gene = replicate(x, gene_list[t])
      QPCRDATA[[t]]$GREEN = UsedWells$GREEN[UsedWells$Well == well_list[t]]
      QPCRDATA[[t]]$normalised = QPCRDATA[[t]]$GREEN - QPCRDATA[[t]]$GREEN[QPCRDATA[[t]]$Cycle==1]
      QPCRDATA[[t]]$CT = approx(QPCRDATA[[t]]$normalised, QPCRDATA[[t]]$Cycle, xout=y)[2]
      ct$CT[[t]] = unique(QPCRDATA[[t]]$CT)
    }
    
    dat_list = replicate(length(unique(ct$gene)), data.frame(CT=(replicate(9,1)), sample = factor(c(rep(1,3),rep(2,3),rep(3,3)))), simplify = FALSE)
    dat_list2 = replicate(length(unique(ct$gene)), data.frame(meanCT=(replicate(3,1)), sample = factor(c(rep(1,1),rep(2,1),rep(3,1)))), simplify = FALSE)
    dat_list = setNames(dat_list, unique(ct$gene))
    dat_list2 = setNames(dat_list2, unique(ct$gene))
    
    for (i in unique(ct$gene)){
      dat_list[[i]]$CT = unlist(ct$CT[ct$gene == i])
      dat_list2[[i]]$meanCT[dat_list2[[hk]]$sample == 1] = mean(dat_list[[i]]$CT[dat_list[[hk]]$sample == 1])
      dat_list2[[i]]$meanCT[dat_list2[[i]]$sample == 2] = mean(dat_list[[i]]$CT[dat_list[[i]]$sample == 2])
      dat_list2[[i]]$meanCT[dat_list2[[i]]$sample == 3] = mean(dat_list[[i]]$CT[dat_list[[i]]$sample == 3])
      dat_list2[[i]]$deltact = dat_list2[[i]]$meanCT - dat_list2[[hk]]$meanCT 
      ctlist[[i]] = (dat_list2[[i]]$deltact)}
      
       
    
    ctlist = data.frame(ctlist)
    
    
    if(missing(z)) {
        return(dat_list2)
    }
    else {
      if (z == "deltact"){
        return(ctlist)
      }}
      if (z == "graph"){
        return(ggplot(data = dat2, aes(x=Cycle, y= normalised)) + geom_line(aes(col=Well)) +
                 geom_hline(yintercept = dat2$threshold, lty = 2, col = "red") +
                 theme_minimal() + facet_wrap(~gene+sample) + 
                 theme(legend.position = "NONE")) }
               
  
      else {
        print("please select one of the following: 'graph' or 'deltact'")
      }
     
   }  
