package away3d.loaders.parsers.particleSubParsers.values.oneD
{
	import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
	import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
	import away3d.loaders.parsers.particleSubParsers.values.setters.oneD.OneDCurveSetter;
	
	public class OneDCurveValueSubParser extends ValueSubParserBase
	{
		public function OneDCurveValueSubParser(propName:String)
		{
			super(propName, VARIABLE_VALUE);
		}
		
		override public function parseAsync(data:Object, frameLimit:Number = 30):void
		{
			super.parseAsync(data, frameLimit);
			_setter = new OneDCurveSetter(_propName, _data.anchorDatas);
		}
		
		public static function get identifier():Object
		{
			return AllIdentifiers.OneDCurveValueSubParser;
		}
	}
}
