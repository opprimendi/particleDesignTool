package away3d.loaders.parsers.particleSubParsers.nodes
{
	
	import away3d.animators.data.ParticlePropertiesMode;
	import away3d.animators.nodes.ParticleRotationalVelocityNode;
	import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
	import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
	import away3d.loaders.parsers.particleSubParsers.values.fourD.FourDCompositeWithThreeDValueSubParser;
	import flash.geom.Vector3D;
	
	public class ParticleRotationalVelocityNodeSubParser extends ParticleNodeSubParserBase
	{
		private var _rotationValue:FourDCompositeWithThreeDValueSubParser;
		
		public function ParticleRotationalVelocityNodeSubParser()
		{
		}
		
		override protected function proceedParsing():Boolean
		{
			if (_isFirstParsing)
			{
				var object:Object = _data.rotation;
				var Id:Object = object.id;
				var subData:Object = object.data;
				_rotationValue = new FourDCompositeWithThreeDValueSubParser(ParticleRotationalVelocityNode.ROTATIONALVELOCITY_VECTOR3D);
				addSubParser(_rotationValue);
				_rotationValue.parseAsync(subData);
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
			if (_rotationValue.valueType == ValueSubParserBase.CONST_VALUE)
			{
				_particleAnimationNode = new ParticleRotationalVelocityNode(ParticlePropertiesMode.GLOBAL, _rotationValue.setter.generateOneValue() as Vector3D);
			}
			else
			{
				_particleAnimationNode = new ParticleRotationalVelocityNode(ParticlePropertiesMode.LOCAL_STATIC);
				_setters[_setters.length] = _rotationValue.setter;
			}
		}
		
		public static function get identifier():Object
		{
			return AllIdentifiers.ParticleRotationalVelocityNodeSubParser;
		}
	}
}
