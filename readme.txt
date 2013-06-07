rain's as3 lib!
===============

Contains my as3 collection and my own lib (me.rainssong.*)


me.rainssong.*:

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

---display
AbstructDragableSprite.as		//dont create instant
BitmapDataCore.as:		//Opration BMD
DisplayObjectTransfer.as	//Get display instant by url|ClassName|Class
IDragableView.as		
ISlide.as		
IView.as
LCDRender.as
MouseDragableSprite.as
MouseDragSprite.as
MouseInteractiveSprite.as
MouseRotatableSprite.as
MouseScrollableSprite.as
MouseTargetScrollableSprite.as
MyMovieClip.as			//Out-of-date
MySprite.as			//Out-of-date
RestoreLocationSprite.as	//AutoRestoreLocation
Scale9BitmapSprite.as
Scale9SimpleStateButton.as
Slide.as			//Out-of-date
SlideShow.as			//Out-of-date
SmartMovieClip.as		//Auto destroy, listen add/resize
SmartSprite.as:			//Auto destroy, listen add/resize
SpeedRotatableSprite.as
TargetRotatableSprite.as
ToolTip.as
---events
ApplicationEvent.as
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
EventBus.as
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
QuestModel.as

---rainMVC
---controller
---model
Model.as
Proxy.as
RangeNumberModel.as

---view
Mediator.as
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
