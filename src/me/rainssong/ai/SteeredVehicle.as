package  me.rainssong.ai
{
	import me.rainssong.geom.Vector2D;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	
	public class SteeredVehicle extends Vehicle
	{
		private var _maxForce:Number = 1;
		/**
		 * 转向力
		 */
		private var _steeringForce:Vector2D;
		public var cx:Number=0;
		private var _arrivalThreshold:Number = 100;
		private var _wanderAngle:Number = 0;
		private var _wanderDistance:Number = 10;
		private var _wanderRadius:Number = 5;
		private var _wanderRange:Number = 1;
		private var _avoidDistance:Number = 300;
		private var _avoidBuffer:Number = 20;
		private var _pathIndex:int = 0;
		private var _pathThreshold:Number = 20;
		private var _inSightDist:Number = 200;
		private var _tooCloseDist:Number = 60;
		
		public function SteeredVehicle()
		{
			_steeringForce = new Vector2D();
			super();
		}
		
		public function set maxForce(value:Number):void
		{
			_maxForce = value;
		}
		
		public function get maxForce():Number
		{
			return _maxForce;
		}
		
		/**
		 * 追踪
		 * @param	target
		 */
		public function seek(target:Vector2D):void
		{
			//计算 目标速度
			var desiredVelocity:Vector2D = target.subtract(_position);
			desiredVelocity.normalize();
			desiredVelocity = desiredVelocity.multiply(_maxSpeed);
			
			//计算转向力
			var force:Vector2D = desiredVelocity.subtract(_velocity);
			_steeringForce = _steeringForce.add(force);
		}
		
		/**
		 * 追捕
		 * @param	target
		 */
		public function pursue(target:Vehicle):void
		{
			var lookAheadTime:Number = position.dist(target.position) / _maxSpeed;
			var predictedTarget:Vector2D = target.position.add(target.velocity.multiply(lookAheadTime));
			seek(predictedTarget);
		}
		
		/**
		 * 漫游
		 */
		public function wander():void
		{
			var center:Vector2D = velocity.clone().normalize().multiply(_wanderDistance);
			var offset:Vector2D = new Vector2D(0);
			offset.length = _wanderRadius;
			offset.degree = _wanderAngle;
			_wanderAngle += Math.random() * _wanderRange - _wanderRange * .5;
			var force:Vector2D = center.add(offset);
			_steeringForce = _steeringForce.add(force);
		}
		
		/**
		 * 反追捕
		 * @param	target
		 */
		public function evade(target:Vehicle):void
		{
			var lookAheadTime:Number = position.dist(target.position) / _maxSpeed;
			var predictedTarget:Vector2D = target.position.add(target.velocity.multiply(lookAheadTime));
			flee(predictedTarget);
		}
		
		/**
		 * 到达
		 * @param	target
		 */
		public function arrive(target:Vector2D):void
		{
			var desiredVelocity:Vector2D = target.subtract(_position);
			desiredVelocity.normalize();
			var dist:Number = _position.dist(target);
			if (dist > _arrivalThreshold)
			{
				desiredVelocity = desiredVelocity.multiply(_maxSpeed);
			}
			else
			{
				
				desiredVelocity = desiredVelocity.multiply(_maxSpeed * dist / _arrivalThreshold);
			}
			var force:Vector2D = desiredVelocity.subtract(_velocity);
			_steeringForce = _steeringForce.add(force);
		}
		
		/**
		 * 避开
		 * @param	target
		 */
		public function flee(target:Vector2D):void
		{
			var desiredVelocity:Vector2D = target.subtract(_position);
			desiredVelocity.normalize();
			desiredVelocity = desiredVelocity.multiply(_maxSpeed);
			var force:Vector2D = desiredVelocity.subtract(_velocity);
			_steeringForce = _steeringForce.subtract(force);
		}
		
		override public function update():void
		{
			_steeringForce.truncate(_maxForce);
			//_steeringForce = _steeringForce.divide(_mass);
			var f:Number = cx * _velocity.lengthSQ;
			var fForce:Vector2D = _velocity.multiply(cx);
			
			
			_velocity = _velocity.add(_steeringForce.divide(_mass));
			_velocity = _velocity.subtract(fForce.divide(_mass));
			
			
			_steeringForce = new Vector2D();
			super.update();
		}
		
		/**
		 * 绕开
		 * @param	circles
		 */
		public function avoid(circles:Array):void
		{
			for (var i:int = 0; i < circles.length; i++)
			{
				var circle:Circle = circles[i] as Circle;
				var heading:Vector2D = _velocity.clone().normalize();
				// 障碍物和机车间的位移向量
				var difference:Vector2D = circle.position.subtract(_position);
				var dotProd:Number = difference.dotProd(heading);
				
				// 如果障碍物在机车前方
				if (dotProd > 0)
				{
					// 机车的“触角”
					var feeler:Vector2D = heading.multiply(_avoidDistance);
					// 位移在触角上的映射
					var projection:Vector2D = heading.multiply(dotProd);
					// 障碍物离触角的距离
					var dist:Number = projection.subtract(difference).length;
					// 如果触角（在算上缓冲后）和障碍物相交
					// 并且位移的映射的长度小于触角的长度
					// 我们就说碰撞将要发生，需改变转向
					if (dist < circle.radius + _avoidBuffer && projection.length < feeler.length)
					{
						// 计算出一个转90 度的力
						var force:Vector2D = heading.multiply(_maxSpeed);
						force.radians += difference.sign(_velocity) * Math.PI / 2;
						// 通过离障碍物的距离，调整力度大小，使之足够小但又能避开
						force = force.multiply(1.0 - projection.length / feeler.length);
						// 叠加于转向力上
						_steeringForce = _steeringForce.add(force);
						// 刹车——转弯的时候要放慢机车速度，离障碍物越接近，刹车越狠。
						_velocity = _velocity.multiply(projection.length / feeler.length);
					}
				}
				
			}
		}
		
		/**
		 * 路线
		 * @param	path
		 * @param	loop
		 */
		public function followPath(path:Array, loop:Boolean = false):void
		{
			var wayPoint:Vector2D = path[_pathIndex];
			if (wayPoint == null)
				return;
			if (_position.dist(wayPoint) < _pathThreshold)
			{
				if (_pathIndex >= path.length - 1)
				{
					if (loop)
					{
						_pathIndex = 0;
					}
				}
				else
				{
					_pathIndex++;
				}
			}
			if (_pathIndex >= path.length - 1 && !loop)
			{
				arrive(wayPoint);
			}
			else
			{
				seek(wayPoint);
			}
		}
		
		public function flock(vehicles:Array):void
		{
			var averageVelocity:Vector2D = _velocity.clone();
			var averagePosition:Vector2D = new Vector2D();
		
			var inSightCount:int = 0;
			for (var i:int = 0; i < vehicles.length; i++)
			{
				var vehicle:Vehicle = vehicles[i] as Vehicle;
				if (vehicle != this && inSight(vehicle))
				{
					averageVelocity = averageVelocity.add(vehicle.velocity);
					averagePosition = averagePosition.add(vehicle.position);
					if (tooClose(vehicle))
						flee(vehicle.position);
					inSightCount++;
				}
			}
			if (inSightCount > 0)
			{
				averageVelocity = averageVelocity.divide(inSightCount);
				averagePosition = averagePosition.divide(inSightCount);
				seek(averagePosition);
				_steeringForce.add(averageVelocity.subtract(new Vector2D(inSightCount,inSightCount)));
			}
		}
		
		public function inSight(vehicle:Vehicle):Boolean
		{
			if (_position.dist(vehicle.position) > _inSightDist)
				return false;
			var heading:Vector2D = _velocity.clone().normalize();
			var difference:Vector2D = vehicle.position.subtract(_position);
			var dotProd:Number = difference.dotProd(heading);
			if (dotProd < 0)
				return false;
			return true;
		}
		
		public function tooClose(vehicle:Vehicle):Boolean
		{
			return _position.dist(vehicle.position) < _tooCloseDist;
		}
		
		public function set arriveThreshold(value:Number):void
		{
			_arrivalThreshold = value;
		}
		
		public function get arriveThreshold():Number
		{
			return _arrivalThreshold;
		}
		
		public function set wanderDistance(value:Number):void
		{
			_wanderDistance = value;
		}
		
		public function get wanderDistance():Number
		{
			return _wanderDistance;
		}
		
		public function set wanderRadius(value:Number):void
		{
			_wanderRadius = value;
		}
		
		public function get wanderRadius():Number
		{
			return _wanderRadius;
		}
		
		public function set wanderRange(value:Number):void
		{
			_wanderRange = value;
		}
		
		public function get wanderRange():Number
		{
			return _wanderRange;
		}
		
		public function set pathIndex(value:int):void
		{
			_pathIndex = value;
		}
		
		public function get pathIndex():int
		{
			return _pathIndex;
		}
		
		public function set pathThreshold(value:Number):void
		{
			_pathThreshold = value;
		}
		
		public function get pathThreshold():Number
		{
			return _pathThreshold;
		}
		
		public function set inSightDist(vaule:Number):void
		{
			_inSightDist = vaule;
		}
		
		public function get inSightDist():Number
		{
			return _inSightDist;
		}
		
		public function set tooCloseDist(value:Number):void
		{
			_tooCloseDist = value;
		}
		
		public function get tooCloseDist():Number
		{
			return _tooCloseDist;
		}
		
		public function get steeringForce():Vector2D 
		{
			return _steeringForce;
		}
		
		public function set steeringForce(value:Vector2D):void 
		{
			_steeringForce = value;
		}
	}
}

