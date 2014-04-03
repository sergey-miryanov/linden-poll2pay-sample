package;


import flash.display.Sprite;
import flash.display.Bitmap;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.Lib;

import openfl.Assets;

import ru.zzzzzzerg.linden.Poll2Pay;

class Main extends Sprite
{

  var _showPoll : ColorBtn;

  public function new () {

    super ();

    var token : String = "1a4665c3862abf2b6db2dcdc4ab32fc9";
    var email : String = "zerger@gmail.com";
    var userId : Int = 1;

    Poll2Pay.start(token, email, userId);

    _showPoll = new ColorBtn(0xff00ff00, "Show Poll");
    _showPoll.addEventListener(MouseEvent.CLICK, showPoll);
    _showPoll.x = 50;
    _showPoll.y = 50;

    addChild(_showPoll);

    stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
  }

  function onKeyUp(event : KeyboardEvent)
  {
    switch(event.keyCode)
    {
      case Keyboard.ESCAPE:
        Lib.exit();
    }
  }

  function showPoll(e : MouseEvent)
  {
    if(Poll2Pay.isEnabled())
    {
      Poll2Pay.showPoll();
    }
    else
    {
      _showPoll.label.text = "DISABLED";
    }
  }


}

class ColorBtn extends Sprite
{
  public var enabled : Bool;
  public var label : TextField;
  public var color : Int;

  private static var WIDTH : Int = 64;
  private static var HEIGHT : Int = 64;

  public function new(color : Int, text : String, ?enabled : Bool = true)
  {
    super();

    this.enabled = enabled;
    this.color = color;
    this.label = new TextField();
    this.label.x = 10;
    this.label.y = HEIGHT / 3.0;
    this.label.text = text;
    this.label.selectable = false;

    addChild(this.label);
    setEnabled(enabled);
  }

  private function fill(clr : Int)
  {
    graphics.beginFill(clr);
    graphics.drawRect(0, 0, width, HEIGHT);
    graphics.endFill();
  }

  public function setEnabled(e : Bool)
  {
    this.enabled = e;
    if(this.enabled)
    {
      fill(color);
      this.useHandCursor = true;
      this.mouseEnabled = true;
    }
    else
    {
      fill(0xaaaaaa);
      this.useHandCursor = false;
      this.mouseEnabled = false;
    }
  }

}

