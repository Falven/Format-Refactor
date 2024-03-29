using My.Test.Using;

namespace My.Test.Namespace
{
    public class MyClass
    {
        public MyClass(IMyService myService)
        {
            if(myService != null)
            {
                throw new ArgumentNullException(nameof(myService));
            }

            myService = myService ?? throw new ArgumentNullException(nameof(myService)); 
        }
    }
}



