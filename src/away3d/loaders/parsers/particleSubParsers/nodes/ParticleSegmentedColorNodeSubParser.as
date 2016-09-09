package away3d.loaders.parsers.particleSubParsers.nodes
{
	import away3d.animators.data.ColorSegmentPoint;
	import away3d.animators.data.ParticlePropertiesMode;
	import away3d.animators.nodes.ParticleSegmentedColorNode;
	import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
	import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
	import away3d.loaders.parsers.particleSubParsers.values.color.CompositeColorValueSubParser;
	import away3d.loaders.parsers.particleSubParsers.values.color.ConstColorValueSubParser;
	import away3d.loaders.parsers.particleSubParsers.values.oneD.OneDConstValueSubParser;
	import flash.geom.ColorTransform;
	
	public class ParticleSegmentedColorNodeSubParser extends ParticleNodeSubParserBase
	{
		private var _startColorValue:ConstColorValueSubParser;
		private var _endColorValue:ConstColorValueSubParser;
		private var _segmentPoints:Array;
		private var _usesMultiplier:Boolean;
		private var _usesOffset:Boolean;
		
		
		public function ParticleSegmentedColorNodeSubParser()
		{
			super();
		}
		
		override protected function proceedParsing():Boolean
		{
			if (_isFirstParsing)
			{
				_usesMultiplier = _data.usesMultiplier;
				_usesOffset = _data.usesOffset;
				
				
				var object:Object;
				var Id:Object;
				var subData:Object;
				
				object = _data.startColor;
				//Id = object.id;
				subData = object.data;
				_startColorValue = new ConstColorValueSubParser(null);
				addSubParser(_startColorValue);
				_startColorValue.parseAsync(subData);
				
				object = _data.endColor;
				//Id = object.id;
				subData = object.data;
				_endColorValue = new ConstColorValueSubParser(null);
				addSubParser(_endColorValue);
				_endColorValue.parseAsync(subData);
				
				_segmentPoints = new Array;
				var pointsData:Array = _data.segmentPoints;
				for (var i:int; i < pointsData.length; i++)
				{
					var colorValue:ConstColorValueSubParser = new ConstColorValueSubParser(null);
					addSubParser(colorValue);
					_segmentPoints[_segmentPoints.length] = {life: pointsData[i].life, color: colorValue};
					colorValue.parseAsync(pointsData[i].color.data);
				}
				_segmentPoints.sortOn("life", Array.NUMERIC | Array.CASEINSENSITIVE);
				//make sure all life values are different
				for (i = 0; i < pointsData.length - 1; i++)
				{
					if (_segmentPoints[i].life == _segmentPoints[i + 1].life)
						_segmentPoints[i].life -= 0.00001 * (pointsData.length - i);
				}
			}
			
			if (super.proceedParsing() == PARSING_DONE)
			{
				initProps();
				return PARSING_DONE;
			}
			else
				return MORE_TO_PARSE;
		}
		
		private function initProps():void
		{
			var segmentPoints:Vector.<ColorSegmentPoint> = new Vector.<ColorSegmentPoint>;
			var len:int = _segmentPoints.length;
			var len2:int = segmentPoints.length;
			var i:int;
			for (; i < len; i++)
			{
				segmentPoints[len2++] = new ColorSegmentPoint(_segmentPoints[i].life, _segmentPoints[i].color.setter.generateOneValue() as ColorTransform);
			}
			_particleAnimationNode = new ParticleSegmentedColorNode(_usesMultiplier, _usesOffset, len, _startColorValue.setter.generateOneValue() as ColorTransform, _endColorValue.setter.generateOneValue() as ColorTransform, segmentPoints);
		}
		
		public static function get identifier():Object
		{
			return AllIdentifiers.ParticleSegmentedColorNodeSubParser;
		}
	}
}
