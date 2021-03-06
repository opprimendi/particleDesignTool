package away3d.loaders.parsers.particleSubParsers.values.oneD
{
	import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
	import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
	import away3d.loaders.parsers.particleSubParsers.values.setters.oneD.OneDRandomSetter;
	
	/**
	 * ...
	 */
	public class OneDRandomVauleSubParser extends ValueSubParserBase
	{
		
		public function OneDRandomVauleSubParser(propName:String)
		{
			super(propName, VARIABLE_VALUE);
		}
		
		override public function parseAsync(data:Object, frameLimit:Number = 30):void
		{
			super.parseAsync(data, frameLimit);
			_setter = new OneDRandomSetter(_propName, _data.min, _data.max);
		}
		
		public static function get identifier():Object
		{
			return AllIdentifiers.OneDRandomVauleSubParser;
		}
	
	}

}
