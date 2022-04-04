qpcrplot = function(x,list,y) {
  dat = read.csv(choose.files(), header = T)
  colnames(dat)[1] = "Well"
  as.factor <-dat$Well
  UsedWells = subset(dat,dat$Well == list)
  dat_list = replicate(length(list),data.frame(well= replicate(x,1),Cycle = factor(1:x),GREEN=(replicate(x,1)),normalised=(replicate(x,1)),CT=(replicate(x,1))),simplify = FALSE)
  dat_list = setNames(dat_list, list)
  for (t in 1:length(list)) {
    dat_list[[t]]$well = replicate(x,list[t])
    dat_list[[t]]$GREEN = UsedWells$GREEN[UsedWells$Well == list[t]]
    dat_list[[t]]$normalised = dat_list[[t]]$GREEN - dat_list[[t]]$GREEN[dat_list[[t]]$Cycle==1]
    dat_list[[t]]$CT = approx(dat_list[[t]]$normalised, dat_list[[t]]$Cycle, xout=y)[2]
    }
  return(dat_list)
 }
