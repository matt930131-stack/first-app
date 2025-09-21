struct baby{
    let star:String
    var name:String
    
    func sleep(){
        print("😭")
    }
}
var goodbaby=baby(star:"水瓶座",name:"Matt")
goodbaby.name="Ian"
print(goodbaby.name)
goodbaby.sleep()
