USING AxUnit;

NAMESPACE TestNamespace
{TestFixture}
CLASS Testing

    {Test}
    METHOD PUBLIC MyTestMethod
        AxUnit.Assert.Equal(actual := TRUE, expected := TRUE);
    END_METHOD
END_CLASS

END_NAMESPACE