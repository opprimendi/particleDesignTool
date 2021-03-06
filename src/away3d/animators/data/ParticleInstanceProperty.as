package away3d.animators.data
{
	import away3d.animators.ParticleAnimator;
	import away3d.entities.Mesh;
	
	import flash.geom.Vector3D;
	
	public class ParticleInstanceProperty
	{
		private static const DEFAULT_ZERO:Vector3D = new Vector3D;
		private static const DEFAULT_ONE:Vector3D = new Vector3D(1, 1, 1);
		
		private var _position:Vector3D;
		private var _rotation:Vector3D;
		private var _scale:Vector3D;
		private var _playSpeed:Number;
		
		//Todo:this property can't be set to the _particleMesh.animator
		private var _timeOffset:Number;
		
		public function get timeOffset():Number
		{
			return _timeOffset;
		}
		
		public function get playSpeed():Number 
		{
			return _playSpeed;
		}
		
		
		public function ParticleInstanceProperty(position:Vector3D, rotation:Vector3D, scale:Vector3D, timeOffset:Number, playSpeed:Number)
		{
			_position = position ? position : DEFAULT_ZERO;
			_rotation = rotation ? rotation : DEFAULT_ZERO;
			_scale = scale ? scale : DEFAULT_ONE;
			_timeOffset = timeOffset;
			_playSpeed = playSpeed;
		}
		
		public function apply(_particleMesh:Mesh):void
		{
			_particleMesh.x = _position.x;
			_particleMesh.y = _position.y;
			_particleMesh.z = _position.z;
			
			_particleMesh.rotationX = _rotation.x;
			_particleMesh.rotationY = _rotation.y;
			_particleMesh.rotationZ = _rotation.z;
			
			_particleMesh.scaleX = _scale.x;
			_particleMesh.scaleY = _scale.y;
			_particleMesh.scaleZ = _scale.z;
			
			(_particleMesh.animator as ParticleAnimator).playbackSpeed = _playSpeed;
		}
	}
}
