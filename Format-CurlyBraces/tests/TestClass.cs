using Test.Using;

namespace Test.Namespace
{
    public class TestClass
    {
        public TestClass()
        {

        }

        public void TestMethod()
        {
            if(testParam)
                TestFunction();
        }

        public void InvalidTestMethod()
        {
            if(invalidTestParam)
            {
                InvalidTestFunction();
            }
        }

        public void AnotherTestMethod()
        {
            if (anotherTestParam)
                AnotherTestFunction();
        }
    }
}