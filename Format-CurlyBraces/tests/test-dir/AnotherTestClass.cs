using My.Test.Using;

namespace My.Test.Namespace
{
    public class MyClass
    {
        public MyClass()
        {

        }

        public void MyInvalidTestMethod()
        {
            if(myInvalidTestParam)
            {
                MyInvalidTestFunction();
            }
        }

        public void MyFunction()
        {
            if (myTestParam)
                MyFunction();
        }
    }
}