package me.rainWorld.entity.creature
{
import flash.geom.Point;
import flash.geom.Vector3D;
import flash.utils.Dictionary;

import me.rainWorld.concept.emotion.Emotion;
import me.rainWorld.concept.emotion.EmotionBase;
import me.rainWorld.entity.EntityModel;

/**
 * ...
 * @author Rainssong
 */
dynamic public class CreatureModel extends EntityModel
{
    private var _isAlive:Boolean = false;
    private var _lifetime:Number = 0;
    private var _health:Number = 1;
    private var _hungary:Number = 0;
    private var _energy:Number = 1;

    //可修改为状态机
    protected var _posture:String = "stand";
    protected var _emotion:Emotion = null;

    protected var _items:Array = [];

    protected var _intelligence:Number = 0;

    protected var _sex:String = "none";

    protected var _relations:Dictionary = new Dictionary(false);

    public function CreatureModel()
    {
        super();

    }

    public function born():void
    {
        _isAlive = true;
    }

    public function reborn():void
    {
        _isAlive = true;
    }

    public function die():void
    {
        _isAlive = false;
    }

    public function think():void
    {

    }

    public function act():void
    {

    }

    public function feel(information:*):void
    {

    }

    public function grow():void
    {

    }

    public function eat(food:EntityModel):void
    {

    }

    public function release():EntityModel
    {
        return new EntityModel();
    }

    public function getItem(item:EntityModel):void
    {
        _items.push(item);
    }

    public function thowItem(item:EntityModel):void
    {
        var index:int = _items.indexOf(item);
        if (index < 0)
            powerTrace("It's not my item");
        else
        {
            _items.splice(index, 1);
        }
    }

    public function get isAlive():Boolean
    {
        return _isAlive;
    }


    public function get health():Number
    {
        return _health;
    }

    public function set health(value:Number):void
    {
        _health = value;
        if (_health <= 0)
            die();
    }
}

}