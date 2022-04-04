  deltaCT = function(x,y){
  dat_list = replicate(length(unique(x$gene)), data.frame(CT=(replicate(9,1)), sample = factor(c(rep(1,3),rep(2,3),rep(3,3)))), simplify = FALSE)
  dat_list2 = replicate(length(unique(x$gene)), data.frame(meanCT=(replicate(3,1)), sample = factor(c(rep(1,1),rep(2,1),rep(3,1))), deltactActin = rep(3,1),deltactElfa1 = rep(3,1)), simplify = FALSE)
  dat_list = setNames(dat_list, unique(x$gene))
  dat_list2 = setNames(dat_list2, unique(x$gene))
  
  dat_list3 = replicate(length(unique(y$gene)), data.frame(CT=(replicate(9,1)), sample = factor(c(rep(1,3),rep(2,3),rep(3,3)))), simplify = FALSE)
  dat_list4 = replicate(length(unique(y$gene)), data.frame(meanCT=(replicate(3,1)), sample = factor(c(rep(1,1),rep(2,1),rep(3,1))), deltactActin = rep(3,1),deltactElfa1 = rep(3,1),deltadelta = rep(3,1)), simplify = FALSE)
  dat_list3 = setNames(dat_list3, unique(y$gene))
  dat_list4 = setNames(dat_list4, unique(y$gene))
  
  for (i in unique(x$gene)){
    dat_list[[i]]$CT = x$ct[x$gene == i]
    dat_list2[[i]]$meanCT[dat_list2[[i]]$sample == 1] = mean(dat_list[[i]]$CT[dat_list[[i]]$sample == 1])
    dat_list2[[i]]$meanCT[dat_list2[[i]]$sample == 2] = mean(dat_list[[i]]$CT[dat_list[[i]]$sample == 2])
    dat_list2[[i]]$meanCT[dat_list2[[i]]$sample == 3] = mean(dat_list[[i]]$CT[dat_list[[i]]$sample == 3])
    dat_list2[[i]]$deltactActin = dat_list2[[i]]$meanCT - dat_list2$ACTB$meanCT
    dat_list2[[i]]$deltactElfa1 = dat_list2[[i]]$meanCT - dat_list2$ELFA1$meanCT
    
  dat_list3[[i]]$CT = y$ct[y$gene == i]
  dat_list4[[i]]$meanCT[dat_list4[[i]]$sample == 1] = mean(dat_list3[[i]]$CT[dat_list3[[i]]$sample == 1])
  dat_list4[[i]]$meanCT[dat_list4[[i]]$sample == 2] = mean(dat_list3[[i]]$CT[dat_list3[[i]]$sample == 2])
  dat_list4[[i]]$meanCT[dat_list4[[i]]$sample == 3] = mean(dat_list3[[i]]$CT[dat_list3[[i]]$sample == 3])
  dat_list4[[i]]$deltactActin = dat_list4[[i]]$meanCT - dat_list4$ACTB$meanCT
  dat_list4[[i]]$deltactElfa1 = dat_list4[[i]]$meanCT - dat_list4$ELFA1$meanCT
  dat_list4[[i]]$deltadelta = dat_list2[[i]]$deltactActin - dat_list4[[i]]$deltactActin}
  
  return(dat_list4)}
