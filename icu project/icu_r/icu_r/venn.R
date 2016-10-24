venn.plot <- draw.pairwise.venn(100, 70, 30, c("First", "Second"))
grid.draw(venn.plot)


venn.plot <- draw.pairwise.venn(
  area1 = 100,
  area2 = 70,
  cross.area = 0,
  category = c("First", "Second"),
  cat.pos = c(0, 180),
  euler.d = TRUE,
  sep.dist = 0.03,
  rotation.degree = 45
);


library("multtest"); library("annaffy"); library("hgu95av2.db");library("ALL");
data(ALL, package = "ALL")
ALLB <- ALL[,ALL$BT %in% c("B1","B2","B3","B4")]
f1 <- function(x) (shapiro.test(x)$p.value > 0.05)
sel1 <- genefilter(exprs(ALL[,ALLB$BT=="B1"]), filterfun(f1))
sel2 <- genefilter(exprs(ALL[,ALLB$BT=="B2"]), filterfun(f1))
sel3 <- genefilter(exprs(ALL[,ALLB$BT=="B3"]), filterfun(f1))
sel4 <- genefilter(exprs(ALL[,ALLB$BT=="B4"]), filterfun(f1))
selected <- sel1 & sel2 & sel3 & sel4

library(limma)
# Three-set Venn diagram
  x <- matrix(as.integer(c(sel2,sel3,sel4)),ncol = 3,byrow=FALSE)
colnames(x) <- c("sel2","sel3","sel4")
vc <- vennCounts(x, include="both")
vennDiagram(vc)

