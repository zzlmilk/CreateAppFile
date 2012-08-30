require "json"

#puts "---------begin------------输入要生成的文件名字,请告诉我你的json.txt是在那里"

puts "-------------------begin--------------------------"
puts "please input model file name"
fileName = gets


puts "please tell json.txt address (defalut ./josn.tex)"
jsonPath = gets



 #read json
dic = IO.read(jsonPath.strip+"/json.txt")

#parse json to hash
dic =JSON.parse(dic)



def covertObject(key,value)
		if value.class ==String
			ret = "@property(strong,nonatomic)NSString *"+key
		elsif value.class ==TrueClass			
			ret = "@property(nonatomic)BOOL "+key
		elsif value.class ==Fixnum
			ret = "@property(nonatomic)NSInteger "+key
		elsif value.class ==Hash
			ret = "@property(strong,nonatomic)NSMutableArray *"+key
		end
		
	return ret
end


def covertAttributes(key,value)
		if value.class ==String
			ret = "_"+key+' = [attributes objectForKey:@"'+key+'"]'+";\n"
		elsif value.class ==TrueClass			
			ret =  "_"+key+' = [[attributes objectForKey:"'+key+'"] boolValue]'+";\n"
		elsif value.class ==Fixnum
			ret = "_"+key+' = [[attributes objectForKey:@"'+key+'"] intValue]'+";\n"
		elsif value.class ==Hash
			ret = "_"+key+' = [attributes objectForKey:"'+key+'"]'+";\n"
		end
		
	return ret
end


line = fileName.strip

a_h =
 "#import <Foundation/Foundation.h>
@interface #{line} : NSObject
{
}
"


b_h = 
'
#import "#{line}.h"

@implementation #{line}

'
dic.each{|key ,value|
	a_h = a_h +covertObject(key,value)+";\n"
	b_h = b_h +"@synthesize "+ key+" = _"+key+";\n"
	
}

a_h+="
- (id)initWithAttributes:(NSDictionary *)attributes;

end
"

tmp=""
dic.each{ |key ,value|
	tmp+= covertAttributes(key,value)
}

b_h+="
- (id)initWithAttributes:(NSDictionary *)attributes{
if (self==[super init]) {
#{tmp}	
 }
	return self;
}

end
"

File.open("#{line}.h", "w") do |f|     
f.write(a_h)   
end

File.open("#{line}.m", "w") do |f|     
f.write(b_h)   
end


puts "sucessful already create #{line}.h and #{line}.m at current  end "

 









 
 


