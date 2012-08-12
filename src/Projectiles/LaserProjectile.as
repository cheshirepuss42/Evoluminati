package Projectiles 
{	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	public class LaserProjectile extends Projectile
	{
		//todo: make the laser have pixel perfect collision, so make the mask appropriate
		public var bmd:BitmapData
		public var maskX:Number;
		public var maskY:Number;
		public var maskOrigin:Point
		public var img:Image;
		public var timer:Number = 0;
		public function LaserProjectile() 
		{
			super();

			
		}
		public function init(g:GameInfo,sX:int, sY:int, tX:int, tY:int, speed:Number, range:int, damage:int, damageType:String = "normal", energyCost:int = 1):void		
		{
			super._init(g,sX, sY, tX, tY, 0, range, energyCost);			
			img = new Image(GI.gfx["LaserBeam"]);// Image.createRect(10, 10, 0x00ff00, 0.2);
			img.alpha = 0.7;
			img.centerOrigin();
			img.originY = G.size;
			
			
			//var size:Number = FP.distance(sX, sY, tX, tY);
			img.scaleY = range / G.size;
			img.scaleX = 0.4;
			img.alpha = 1;
			//img.y -= size / 2;
			//img.centerOrigin();
			
			
			//img.originY = img.y + img.scaledHeight;
			img.angle = -90 + FP.angle(sX, sY, tX, tY);
			//bmd = new BitmapData(Math.abs(tX - sX), Math.abs(tY - sY), true, 0);
			//createMask();
			//img.render(bmd, FP.zero, FP.zero);
			//this.mask = new Pixelmask(bmd);
			//var sp:Sprite = new Sprite();
			//mask.renderDebug(sp);

			//trace("firing laser",bmd.width,bmd.height);
			graphic = img;
		}
		//public function set angle(value:Number):void 
		//{
		// this first line sets the Entity's graphic to the angle passed in
			//img.angle = value;
		// we want to clear the maskBMD (completely transparent / no pixel data)
			//bmd.fillRect(maskBmp.rect, 0);
		// the Entity's graphic was centered initially, so we need to offset the
		// point from which we are rendering.  FP.point is just a reusable Point
		// that saves the overhead of creating a new Point.
			//FP.point.x = maskBmp.width / 2;
			//FP.point.y = maskBmp.height / 2;
		// this last line renders the pixels currently in the Entity's graphic's buffer
		// to the given target which is the maskBmp.
			//img.render(maskBmp, FP.point, FP.zero);
		//}		
		protected function createMask():void
		{
			if (bmd) bmd.dispose();
			
			var size:int = Math.ceil(Math.sqrt(img.scaledWidth * img.scaledWidth + img.scaledHeight * img.scaledHeight));
			bmd = new BitmapData(size, size, true, 0);
			//
			//maskX = maskY = size * 0.5;// = new Point(size * 0.5, size * 0.5);
			maskOrigin = new Point(img.originX, img.originY);
			//FP.point.x = FP.point.y = maskX = maskY = size * 0.5;
			graphic.render(bmd, maskOrigin, FP.zero);
			//
			mask = new Pixelmask(bmd, -maskOrigin.x, -maskOrigin.y);
			//img.centerOrigin();
		}
			//
			override public function removed():void
			{
				bmd.dispose();
			}
		override public function update():void
		{
			super.update();
			timer += FP.elapsed;
			if (timer > 0.3)
			{
				this.collidable = false;
				img.alpha -= 5 * FP.elapsed;				
				//world.recycle(this);
			}
			if (img.alpha <= 0)
				world.recycle(this);
			if (bmd) 
			{
				//bmd.fillRect(bmd.rect, 0);
				//graphic.render(bmd, FP.point.clone(), FP.zero);
			}				
			//move();
		}
		//protected var _gfk:*;
		//protected var _maskBMD:BitmapData;
		//protected var _maskOffset:Point;
		//protected var _useMask:Boolean;
		//protected var _center:Boolean;
//



		//public function PixelPerfectEntity()
		//{
			//super();
		//}
//
		///**
		 //* Creates the BitmapData Object used for the PixelMask
		 //* 
		 //* @param	alphaThreshold	the alpha threshold to be used by the pixelMask. 0-255.
		 //*/
		//protected function createMask(alphaThreshold:Number = 8):void
		//{
			//if (_maskBMD) _maskBMD.dispose();
			//
			//var size:int = Math.ceil(Math.sqrt(_gfk.scaledWidth * _gfk.scaledWidth + _gfk.scaledHeight * _gfk.scaledHeight));
			//var halfSize:Number = size * 0.5;
			//_maskBMD = new BitmapData(size, size, true, 0);
			//
			//_maskOffset = new Point;
			//if (_center) {
				//_gfk.centerOrigin();
				//_maskOffset.x = _maskOffset.y = halfSize;
			//} else {
				//_maskOffset.x = ( -halfSize + (_gfk.width * 0.5)) * -1 + _gfk.originX;
				//_maskOffset.y = ( -halfSize + (_gfk.height * 0.5)) * -1 + _gfk.originY;
			//}
			//graphic.render(_maskBMD, _maskOffset, FP.zero);
			//
			//mask = new Pixelmask(_maskBMD, -_maskOffset.x, -_maskOffset.y);
			//Pixelmask(mask).threshold = alphaThreshold;
		//}
//
		//override public function update():void
		//{
			//if (_maskBMD) {
				//_maskBMD.fillRect(_maskBMD.rect, 0);
				//graphic.render(_maskBMD, _maskOffset, FP.zero);
			//}
		//}		
		//override public function render():void
		//{
			//trace(x,y,sourceX, sourceY,targetX,targetY);
			//Draw.setTarget(bmd, FP.zero);			
			//Draw.linePlus(sourceX, sourceY, targetX, targetY, 0xFF00FF00, 0.7, 15);
			//Draw.circlePlus(sourceX, sourceY, 50);
			//super.render();
		//}	
	}

}