rain's as3 lib!
===============

Contains my as3 collection and my own lib (me.rainssong.*)


me.rainssong.*:

powerTrace.as		//You will love it

---air
AirManager.as //Empty

---application
ApplicationBase.as	//MutiLayerSprite
ApplicationManager.as	//AppMode

---controls
IToggleBtn.as		
LowLightBtn.as:		//iOS style btn, need bundling	
MyCheckBox.as:		//MovieClip as CheckBox
MyRadioBtn.as:		//MovieClip as RadioBtn
MyRadioButtonGroup.as
RainCheckBox.as
RainSlider.as:		//Sprite as RadioBtn
ZoomBtn.as：		//Auto Zoom
Scale9SimpleStateButton.as	//

---display
AbstructDragableSprite.as	//dont instantiate this
BitmapDataCore.as:		//Opration BMD
DisplayObjectTransfer.as	//Get display instant by url|ClassName|Class
IDragableView.as		
ISlide.as		
IView.as
LCDRender.as
MouseDragableSprite.as		//
MouseDragSprite.as		//Start drag when mouseDown
MouseInteractiveSprite.as	//Save dragSpeed,dispatch MouseInteractiveEvent.Swipe
MouseRotatableSprite.as		//Rotate when drag
MouseScrollableSprite.as	//
MouseTargetScrollableSprite.as	//
MyMovieClip.as			//Out-of-date
MySprite.as			//Out-of-date
RestoreLocationSprite.as	//AutoRestoreLocation
Scale9BitmapSprite.as		

Slide.as			//Out-of-date
SlideShow.as			//Out-of-date
SmartMovieClip.as		//Auto destroy, listen add/resize
SmartSprite.as:			//Auto destroy, listen add/resize
SpeedRotatableSprite.as
TargetRotatableSprite.as
ToolTip.as			//
---events
ApplicationEvent.as		//Login/Logout Init/Exit
DataEvent.as			//Out-of-date,ObjectEvent instead
DragEvent.as			//
GameEvent.as			
MouseInteractiveEvent.as	//with SwipeGesture
ObjectEvent.as
QuestEvent.as			//with QuestModel
SlideEvent.as
StaticEventDispatcher.as	//Out-of-date
SwitchSceneEvent.as

---font
FontLibrary.as			
MSYH.as

---manager
EventBus.as			//Global EventDispatcher
KeyboardManager.as:		//Manage Keyboard event
MouseManager.as			//
SingletonManager.as:		//Get singleton

---math
ArrayCore.as:			//OpitionArray/Vector
BitmapHitTestPlus.as		
HitTest.as			
MathCore.as:			//more math function	

---media
RainStageWebView.as		//addChild to DisplayObject

---net
ResumeDownloader.as

---quest
XmlQuestManager.as

	---VO
	QuestModel.as		//Save Quest Here

---rainMVC
---controller
---model
Model.as			//Developing
Proxy.as			//Developing
RangeNumberModel.as		

---view
Mediator.as			//Developing
TipTextFieldMediator.as		

---rainSlideShow
IRainSlide.as
RainSlide.as
RainSlideShow.as:		//Powerful Slide Show

---robotlegs
---controller
SwitchSceneCommand.as		

---sound
SoundPlayer.as

---system
SystemManager.as		

---text
HtmlText.as:Create htmltext

---tools
---utils
Color.as:140 colors
DebugPanel.as
deepCopy.as
Directions.as
functionTiming.as
LocalTimer.as:accurate timer
Locations.as			
Logger.as			//
StringCore.as			//
superTrace.as:			//out-of-date, powerTrace instead
timeoutTrace.as			//
