package ca.usask.gmcte.currimap.model.to;

@SuppressWarnings("serial")

public class ObjectPair implements java.io.Serializable
{

	private Object a;
	private Object b;

	public ObjectPair(Object a, Object b)
	{
		this.a = a;
		this.b = b;
	}

	public Object getA()
	{
		return a;
	}

	public void setA(Object o)
	{
		this.a = o;
	}

	public Object getB()
	{
		return b;
	}

	public void setB(Object o)
	{
		this.b = o;
	}
		
}
