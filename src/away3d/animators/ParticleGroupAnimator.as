package away3d.animators
{
	import away3d.animators.data.ParticleGroupEventProperty;
	import away3d.animators.data.ParticleInstanceProperty;
	import away3d.animators.nodes.ParticleNodeBase;
	import away3d.animators.states.AnimationStateBase;
	import away3d.entities.Mesh;
	import away3d.events.ParticleGroupEvent;
	
	/**
	 * ...
	 * @author
	 */
	public class ParticleGroupAnimator extends AnimatorBase
	{
		private var animators:Vector.<ParticleAnimator> = new Vector.<ParticleAnimator>;
		private var animatorTimeOffset:Vector.<int>;
		private var numAnimator:int;
		private var _eventList:Vector.<ParticleGroupEventProperty>;
		
		public function ParticleGroupAnimator(particleAnimationMeshes:Vector.<Mesh>, instanceProperties:Vector.<ParticleInstanceProperty>, eventList:Vector.<ParticleGroupEventProperty>)
		{
			super(null);
			numAnimator = particleAnimationMeshes.length;
			animatorTimeOffset = new Vector.<int>(particleAnimationMeshes.length, true);
			for (var index:int; index < numAnimator; index++)
			{
				var mesh:Mesh = particleAnimationMeshes[index];
				var animator:ParticleAnimator = mesh.animator as ParticleAnimator;
				animators[animators.length] = animator;
				animator.autoUpdate = false;
				if (instanceProperties[index])
					animatorTimeOffset[index] = instanceProperties[index].timeOffset * 1000;
			}
			
			this.eventList = eventList;
		}
		
		/**
		 * Get specific animator with index what was passed into method
		 * @param	index index of animator what will be received
		 * @return 
		 */
		public function getAnimatorOf(index:int):ParticleAnimator
		{
			return animators[index];
		}
		
		public function get eventList():Vector.<ParticleGroupEventProperty> 
		{
			return _eventList;
		}
		
		public function set eventList(value:Vector.<ParticleGroupEventProperty>):void 
		{
			_eventList = value;
		}
		
		override public function start():void
		{
			super.start();
			
			_absoluteTime = 0;
			for (var index:int; index < numAnimator; index++)
			{
				var animator:ParticleAnimator = animators[index];
				//cause the animator.absoluteTime to be 0
				animator.update( -animator.absoluteTime / animator.playbackSpeed + animator.time);
				
				animator.resetTime(_absoluteTime + animatorTimeOffset[index]);
			}
		}
		
		override public function stop():void 
		{
			super.stop();
			
			
			for (var index:int; index < numAnimator; index++)
			{
				var animator:ParticleAnimator = animators[index];
				animator.stop();
			}
		}
		
		override public function dispose():void 
		{
			super.dispose();
			
			for each (var animator:ParticleAnimator in animators)
			{
				animator.dispose();
			}
		}
		
		override protected function updateDeltaTime(dt:Number):void
		{
			_absoluteTime += dt;
			for each (var animator:ParticleAnimator in animators)
			{
				animator.time = _absoluteTime;
			}
			if (eventList)
			{
				for each (var eventProperty:ParticleGroupEventProperty in eventList)
				{
					if (dt != 0 && (eventProperty.occurTime * 1000 - _absoluteTime) * (eventProperty.occurTime * 1000 - (_absoluteTime - dt)) <= 0)
					{
						if (hasEventListener(ParticleGroupEvent.OCCUR))
							dispatchEvent(new ParticleGroupEvent(ParticleGroupEvent.OCCUR, eventProperty));
					}
				}
			}
		}
		
		/**
		 * Reset all animators time to 0
		 */
		public function resetAnimators():void
		{
			for (var index:int; index < numAnimator; index++)
			{
				var animator:ParticleAnimator = animators[index];
				animator.update(0);
			}
		}
		
		public function resetTime(offset:int = 0):void
		{
			for (var index:int; index < numAnimator; index++)
			{
				var animator:ParticleAnimator = animators[index];
				animator.resetTime(offset + animatorTimeOffset[index]);
			}
		}
	}

}
