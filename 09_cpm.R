library(tidyr)
library(tidygenomics)
library(ggplot2)
library(reshape2)
library(RColorBrewer)

## BN1A
setwd("/scratch.global/nosha003/atac/align/")
df <- read.delim("BN1A.all.2.uniq.100bpcounts.bed", header=F, sep="\t")
colnames(df) <- c("chrom", "start", "end", "dot", "dot2", "dot3", "id", "count")
# base on total assigned reads (total # reads - # unmapped from samstat output)
tot <- (57292821+70113993+62911887+54359939) / 1000000
df$cpm <- df$count / tot
setwd("/scratch.global/nosha003/atac/counts/metaplot")
write.table(df, "BN1A.all.2.uniq.100bp.cpm2.bed", quote=F, row.names=F, sep="\t")

## MN1A
setwd("/scratch.global/nosha003/atac/align/")
df <- read.delim("MN1A.all.2.uniq.100bpcounts.bed", header=F, sep="\t")
colnames(df) <- c("chrom", "start", "end", "dot", "dot2", "dot3", "id", "count")
# base on total assigned reads
tot <- (51042371+76102604+61694409+84904631) / 1000000
df$cpm <- df$count / tot
setwd("/scratch.global/nosha003/atac/counts/metaplot")
write.table(df, "MN1A.all.2.uniq.100bp.cpm2.bed", quote=F, row.names=F, sep="\t")

## ON1A
setwd("/scratch.global/nosha003/atac/align/")
df <- read.delim("ON1A.all.2.uniq.100bpcounts.bed", header=F, sep="\t")
colnames(df) <- c("chrom", "start", "end", "dot", "dot2", "dot3", "id", "count")
# base on total assigned reads
tot <- (31873696+36696893+37292421+37247623) / 1000000
df$cpm <- df$count / tot
setwd("/scratch.global/nosha003/atac/counts/metaplot")
write.table(df, "ON1A.all.2.uniq.100bp.cpm2.bed", quote=F, row.names=F, sep="\t")

## WN1A
# cut -f 1-3,18-21,5 WN1A.all.uniq.100bpbins.bed > WN1A.all.uniq.100bpbins.cut.bed
setwd("/scratch.global/nosha003/atac/align")
df <- read.delim("WN1A.all.uniq.100bpbins.cut.bed", header=F, sep="\t")
colnames(df) <- c("chrom", "start", "end", "count", "dot", "dot2", "dot3", "id")
#df <- df[,c(1:3, 18:21, 5)]
#colnames(df) <- c("chrom", "start", "end", "dot", "dot2", "dot3", "id", "count")
# base on total assigned reads
tot <- (58264643+67762132+99389431) / 1000000
df$cpm <- df$count / tot
df2 <- df[,c(1:3,5:8,4,9)]
setwd("/scratch.global/nosha003/atac/counts/metaplot")
write.table(df2, "WN1A.all.2.uniq.100bp.cpm2.bed", quote=F, row.names=F, sep="\t")
