library(rvest)
library(httr)
library(openxlsx)

httr::set_config(httr::config(http_version = 0))
argv1<-commandArgs(trailingOnly = T) # argv1[1]=input path+name argv1[2]=output path+name


if(argv1[1]=='help'|argv1[1]=='h'|argv1[1]=='H'){
  print('Rscript SCOFIELD.R ./test_mat.txt ./test_out.txt')

}else{

file_form<-strsplit(argv1[1],'[.]')[[1]]
if(file_form[length(file_form)]=='xlsx'){
  Drug_mat<-read.xlsx(argv1[1])
  Drug_mat<-Drug_mat[,1]
}
if(file_form[length(file_form)]=='txt'){
  Drug_mat<-read.table(argv1[1],sep='\t',header=T,stringsAsFactors = F)
  Drug_mat<-Drug_mat[,1]
}


result1<-NULL
search_d<-c()
out1=c()
a=1
for(d in Drug_mat){
  a=a+1
  print(paste0(a,'/',length(Drug_mat)))
dat=GET(sprintf('https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/name/%s/property/MolecularFormula,MolecularWeight,InChIKey,CanonicalSMILES,IsomericSMILES/',d))
r_html<-content(dat,encoding = 'UTF-8')
xml_c<-r_html %>% xml_child() %>% xml_children()
name=xml_name(xml_c)
if(length(name)!=0){
  nc=length(name);cl=name
  search_d<-c(search_d,d)
value=xml_contents(xml_c)
result<-data.frame(Value=html_text(value),row.names = name)
result1<-rbind.data.frame(result1,t(result))
}else{
  out1<-c(out1,d)
}
}
rownames(result1)<-search_d
mat<-matrix('not_info',nrow=length(out1),ncol = nc,dimnames = list(out1,cl))
result2<-rbind.data.frame(result1,mat)
write.table(result2,argv1[2],sep='\t',quote = F)

}
