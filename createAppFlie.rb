#生成app 项目所需文件 



# Dir.chdir("/app")  #chage worke file

#define create files name

fileArray = ["Controllers","Models","Classes","View","ThirdParty"]

Dir::chdir("/Users/zzlmilk/Desktop/textQA/textQA") #chang current working-file 

fileArray.each{|file|  
	if !File.exist?(file)
		Dir::mkdir file
	end
 }
 
 

 






