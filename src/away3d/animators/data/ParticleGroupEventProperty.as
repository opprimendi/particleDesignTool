package away3d.animators.data
{
	
	public class ParticleGroupEventProperty
	{
		public static const ANIMATION_GROUP_ENDED:String = "AnimationGroupEnded";
		
		private var _occurTime:Number;
		private var _customName:String;
		
		public function ParticleGroupEventProperty(occurTime:Number, customName:String)
		{
			_occurTime = occurTime;
			_customName = customName;
		}
		
		public function get customName():String
		{
			return _customName;
		}
		
		public function get occurTime():Number
		{
			return _occurTime;
		}
	
		public function toString():String 
		{
			return "[ParticleGroupEventProperty customName=" + customName + " occurTime=" + occurTime + "]";
		}
	
	}
}
