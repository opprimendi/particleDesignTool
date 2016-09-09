package away3d.loaders.parsers.particleSubParsers.nodes
{
	import away3d.animators.data.ParticlePropertiesMode;
	import away3d.animators.nodes.ParticleBezierCurveNode;
	import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
	import away3d.loaders.parsers.particleSubParsers.AllSubParsers;
	import away3d.loaders.parsers.particleSubParsers.utils.MatchingTool;
	import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
	import flash.geom.Vector3D;
	
	public class ParticleBezierCurveNodeSubParser extends ParticleNodeSubParserBase
	{
		private var _controlValue:ValueSubParserBase;
		private var _endValue:ValueSubParserBase;
		
		public function ParticleBezierCurveNodeSubParser()
		{
			super();
		}
		
		override protected function proceedParsing():Boolean
		{
			if (_isFirstParsing)
			{
				var object:Object = _data.control;
				var Id:Object = object.id;
				var subData:Object = object.data;
				var valueCls:Class = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_THREED_VALUES);
				if (!valueCls)
				{
					dieWithError("Unknown value");
				}
				_controlValue = new valueCls(ParticleBezierCurveNode.BEZIER_CONTROL_VECTOR3D);
				addSubParser(_controlValue);
				_controlValue.parseAsync(subData);
				
				object = _data.end;
				Id = object.id;
				subData = object.data;
				valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_THREED_VALUES);
				if (!valueCls)
				{
					dieWithError("Unknown value");
				}
				_endValue = new valueCls(ParticleBezierCurveNode.BEZIER_END_VECTOR3D);
				addSubParser(_endValue);
				_endValue.parseAsync(subData);
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
			if (_controlValue.valueType == ValueSubParserBase.CONST_VALUE && _endValue.valueType == ValueSubParserBase.CONST_VALUE)
			{
				_particleAnimationNode = new ParticleBezierCurveNode(ParticlePropertiesMode.GLOBAL, _controlValue.setter.generateOneValue() as Vector3D, _endValue.setter.generateOneValue() as Vector3D);
			}
			else
			{
				_particleAnimationNode = new ParticleBezierCurveNode(ParticlePropertiesMode.LOCAL_STATIC);
				_setters[_setters.length] = _controlValue.setter;
				_setters[_setters.length] = _endValue.setter;
			}
		}
		
		public static function get identifier():Object
		{
			return AllIdentifiers.ParticleBezierCurveNodeSubParser;
		}
	}
}
